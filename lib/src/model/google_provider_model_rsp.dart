import 'google_provider_model_message.dart';
import 'google_provider_model_page.dart';

class GoogleProviderModelRsp<T> {
  String? status;
  int? code;
  dynamic data;
  GoogleProviderModelPage? page;
  List<GoogleProviderModelMessage>? messages;

  GoogleProviderModelRsp(
      {this.status, this.code, this.data, this.page, this.messages});

  GoogleProviderModelRsp.fromJson(Map<String, dynamic>? json,
      T Function(Map<String, dynamic>? json) fromJson) {
    if (json != null) {
      status = json['status'];
      code = json['code'];

      if (json['data'] != null) {
        data = json['data'] is List
            ? json['data'].map((e) => fromJson(e)).toList()
            : fromJson(json['data']);
      }

      if (json['page'] != null) {
        page = GoogleProviderModelPage().fromJson(json['page']);
      }

      if (json['messages'] != null) {
        messages = (json['messages'] as List)
            .map((e) => GoogleProviderModelMessage.fromJson(e))
            .toList();
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'data': data?.toJson(),
        'page': page?.toJson(),
        'messages': messages?.map((e) => e.toJson()).toList()
      };
}
