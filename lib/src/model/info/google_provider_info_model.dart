/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'google_provider_info_model_content.dart';
import 'google_provider_info_model_cover.dart';

class GoogleProviderInfoModel {
  final GoogleProviderInfoModelCover? cover;
  final GoogleProviderInfoModelContent? content;

  const GoogleProviderInfoModel({this.cover, this.content});
}
