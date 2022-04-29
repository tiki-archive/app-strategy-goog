/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'error_model_rsp.dart';

class ErrorHttp extends Error {
  final ErrorModelRsp rsp;
  ErrorHttp(this.rsp);

  @override
  String toString() => "Http error. ${rsp.toJson()}";
}
