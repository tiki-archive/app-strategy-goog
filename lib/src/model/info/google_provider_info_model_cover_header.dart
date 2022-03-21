/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import 'google_provider_info_model_cover_header_share.dart';

class GoogleProviderInfoModelCoverHeader {
  final Image? image;
  final String? title;
  final GoogleProviderInfoModelCoverHeaderShare? share;

  const GoogleProviderInfoModelCoverHeader(
      {this.image, this.title, this.share});
}
