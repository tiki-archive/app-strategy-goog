import 'package:flutter/material.dart';
import 'src/google_provider_service.dart';
import 'src/google_provider_style.dart';
import 'package:httpp/httpp.dart';

import 'src/model/email/google_provider_model_email.dart';
import 'src/model/google_provider_model.dart';
import 'src/model/info/google_provider_info_model.dart';

class GoogleProvider {
  late final GoogleProviderService _service;

  GoogleProvider(
      {GoogleProviderStyle? style,
      Function(GoogleProviderModel)? onLink,
      Function(String?)? onUnlink,
      Httpp? httpp})
      : _service = GoogleProviderService(
            httpp: httpp,
            onLink: onLink,
            onUnlink: onUnlink,
            style: style ?? GoogleProviderStyle());

  GoogleProvider.loggedIn({
        required email,
        required token,
        String? displayName,
        String? refreshToken,
        GoogleProviderStyle? style,
        Function(GoogleProviderModel)? onLink,
        Function(String?)? onUnlink,
        Function(List<GoogleProviderInfoModel>)? onSee,
        Httpp? httpp}){
    _service = GoogleProviderService(
        model: GoogleProviderModel(
          isLinked: true,
          email : email,
          token : token,
          displayName : displayName,
          refreshToken : refreshToken,
        ),
        httpp: httpp,
        onLink: onLink,
        onUnlink: onUnlink,
        style: style ?? GoogleProviderStyle());
  }

  Widget accountWidget() => _service.presenter.accountButton();

  void sendEmail(
      {String? body,
      required String to,
      String? subject,
      Function(bool)? onResult}) {
    _service.email.send(
        body: body, to: to, subject: subject, onResult: onResult);
  }

  Future<void> fetchInbox(
      {DateTime? since,
      required Function(List<String> messagesIds) onResult,
      required Function() onFinish}) => _service.email.fetchInbox(
        since: since, onResult: onResult, onFinish: onFinish);

  Future<void> fetchMessages(
      {required List<String> messageIds,
      required Function(GoogleProviderModelEmail message) onResult,
      required Function() onFinish}) =>
    _service.email.fetchMessages(
        messageIds: messageIds, onResult: onResult, onFinish: onFinish);
}
