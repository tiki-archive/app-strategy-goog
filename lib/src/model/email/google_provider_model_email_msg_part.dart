/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../utils/json/json_object.dart';
import '../../utils/json/json_utils.dart';
import 'google_provider_model_email_msg_header.dart';
import 'google_provider_model_email_msg_part_body.dart';

class GoogleProviderModelEmailMsgPart extends JsonObject {
  String? partId;
  String? mimeType;
  String? filename;
  List<GoogleProviderModelEmailMsgHeader>? headers;
  GoogleProviderModelEmailMsgPartBody? body;
  List<GoogleProviderModelEmailMsgPart>? parts;

  GoogleProviderModelEmailMsgPart(
      {this.partId,
      this.mimeType,
      this.filename,
      this.headers,
      this.body,
      this.parts});

  GoogleProviderModelEmailMsgPart.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      partId = json['partId'];
      mimeType = json['mimeType'];
      filename = json['filename'];
      headers = JsonUtils.listFromJson(json['headers'],
          (json) => GoogleProviderModelEmailMsgHeader.fromJson(json));
      body = GoogleProviderModelEmailMsgPartBody.fromJson(json['body']);
      parts = JsonUtils.listFromJson(json['parts'],
          (json) => GoogleProviderModelEmailMsgPart.fromJson(json));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'partId': partId,
        'mimeType': mimeType,
        'filename': filename,
        'headers': JsonUtils.listToJson(headers),
        'body': body?.toJson(),
        'parts': JsonUtils.listToJson(parts)
      };
}
