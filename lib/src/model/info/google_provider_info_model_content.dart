/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'google_provider_info_model_content_body.dart';
import 'google_provider_info_model_content_cta.dart';

class GoogleProviderInfoModelContent {
  final GoogleProviderInfoModelContentBody? body;
  final GoogleProviderInfoModelContentCta? cta;

  const GoogleProviderInfoModelContent({this.body, this.cta});

}