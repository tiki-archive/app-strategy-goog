import 'package:flutter/material.dart';
import 'package:google_provider/src/google_provider_service.dart';
import 'package:google_provider/src/google_provider_style.dart';

class GoogleProvider {
  late final GoogleProviderService _service;

  GoogleProvider({GoogleProviderStyle? style}) :
    _service = GoogleProviderService(style: style ?? GoogleProviderStyle());

  Widget accountButton({onLink, onUnlink, onSee}) =>
      _service.presenter.accountButton(
          onLink: onLink ?? _service.controller.onLink,
          onUnlink: onUnlink ?? _service.controller.onUnlink,
          onSee: onSee ?? _service.controller.onSee
      );
}
