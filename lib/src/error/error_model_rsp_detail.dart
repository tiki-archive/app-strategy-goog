/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ErrorModelRspDetail {
  String? type;
  String? reason;
  String? domain;
  Map<String, dynamic>? metadata;

  ErrorModelRspDetail({this.type, this.reason, this.domain, this.metadata});

  ErrorModelRspDetail.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      type = json['@type'];
      reason = json['reason'];
      domain = json['domain'];
      metadata = json['metadata'];
    }
  }

  Map<String, dynamic> toJson() =>
      {'@type': type, 'reason': reason, 'domain': domain, 'metadata': metadata};
}
