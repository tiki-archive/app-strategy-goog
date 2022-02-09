import 'dart:io';

class GoogleProviderConfig{
  static const String redirectUri = "com.mytiki.app:/oauth";
  static const String androidClientId = "240428403253-8bof2prkdatnsm8d2msgq2r81r12p5np.apps.googleusercontent.com";
  static const String iosClientId = "240428403253-v4qk9lt2l07cc8am12gggocpbbsjdvl7.apps.googleusercontent.com";
  static const String authorizationEndpoint = "https://accounts.google.com/o/oauth2/v2/auth";
  static const String tokenEndpoint = "https://www.googleapis.com/oauth2/v4/token";
  static const String discoveryUrl = "https://accounts.google.com/.well-known/openid-configuration";
  static const String userinfoEndpoint = "https://www.googleapis.com/oauth2/v1/userinfo?alt=json";
  static const List<String> scopes = [
    "openid",
    "https://www.googleapis.com/auth/userinfo.profile",
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/gmail.readonly",
    "https://www.googleapis.com/auth/gmail.send"
  ];
  static get clientId =>  Platform.isIOS ? iosClientId : androidClientId;
}