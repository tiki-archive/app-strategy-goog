/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ErrorModelRspError {
  String? domain;
  String? reason;
  String? message;
  String? locationType;
  String? location;

  ErrorModelRspError(
      {this.domain,
      this.reason,
      this.message,
      this.locationType,
      this.location});

  ErrorModelRspError.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      domain = json['domain'];
      reason = json['reason'];
      message = json['message'];
      locationType = json['locationType'];
      location = json['location'];
    }
  }

  Map<String, dynamic> toJson() => {
        'domain': domain,
        'reason': reason,
        'message': message,
        'locationType': locationType,
        'location': location
      };
}
