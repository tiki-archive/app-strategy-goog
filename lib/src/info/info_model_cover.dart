/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import 'info_model_cover_header.dart';

class InfoModelCover {
  final Image? image;
  final String? subtitle;
  final String? bigTextLight;
  final String? bigTextDark;
  final String? text;
  final InfoModelCoverHeader? header;

  const InfoModelCover(
      {this.image,
      this.subtitle,
      this.bigTextLight,
      this.bigTextDark,
      this.text,
      this.header});
}
