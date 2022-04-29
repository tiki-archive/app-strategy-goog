/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'info_model_content_text.dart';

class InfoModelContentCta {
  final List<InfoModelContentText>? explain;
  final String? buttonText;
  final String? buttonUrl;

  const InfoModelContentCta({this.explain, this.buttonText, this.buttonUrl});
}
