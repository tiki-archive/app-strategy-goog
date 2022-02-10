import 'google_provider_model_rsp.dart';

class GoogleProviderModelErrorHttp extends Error {
    final GoogleProviderModelRsp rsp;
    GoogleProviderModelErrorHttp(this.rsp);

    @override
    String toString() => "Http error. ${rsp.toJson()}";
}
