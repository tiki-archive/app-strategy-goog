/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:httpp/httpp.dart';
import 'package:tiki_strategy_google/src/auth/auth_model_status.dart';

import 'src/auth/auth_model.dart';
import 'src/auth/auth_service.dart';
import 'src/email/email_service.dart';
import 'tiki_strategy_google_model_email.dart';

export 'src/auth/auth_model.dart';

class TikiStrategyGoogle {
  final AuthService _authService;
  late final EmailService _emailService;

  TikiStrategyGoogle(
      {required String redirectUri,
      String? androidClientId,
      String? iosClientId,
      Function(AuthModel)? onLink,
      Function(String?)? onUnlink,
      Function(
              {String? accessToken,
              DateTime? accessExp,
              String? refreshToken,
              DateTime? refreshExp,
              Object? error})?
          onRefresh,
      Httpp? httpp})
      : _authService = AuthService(
            httpp: httpp,
            onLink: onLink,
            onUnlink: onUnlink,
            onRefresh: onRefresh,
            androidClientId: androidClientId,
            iosClientId: iosClientId,
            redirectUri: redirectUri) {
    _emailService = EmailService(_authService);
  }

  TikiStrategyGoogle.loggedIn(
      {required String redirectUri,
      String? androidClientId,
      String? iosClientId,
      required String? token,
      String? email,
      String? displayName,
      String? refreshToken,
      Function(AuthModel)? onLink,
      Function(String?)? onUnlink,
      Function(
              {String? accessToken,
              DateTime? accessExp,
              String? refreshToken,
              DateTime? refreshExp,
              Object? error})?
          onRefresh,
      Httpp? httpp})
      : _authService = AuthService(
            model: AuthModel(
              linkStatus: AuthModelStatus.LINKED,
              email: email,
              token: token,
              displayName: displayName,
              refreshToken: refreshToken,
            ),
            androidClientId: androidClientId,
            iosClientId: iosClientId,
            redirectUri: redirectUri,
            httpp: httpp,
            onLink: onLink,
            onUnlink: onUnlink,
            onRefresh: onRefresh) {
    _emailService = EmailService(_authService);
  }

  Widget get authButton => _authService.presenter.authButton();

  String? get displayName => _authService.model.displayName;

  Future<void> update({Function(AuthModel)? onUpdate}) async =>
      await _authService.updateUserInfo(onSuccess: onUpdate);

  Future<void> sendEmail(
          {String? body,
          required String to,
          String? subject,
          Function(bool)? onResult}) =>
      _emailService.send(
          body: body, to: to, subject: subject, onResult: onResult);

  Future<void> countInbox(
      {DateTime? since,
        required Function(int totalMessageCount) onResult,
        required Function() onFinish}) =>
      _emailService.countInbox(
          since: since, onResult: onResult, onFinish: onFinish);

  Future<void> fetchInbox(
          {DateTime? since,
          String? page,
          required Function(List<String> messagesIds, {String? page}) onResult,
          required Function() onFinish,
          Function(Object)? onError}) =>
      _emailService.fetchInbox(
          page: page, since: since, onResult: onResult, onFinish: onFinish,
          onError: onError);

  Future<void> fetchMessages(
          {required List<String> messageIds,
          required Function(TikiStrategyGoogleModelEmail message) onResult,
          required Function() onFinish,
            Function(Object)? onError}) =>
      _emailService.fetchMessages(
          messageIds: messageIds, onResult: onResult, onFinish: onFinish, onError: onError);
}
