/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'google_provider_info_model_content_icon.dart';
import 'google_provider_info_model_content_text.dart';

class GoogleProviderInfoModelContentBody {
  final List<GoogleProviderInfoModelContentText>? explain;
  final List<GoogleProviderInfoModelContentIcon>? theySay;
  final List<GoogleProviderInfoModelContentIcon>? shouldKnow;

  const GoogleProviderInfoModelContentBody(
      {this.explain, this.theySay, this.shouldKnow});
}
