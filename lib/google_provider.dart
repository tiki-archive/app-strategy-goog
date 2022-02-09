import 'package:flutter/material.dart';
import 'package:google_provider/src/google_provider_service.dart';
import 'package:google_provider/src/google_provider_style.dart';

class GoogleProvider {
  late final GoogleProviderService _service;

  GoogleProvider({
    GoogleProviderStyle? style,
    onLink,
    onUnlink,
    onSee,
  }) :
    _service = GoogleProviderService(
        onLink: onLink,
        onUnlink: onUnlink,
        onSee: onSee,
        style: style ?? GoogleProviderStyle()
    );

  Widget accountButton() =>
      _service.presenter.accountButton();
}
