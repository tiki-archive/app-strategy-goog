/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'error_model_rsp_detail.dart';
import 'error_model_rsp_error.dart';

class ErrorModelRsp {
  int? code;
  String? message;
  String? status;
  List<ErrorModelRspError>? errors;
  List<ErrorModelRspDetail>? details;

  ErrorModelRsp(
      {this.code, this.message, this.status, this.errors, this.details});

  ErrorModelRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      code = json['code'];
      message = json['message'];
      status = json['status'];
      if (json['errors'] != null) {
        errors = (json['errors'] as List<Map<String, dynamic>>)
            .map((json) => ErrorModelRspError.fromJson(json))
            .toList();
      }
      if (json['details'] != null) {
        details = (json['details'] as List<Map<String, dynamic>>)
            .map((json) => ErrorModelRspDetail.fromJson(json))
            .toList();
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'status': status,
        'errors': errors?.map((e) => e.toJson()).toList(),
        'details': details?.map((e) => e.toJson()).toList()
      };
}
