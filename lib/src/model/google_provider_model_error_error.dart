/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:google_provider/src/utils/json/json_object.dart';

class GoogleProviderModelErrorError extends JsonObject {
  String? domain;
  String? reason;
  String? message;
  String? locationType;
  String? location;

  GoogleProviderModelErrorError(
      {this.domain,
      this.reason,
      this.message,
      this.locationType,
      this.location});

  GoogleProviderModelErrorError.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      domain = json['domain'];
      reason = json['reason'];
      message = json['message'];
      locationType = json['locationType'];
      location = json['location'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'domain': domain,
        'reason': reason,
        'message': message,
        'locationType': locationType,
        'location': location
      };
}
