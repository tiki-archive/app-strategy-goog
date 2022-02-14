/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'google_provider_info_model_content_text.dart';

class GoogleProviderInfoModelContentCta{
  final List<GoogleProviderInfoModelContentText>? explain;
  final String? buttonText;
  final String? buttonUrl;

  const GoogleProviderInfoModelContentCta(
      {this.explain, this.buttonText, this.buttonUrl});

}
