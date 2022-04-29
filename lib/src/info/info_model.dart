/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'info_model_content.dart';
import 'info_model_cover.dart';

class InfoModel {
  final InfoModelCover? cover;
  final InfoModelContent? content;

  const InfoModel({this.cover, this.content});
}
