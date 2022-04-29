/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../error/error_http.dart';
import '../error/error_model_rsp.dart';

class AuthRepository {
  final Logger _log = Logger('AuthRepository');

  static const String _userinfoEndpoint =
      "https://www.googleapis.com/oauth2/v1/userinfo?alt=json";
  static const String _revoveTokenEndpoint =
      "https://oauth2.googleapis.com/revoke?token=";

  Future<void> userInfo(
      {required HttppClient client,
      required String accessToken,
      void Function(dynamic)? onSuccess,
      void Function(Object)? onError}) {
    HttppRequest req = HttppRequest(
        uri: Uri.parse(_userinfoEndpoint),
        verb: HttppVerb.GET,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: const Duration(seconds: 30),
        onSuccess: (rsp) {
          if (onSuccess != null) onSuccess(rsp);
        },
        onResult: onError,
        onError: onError);
    _log.finest('${req.verb.value} — ${req.uri}');
    return client.request(req);
  }

  Future<void> revokeToken(
      {required HttppClient client,
      required String accessToken,
      void Function(dynamic)? onSuccess,
      void Function(Object)? onError}) {
    HttppRequest req = HttppRequest(
        uri: Uri.parse(_revoveTokenEndpoint + accessToken),
        verb: HttppVerb.POST,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: const Duration(seconds: 30),
        onSuccess: (rsp) {
          if (onSuccess != null) onSuccess(rsp);
        },
        onResult: (rsp) {
          ErrorModelRsp body = ErrorModelRsp.fromJson(rsp.body?.jsonBody);
          ErrorHttp error = ErrorHttp(body);
          onError == null ? throw error : onError(error);
        },
        onError: onError);
    _log.finest('${req.verb.value} — ${req.uri}');
    return client.request(req);
  }
}
