/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../error/error_http.dart';
import '../error/error_model_rsp.dart';
import 'auth_controller.dart';
import 'auth_model.dart';
import 'auth_model_status.dart';
import 'auth_presenter.dart';
import 'auth_repository.dart';

class AuthService extends ChangeNotifier {
  final Logger _log = Logger('AuthService');

  static const String _authorizationEndpoint =
      "https://accounts.google.com/o/oauth2/v2/auth";
  static const String _tokenEndpoint =
      "https://www.googleapis.com/oauth2/v4/token";

  static const List<String> _loginScopes = [
    "openid",
    "https://www.googleapis.com/auth/userinfo.profile",
    "https://www.googleapis.com/auth/userinfo.email"
  ];

  static const List<String> _fullScopes = [
    "openid",
    "https://www.googleapis.com/auth/userinfo.profile",
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/gmail.readonly",
    "https://www.googleapis.com/auth/gmail.send"
  ];

  final String _redirectUri;
  final String? _androidClientId;
  final String? _iosClientId;

  AuthModel model;
  late final AuthPresenter presenter;
  late final AuthController controller;

  final Function(AuthModel)? onLink;
  final Function(String?)? onUnlink;
  final Function(
      {String? accessToken,
      DateTime? accessExp,
      String? refreshToken,
      DateTime? refreshExp})? onRefresh;
  final HttppClient client;

  final AuthRepository _repository;
  final FlutterAppAuth _appAuth;

  AuthService(
      {Httpp? httpp,
      model,
      this.onLink,
      this.onUnlink,
      this.onRefresh,
      String? androidClientId,
      String? iosClientId,
      required String redirectUri})
      : model = model ?? AuthModel(),
        _appAuth = const FlutterAppAuth(),
        _androidClientId = androidClientId,
        _iosClientId = iosClientId,
        _redirectUri = redirectUri,
        _repository = AuthRepository(),
        client = httpp == null ? Httpp().client() : httpp.client()
  {
    presenter = AuthPresenter(this);
    controller = AuthController(this);

  }

  Future<void> signIn() async {
    AuthorizationTokenResponse? tokenResponse =
        await _authorizeAndExchangeCode();

    if (tokenResponse != null) {
      _log.finest("authorizeAndExchangeCode success - ${tokenResponse.tokenType}");

      // update the token so user info can be fetched
      // (we need the email to prompt the user straight into the scopes screen)
      model.token = tokenResponse.accessToken;

      // we do this so that model.email is set, which is passed to oauth
      // additional scopes request to skip past choosing account
      await updateUserInfo();

      bool linkedSuccessfully = await signInGrantAdditionalScopes();

      if (linkedSuccessfully) {
        model.linkStatus = AuthModelStatus.LINKED;

        if (onLink != null) onLink!(model);
        notifyListeners();
      }
    }
  }

  Future<bool> signInGrantAdditionalScopes() async {

    model.linkStatus = AuthModelStatus.PENDING_REQUESTING_SCOPES;

    AuthorizationTokenResponse? tokenResponse = await _retrieveAdditionalScopes();

    if (tokenResponse == null) return false;

    model.token = tokenResponse.accessToken;
    model.accessTokenExp = tokenResponse.accessTokenExpirationDateTime;
    model.refreshToken = tokenResponse.refreshToken;

    if (tokenResponse.scopes != null) {
      for (String scope in _fullScopes) {
        if (!tokenResponse.scopes!.contains(scope)) {

          model.linkStatus = AuthModelStatus.PENDING_REQUESTING_SCOPES;

          return false;
        }
      }
      _log.fine("Successfully accepted all scopes");
      return true;
    }

    return false;
  }

  Future<void> updateUserInfo({Function(AuthModel)? onSuccess}) async {
    await _repository.userInfo(
        accessToken: model.token!,
        client: client,
        onSuccess: (response) {

          _log.info("USER INFO ${response?.body?.jsonBody}");

          model.displayName = response?.body?.jsonBody['name'];
          model.email = response?.body?.jsonBody['email'];

          // model.isLinked = true;

          if (onSuccess != null) {
            onSuccess(model);
          }
          notifyListeners();
        },
        onError: (err) {
          if (err is HttppResponse) {
            if (HttppUtils.isUnauthorized(err.statusCode)) {
              _log.warning('Unauthorized. Trying refresh');
              client.denyUntil(err.request!, () async {
                await refreshToken();
                err.request?.headers?.auth(model.token);
              });
            } else {
              ErrorModelRsp body = ErrorModelRsp.fromJson(err.body?.jsonBody);
              throw ErrorHttp(body);
            }
          } else {
            _log.severe(err);
            throw err;
          }
        });
  }

  Future<void> signOut() async {
    await _repository.revokeToken(accessToken: model.token!, client: client);
    if (onUnlink != null) {
      onUnlink!(model.email);
    }
    model = AuthModel();
    notifyListeners();
  }

  Future<void> refreshToken() async {
    try {
      TokenResponse tokenResponse = (await _appAuth.token(TokenRequest(
          _clientId, _redirectUri,
          serviceConfiguration: const AuthorizationServiceConfiguration(
              authorizationEndpoint: _authorizationEndpoint,
              tokenEndpoint: _tokenEndpoint),
          refreshToken: model.refreshToken,
          scopes: _fullScopes)))!;
      model.token = tokenResponse.accessToken;
      model.refreshToken = tokenResponse.refreshToken;
      if (onRefresh != null) {
        onRefresh!(
            accessToken: tokenResponse.accessToken,
            accessExp: tokenResponse.accessTokenExpirationDateTime,
            refreshToken: tokenResponse.refreshToken);
      }
    } catch (err) {
      _log.severe(err.toString());
      rethrow;
    }
  }

  Future<AuthorizationTokenResponse?> _authorizeAndExchangeCode() async {
    AuthorizationServiceConfiguration authConfig =
        const AuthorizationServiceConfiguration(
            authorizationEndpoint: _authorizationEndpoint,
            tokenEndpoint: _tokenEndpoint);
    List<String> providerScopes = _loginScopes; // _scopes;
    return await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(_clientId, _redirectUri,
          promptValues: null,
          serviceConfiguration: authConfig,
          scopes: providerScopes),
    );
  }

  Future<AuthorizationTokenResponse?> _retrieveAdditionalScopes() async {
    AuthorizationServiceConfiguration authConfig =
    const AuthorizationServiceConfiguration(
        authorizationEndpoint: _authorizationEndpoint,
        tokenEndpoint: _tokenEndpoint);

    List<String> providerScopes = _fullScopes;

    model.linkStatus = AuthModelStatus.UNLINKED;

    try {

    _log.fine("LOGIN HINT EMAIL \"${model.email}\"");

      AuthorizationTokenResponse? resp = await _appAuth.authorizeAndExchangeCode(
          AuthorizationTokenRequest(_clientId, _redirectUri,
              promptValues: ["consent"],
              loginHint: model.email,
              serviceConfiguration: authConfig,
              scopes: providerScopes));

      return resp;
    } catch (err) {

      model.linkStatus = AuthModelStatus.UNLINKED;
      _log.warning(err.toString());
      return null;
    }
  }

  String get _clientId => (Platform.isIOS ? _iosClientId : _androidClientId)!;

}
