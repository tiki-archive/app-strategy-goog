/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'info_model_content_icon.dart';
import 'info_model_content_text.dart';

class InfoModelContentBody {
  final List<InfoModelContentText>? explain;
  final List<InfoModelContentIcon>? theySay;
  final List<InfoModelContentIcon>? shouldKnow;

  const InfoModelContentBody({this.explain, this.theySay, this.shouldKnow});
}
