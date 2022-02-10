import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import 'config/google_provider_config.dart';
import 'model/google_provider_model_error_http.dart';
import 'model/google_provider_model_rsp.dart';

class GoogleProviderRepository{

  final Logger _log = Logger('GoogleProviderRepository');

  Future<void> userInfo(
      {required HttppClient client,
        required String? accessToken,
        void Function(dynamic)? onSuccess,
        void Function(Object)? onError}) {
    HttppRequest req = HttppRequest(
        uri: Uri.parse(GoogleProviderConfig.userinfoEndpoint),
        verb: HttppVerb.GET,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: const Duration(seconds: 30),
        onSuccess: (rsp) {
          if (onSuccess != null) onSuccess(rsp);
        },
        onResult: (rsp) {
          GoogleProviderModelRsp body =
          GoogleProviderModelRsp.fromJson(rsp.body?.jsonBody, (json) {});
          GoogleProviderModelErrorHttp error = GoogleProviderModelErrorHttp(body);
          onError == null ? throw error : onError(error);
        },
        onError: onError);
    _log.finest('${req.verb.value} — ${req.uri}');
    return client.request(req);
  }
}