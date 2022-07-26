/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'auth_model_status.dart';

class AuthModel {

  // need two more: mid linking and rejected link


  // bool isLinked = false;

  AuthModelStatus linkStatus;

  String? displayName;
  String? email;
  String? token;
  DateTime? accessTokenExp;
  String? refreshToken;

  AuthModel(
      {//this.isLinked = false,
      this.linkStatus = AuthModelStatus.UNLINKED,
      this.displayName,
      this.email,
      this.token,
      this.accessTokenExp,
      this.refreshToken});
}