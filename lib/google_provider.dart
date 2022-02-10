import 'package:flutter/material.dart';
import 'package:google_provider/src/google_provider_service.dart';
import 'package:google_provider/src/google_provider_style.dart';

import 'src/model/google_provider_model.dart';

class GoogleProvider {
  late final GoogleProviderService _service;

  GoogleProvider({
    GoogleProviderStyle? style,
    Function(GoogleProviderModel)? onLink,
    Function? onUnlink,
    Function? onSee,
    httpp
  }) :
    _service = GoogleProviderService(
        httpp: httpp,
        onLink: onLink,
        onUnlink: onUnlink,
        onSee: onSee,
        style: style ?? GoogleProviderStyle()
    );

  Widget accountButton() =>
      _service.presenter.accountButton();
}
