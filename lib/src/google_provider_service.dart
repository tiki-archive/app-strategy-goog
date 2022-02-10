import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import 'config/google_provider_config.dart';
import 'google_provider_controller.dart';
import 'google_provider_presenter.dart';
import 'google_provider_repository.dart';
import 'google_provider_style.dart';
import 'model/google_provider_model.dart';

class GoogleProviderService extends ChangeNotifier {

  final Logger _log = Logger('GoogleProviderService');

  late final GoogleProviderModel model;
  late final GoogleProviderPresenter presenter;
  late final GoogleProviderController controller;
  late final GoogleProviderRepository repository;
  late final GoogleProviderStyle style;
  final FlutterAppAuth _appAuth;
  final HttppClient client;

  GoogleProviderService({
    required this.style,
    required Httpp? httpp,
    onLink, onUnlink, onSee
  }) :
    _appAuth = FlutterAppAuth(),
        client = httpp == null ? Httpp().client() : httpp.client() {
      model = GoogleProviderModel();
      presenter = GoogleProviderPresenter(this);
      controller = GoogleProviderController(this);
      repository = GoogleProviderRepository();
  }


  Future<void> signIn() async {
    AuthorizationTokenResponse? tokenResponse = await _authorizeAndExchangeCode();
    if (tokenResponse != null) {
      _log.finest("authorizeAndExchangeCode success - ${tokenResponse.tokenType}");
      model.token = tokenResponse.accessToken;
      model.accessTokenExpiration =
          tokenResponse.accessTokenExpirationDateTime?.millisecondsSinceEpoch;
      model.refreshToken = tokenResponse.refreshToken;
      await repository.userInfo(
        accessToken: model.token,
        client: client,
        onSuccess: saveUserInfo,
        onError: (e) => print,
      );
      notifyListeners();
    }
  }

  // Future<void> signOut() async {
  //   ApiOAuthInterfaceProvider? provider =
  //   _model.interfaceProviders[account.provider];
  //   if (provider != null) {
  //     await provider.revokeToken(account);
  //   }
  //   await _apiAuthRepositoryAccount.delete(account);
  // }
  //

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


  void saveUserInfo(response) {
      model.displayName = response?.body?.jsonBody['name'];
      model.username = response?.body?.jsonBody['id'] ?? response?.body?.jsonBody['email'];
      model.email = response?.body?.jsonBody['email'];
      model.isLinked = true;
  }
}