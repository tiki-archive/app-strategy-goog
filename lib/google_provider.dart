import 'package:flutter/material.dart';
import 'package:google_provider/src/google_provider_service.dart';
import 'package:google_provider/src/google_provider_style.dart';
import 'package:httpp/httpp.dart';

import 'src/model/google_provider_model.dart';
import 'src/model/info/google_provider_info_model.dart';

class GoogleProvider {
  late final GoogleProviderService _service;

  GoogleProvider({
    GoogleProviderStyle? style,
    Function(GoogleProviderModel)? onLink,
    Function(String?)? onUnlink,
    Function(List<GoogleProviderInfoModel>)? onSee,
    Httpp? httpp
  }) :
    _service = GoogleProviderService(
        httpp: httpp,
        onLink: onLink,
        onUnlink: onUnlink,
        onSee: onSee,
        style: style ?? GoogleProviderStyle()
    );

  Widget accountWidget() =>
      _service.presenter.accountButton();

}
