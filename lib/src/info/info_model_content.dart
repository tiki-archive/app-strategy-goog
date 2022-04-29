/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'info_model_content_body.dart';
import 'info_model_content_cta.dart';

class InfoModelContent {
  final InfoModelContentBody? body;
  final InfoModelContentCta? cta;

  const InfoModelContent({this.body, this.cta});
}
