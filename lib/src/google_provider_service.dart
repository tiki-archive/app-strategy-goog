import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:httpp/httpp.dart';

import 'config/google_provider_config.dart';
import 'google_provider_controller.dart';
import 'google_provider_presenter.dart';
import 'google_provider_style.dart';
import 'model/google_provider_model.dart';

class GoogleProviderService extends ChangeNotifier {
  late final GoogleProviderModel model;
  late final GoogleProviderPresenter presenter;
  late final GoogleProviderController controller;
  late final GoogleProviderStyle style;
  final FlutterAppAuth _appAuth;

  GoogleProviderService({
    required this.style, onLink, onUnlink, onSee
  }) :
    _appAuth = FlutterAppAuth() {
      model = GoogleProviderModel();
      presenter = GoogleProviderPresenter(this);
      controller = GoogleProviderController(this);
  }


  Future<void> signIn() async {
    AuthorizationTokenResponse? tokenResponse = await _authorizeAndExchangeCode();
    if (tokenResponse != null) {
      model.token = tokenResponse.accessToken;
      model.accessTokenExpiration =
          tokenResponse.accessTokenExpirationDateTime?.millisecondsSinceEpoch;
      model.refreshToken = tokenResponse.refreshToken;
      HttppRequest(
        uri: Uri.parse(GoogleProviderConfig.userinfoEndpoint),
        verb: HttppVerb.POST,
        headers: HttppHeaders.typical(bearerToken: model.token),
        timeout: const Duration(seconds: 30),
        onSuccess: (response) {
          model.displayName = response.body?.jsonBody['name'];
          model.username = response.body?.jsonBody['id'] ?? response.body?.jsonBody['email'];
          model.email = response.body?.jsonBody['email'];
        },
      );
      model.isLinked = true;
    }
    notifyListeners();
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

}