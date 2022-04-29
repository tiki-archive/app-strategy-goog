/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class TikiStrategyGoogleModelCompany {
  String? domain;

  TikiStrategyGoogleModelCompany({this.domain});

  TikiStrategyGoogleModelCompany.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      domain = json['domain'];
    }
  }

  Map<String, dynamic> toJson() => {'domain': domain};
}
