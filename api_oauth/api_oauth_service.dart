/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart';
import 'package:httpp/httpp.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../config/config_sentry.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_google/api_google_service.dart';
import '../api_microsoft/api_microsoft_service.dart';
import 'api_oauth_interface_provider.dart';
import 'model/api_oauth_model.dart';
import 'model/api_oauth_model_account.dart';
import 'model/api_oauth_model_provider.dart';
import 'repository/api_oauth_repository_account.dart';
import 'repository/api_oauth_repository_provider.dart';

class ApiOAuthService {
  late final ApiOauthModel _model;
  final FlutterAppAuth _appAuth;
  final ApiOAuthRepositoryAccount _apiAuthRepositoryAccount;
  final ApiOAuthRepositoryProvider _apiAuthRepositoryProvider;
  final ApiAppDataService _apiAppDataService;
  final Httpp httpp;

  static const String PROVIDER_GOOGLE = 'google';
  static const String PROVIDER_MICROSOFT = 'microsoft';

  Map<String, ApiOAuthInterfaceProvider> get interfaceProviders =>
      _model.interfaceProviders;

  ApiOAuthService(
      {required Database database,
      required ApiAppDataService apiAppDataService,
      required Httpp httpp})
      : this._appAuth = FlutterAppAuth(),
        this._apiAuthRepositoryAccount = ApiOAuthRepositoryAccount(database),
        this._apiAuthRepositoryProvider = ApiOAuthRepositoryProvider(),
        this._model = ApiOauthModel(),
        this._apiAppDataService = apiAppDataService,
        this.httpp = httpp {
    _getProviders();
  }


  Future<void> signOutAll() async {
    List<ApiOAuthModelAccount> accounts =
        await _apiAuthRepositoryAccount.getAll();
    accounts.forEach((account) async => await signOut(account));
  }

  Future<ApiOAuthModelAccount?> getAccount() async {
    return await _apiAuthRepositoryAccount.getSingleAccount();
  }

  Future<ApiOAuthModelAccount?> _upsert(ApiOAuthModelAccount account) async {
    String providerName = account.provider!;
    ApiOAuthModelAccount? dbAccount =
        account.provider != null && account.email != null
            ? await _apiAuthRepositoryAccount.getByProviderAndUsername(
                providerName, account.username!)
            : null;
    if (dbAccount != null) {
      account.accountId = dbAccount.accountId;
      return _apiAuthRepositoryAccount.update(account);
    }
    return _apiAuthRepositoryAccount.insert(account);
  }

  Future<void> _getProviders() async {
    Map<String, ApiOAuthModelProvider> repositoryProviders =
        await _apiAuthRepositoryProvider.providers;
    repositoryProviders.forEach((k, v) {
      switch (k) {
        case PROVIDER_GOOGLE:
          _model.interfaceProviders[k] = ApiGoogleService(
              apiAuthService: this,
              apiAppDataService: _apiAppDataService,
              httpp: httpp);
          break;
        case PROVIDER_MICROSOFT:
          _model.interfaceProviders[k] = ApiMicrosoftService(
              apiAuthService: this,
              apiAppDataService: _apiAppDataService,
              httpp: httpp);
          break;
      }
    });
  }

  Future<dynamic> proxy(
      Future<dynamic> Function() request, ApiOAuthModelAccount account) async {
    Response rsp = await request();
    if (HttppUtils.isUnauthorized(rsp.statusCode) &&
        account.refreshToken != null) {
      await refreshToken(account);
      rsp = await request();
    }
    return rsp;
  }

  Future<ApiOAuthModelAccount?> refreshToken(
      ApiOAuthModelAccount account) async {
    try {
      ApiOAuthModelProvider? provider =
      (await _apiAuthRepositoryProvider.providers)[account.provider!];
      TokenResponse tokenResponse = (await _appAuth.token(TokenRequest(
          provider!.clientId, provider.redirectUri,
          //discoveryUrl: provider.discoveryUrl,
          //issuer: 'https://login.microsoftonline.com/common/v2.0',
          serviceConfiguration: AuthorizationServiceConfiguration(
              authorizationEndpoint: provider.authorizationEndpoint,
              tokenEndpoint: provider.tokenEndpoint),
          refreshToken: account.refreshToken,
          scopes: provider.scopes)))!;
      account.accessToken = tokenResponse.accessToken;
      account.refreshToken = tokenResponse.refreshToken;
      _upsert(account);
      return account;
    } catch (e) {
      print(e.toString());
      account.shouldReconnect = 1;
    }
  }

}
