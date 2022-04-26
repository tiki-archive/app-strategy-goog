import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:httpp/httpp.dart';
import 'package:info_carousel/info_carousel.dart';
import 'package:logging/logging.dart';

import 'google_provider_controller.dart';
import 'google_provider_presenter.dart';
import 'google_provider_service_email.dart';
import 'model/google_provider_model.dart';
import 'repository/google_provider_repository_info.dart';
import 'repository/google_provider_repository_oauth.dart';

class GoogleProviderService extends ChangeNotifier {
  final Logger _log = Logger('GoogleProviderService');

  static const String _redirectUri = "com.mytiki.app:/oauth";
  static const String _androidClientId =
      "240428403253-8bof2prkdatnsm8d2msgq2r81r12p5np.apps.googleusercontent.com";
  static const String _iosClientId =
      "240428403253-v4qk9lt2l07cc8am12gggocpbbsjdvl7.apps.googleusercontent.com";
  static const String _authorizationEndpoint =
      "https://accounts.google.com/o/oauth2/v2/auth";
  static const String _tokenEndpoint =
      "https://www.googleapis.com/oauth2/v4/token";
  static const List<String> _scopes = [
    "openid",
    "https://www.googleapis.com/auth/userinfo.profile",
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/gmail.readonly",
    "https://www.googleapis.com/auth/gmail.send"
  ];

  static get _clientId => Platform.isIOS ? _iosClientId : _androidClientId;

  GoogleProviderModel model;
  late final GoogleProviderPresenter presenter;
  late final GoogleProviderController controller;

  final Function(GoogleProviderModel)? onLink;
  final Function(String?)? onUnlink;
  final HttppClient client;

  late final GoogleProviderRepositoryOauth _repository;
  late final GoogleProviderServiceEmail email;
  final FlutterAppAuth _appAuth;

  GoogleProviderService(
      {Httpp? httpp, model, this.onLink, this.onUnlink})
      : model = model ?? GoogleProviderModel(),
        _appAuth = FlutterAppAuth(),
        client = httpp == null ? Httpp().client() : httpp.client() {
    presenter = GoogleProviderPresenter(this);
    controller = GoogleProviderController(this);
    _repository = GoogleProviderRepositoryOauth();
    email = GoogleProviderServiceEmail(this);
  }

  Future<void> signIn() async {
    AuthorizationTokenResponse? tokenResponse =
        await _authorizeAndExchangeCode();
    if (tokenResponse != null) {
      _log.finest(
          "authorizeAndExchangeCode success - ${tokenResponse.tokenType}");
      model.token = tokenResponse.accessToken;
      model.accessTokenExp = tokenResponse.accessTokenExpirationDateTime;
      model.refreshToken = tokenResponse.refreshToken;
      await updateUserInfo();
      notifyListeners();
    }
  }

  Future<void> updateUserInfo() async {
    await _repository.userInfo(
      accessToken: model.token!,
      client: client,
      onSuccess: (response) {
        model.displayName = response?.body?.jsonBody['name'];
        model.email = response?.body?.jsonBody['email'];
        model.isLinked = true;
        if (onLink != null) {
          onLink!(model);
        }
      },
      onError: (e) => print,
    );
  }

  Future<void> signOut() async {
    await _repository.revokeToken(accessToken: model.token!, client: client);
    if (onUnlink != null) {
      onUnlink!(model.email);
    }
    model = GoogleProviderModel();
    notifyListeners();
  }

  Widget seeInfo() {
    List<InfoCarouselCardModel> data =
        GoogleProviderRepositoryInfo.theyKnowInfo;
    return InfoCarousel(cards: data).carouselWidget();
  }

  // TODO handle if token cannot be refreshed
  Future<void> refreshToken() async {
    try {
      TokenResponse tokenResponse = (await _appAuth.token(TokenRequest(
          _clientId, _redirectUri,
          serviceConfiguration: const AuthorizationServiceConfiguration(
              authorizationEndpoint: _authorizationEndpoint,
              tokenEndpoint: _tokenEndpoint),
          refreshToken: model.refreshToken,
          scopes: _scopes)))!;
      model.token = tokenResponse.accessToken;
      model.refreshToken = tokenResponse.refreshToken;
    } catch (e) {
      _log.severe(e.toString());
    }
  }

  Future<AuthorizationTokenResponse?> _authorizeAndExchangeCode() async {
    AuthorizationServiceConfiguration authConfig =
        const AuthorizationServiceConfiguration(
            authorizationEndpoint: _authorizationEndpoint,
            tokenEndpoint: _tokenEndpoint);
    List<String> providerScopes = _scopes;
    return await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(_clientId, _redirectUri,
          promptValues: null,
          serviceConfiguration: authConfig,
          scopes: providerScopes),
    );
  }
}
