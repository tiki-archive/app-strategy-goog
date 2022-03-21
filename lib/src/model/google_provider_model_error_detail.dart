/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../utils/json/json_object.dart';

class GoogleProviderModelErrorDetail extends JsonObject {
  String? type;
  String? reason;
  String? domain;
  Map<String, dynamic>? metadata;

  GoogleProviderModelErrorDetail(
      {this.type, this.reason, this.domain, this.metadata});

  GoogleProviderModelErrorDetail.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      type = json['@type'];
      reason = json['reason'];
      domain = json['domain'];
      metadata = json['metadata'];
    }
  }

  @override
  Map<String, dynamic> toJson() =>
      {'@type': type, 'reason': reason, 'domain': domain, 'metadata': metadata};
}
