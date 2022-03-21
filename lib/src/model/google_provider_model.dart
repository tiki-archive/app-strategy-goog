class GoogleProviderModel {
  bool isLinked = false;
  String? displayName;
  String? email;
  String? token;
  DateTime? accessTokenExp;
  String? refreshToken;

  GoogleProviderModel(
      {this.isLinked = false,
      this.displayName,
      this.email,
      this.token,
      this.accessTokenExp,
      this.refreshToken});
}
