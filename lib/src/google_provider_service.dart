import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:google_provider/src/google_provider_service_email.dart';
import 'package:google_provider/src/model/email/google_provider_model_email_msg.dart';
import 'package:google_provider/src/model/info/google_provider_info_model.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import 'config/google_provider_config.dart';
import 'google_provider_controller.dart';
import 'google_provider_presenter.dart';
import 'repository/google_provider_repository.dart';
import 'google_provider_style.dart';
import 'model/google_provider_model.dart';
import 'repository/google_provider_repository_email.dart';

class GoogleProviderService extends ChangeNotifier {

  final Logger _log = Logger('GoogleProviderService');

  GoogleProviderModel model;
  late final GoogleProviderPresenter presenter;
  late final GoogleProviderController controller;
  late final GoogleProviderRepository _repository;
  late final GoogleProviderStyle style;
  late final GoogleProviderServiceEmail _serviceEmail;
  final Function(GoogleProviderModel)? onLink;
  final Function(String?)? onUnlink;
  final Function(List<GoogleProviderInfoModel>)? onSee;
  final FlutterAppAuth _appAuth;
  final HttppClient client;


  
  GoogleProviderService({
    required this.style,
    required Httpp? httpp,
    this.onLink, this.onUnlink, this.onSee
  }) :
      model = GoogleProviderModel(),
      _appAuth = FlutterAppAuth(),
      client = httpp == null ? Httpp().client() : httpp.client() {
      presenter = GoogleProviderPresenter(this);
      controller = GoogleProviderController(this);
      _repository = GoogleProviderRepository();
      _serviceEmail = GoogleProviderServiceEmail(this);
  }


  Future<void> signIn() async {
    AuthorizationTokenResponse? tokenResponse = await _authorizeAndExchangeCode();
    if (tokenResponse != null) {
      _log.finest("authorizeAndExchangeCode success - ${tokenResponse.tokenType}");
      model.token = tokenResponse.accessToken;
      model.accessTokenExp = tokenResponse.accessTokenExpirationDateTime;
      model.refreshToken = tokenResponse.refreshToken;
      await _repository.userInfo(
        accessToken: model.token!,
        client: client,
        onSuccess: saveUserInfo,
        onError: (e) => print,
      );
      if (onLink != null) {
        onLink!(model);
      }
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _repository.revokeToken(
      accessToken: model.token!,
      client: client);
    if(onUnlink != null){
      onUnlink!(model.email);
    }
    model = GoogleProviderModel();
    notifyListeners();
  }

  void saveUserInfo(response) {
      model.displayName = response?.body?.jsonBody['name'];
      model.email = response?.body?.jsonBody['email'];
      model.isLinked = true;
  }

  void seeInfo() {
    List<GoogleProviderInfoModel> data = _repository.getTheyKnowInfo();
    if(onSee != null) {
      onSee!(data);
    }
  }

  void sendEmail({
    String? body,
    required String to,
    String? subject,
    Function(bool)? onResult
  }){
    _serviceEmail.sendEmail(
        body : body,
        to : to,
        subject : subject,
        onResult : onResult,
    );
  }

  // TODO handle if token cannot be refreshed
  Future<void> refreshToken() async {
    try {
      TokenResponse tokenResponse = (await _appAuth.token(TokenRequest(
          GoogleProviderConfig.clientId, GoogleProviderConfig.redirectUri,
          serviceConfiguration: const AuthorizationServiceConfiguration(
              authorizationEndpoint: GoogleProviderConfig.authorizationEndpoint,
              tokenEndpoint: GoogleProviderConfig.tokenEndpoint),
          refreshToken: model.refreshToken,
          scopes: GoogleProviderConfig.scopes)))!;
      model.token = tokenResponse.accessToken;
      model.refreshToken = tokenResponse.refreshToken;
    } catch (e) {
      _log.severe(e.toString());
    }
  }

  Future<AuthorizationTokenResponse?> _authorizeAndExchangeCode() async {
    AuthorizationServiceConfiguration authConfig = const AuthorizationServiceConfiguration(
        authorizationEndpoint: GoogleProviderConfig.authorizationEndpoint,
        tokenEndpoint: GoogleProviderConfig.tokenEndpoint);
    List<String> providerScopes = GoogleProviderConfig.scopes;
    return await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
          GoogleProviderConfig.clientId,
          GoogleProviderConfig.redirectUri,
          promptValues: null,
          serviceConfiguration: authConfig,
          scopes: providerScopes),
    );
  }


}