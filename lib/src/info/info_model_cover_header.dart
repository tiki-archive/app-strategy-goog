/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import 'info_model_cover_header_share.dart';

class InfoModelCoverHeader {
  final Image? image;
  final String? title;
  final InfoModelCoverHeaderShare? share;

  const InfoModelCoverHeader({this.image, this.title, this.share});
}
