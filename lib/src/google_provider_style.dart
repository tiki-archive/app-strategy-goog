import 'package:flutter/material.dart';

import 'utils/google_provider_utils_styles.dart';

class GoogleProviderStyle extends GoogleProviderUtilsStyle {

  final Color _providerColor;
  final Color _textColor;
  final Color _unLinkColor;
  final Color _infoLinkColor;
  final String _font;

  GoogleProviderStyle({
    Color providerColor = const Color(0xFF797979),
    Color textColor = const Color(0xFF00133F),
    Color unLinkColor = const Color(0xFFFF521C),
    Color infoLinkColor = const Color(0xFF00133F),
    String font = "Arial"
  }) :
        _providerColor = providerColor,
        _textColor = textColor,
        _unLinkColor = unLinkColor,
        _infoLinkColor = infoLinkColor,
        _font = font;

  Color get providerColor => _providerColor;
  Color get textColor => _textColor;
  Color get unLinkColor => _unLinkColor;
  Color get infoLinkColor => _infoLinkColor;
  String get font => _font;
}
