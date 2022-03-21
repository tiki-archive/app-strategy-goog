/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../utils/json/json_object.dart';
import '../utils/json/json_utils.dart';
import 'google_provider_model_error_detail.dart';
import 'google_provider_model_error_error.dart';

class GoogleProviderModelError extends JsonObject {
  int? code;
  String? message;
  String? status;
  List<GoogleProviderModelErrorError>? errors;
  List<GoogleProviderModelErrorDetail>? details;

  GoogleProviderModelError(
      {this.code, this.message, this.status, this.errors, this.details});

  GoogleProviderModelError.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      code = json['code'];
      message = json['message'];
      status = json['status'];
      errors = JsonUtils.listFromJson(json['errors'],
          (json) => GoogleProviderModelErrorError.fromJson(json));
      details = JsonUtils.listFromJson(json['details'],
          (json) => GoogleProviderModelErrorDetail.fromJson(json));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'status': status,
        'errors': JsonUtils.listToJson(errors),
        'details': JsonUtils.listToJson(details)
      };
}
