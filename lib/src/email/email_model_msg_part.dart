/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'email_model_msg_header.dart';
import 'email_model_msg_part_body.dart';

class EmailModelMsgPart {
  String? partId;
  String? mimeType;
  String? filename;
  List<EmailModelMsgHeader>? headers;
  EmailModelMsgPartBody? body;
  List<EmailModelMsgPart>? parts;

  EmailModelMsgPart(
      {this.partId,
      this.mimeType,
      this.filename,
      this.headers,
      this.body,
      this.parts});

  EmailModelMsgPart.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      partId = json['partId'];
      mimeType = json['mimeType'];
      filename = json['filename'];
      body = EmailModelMsgPartBody.fromJson(json['body']);
      if (json['headers'] != null) {
        headers = (json['headers'] as List<Map<String, dynamic>>)
            .map((json) => EmailModelMsgHeader.fromJson(json))
            .toList();
      }
      if (json['parts'] != null) {
        parts = (json['parts'] as List<Map<String, dynamic>>)
            .map((json) => EmailModelMsgPart.fromJson(json))
            .toList();
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'partId': partId,
        'mimeType': mimeType,
        'filename': filename,
        'headers': headers?.map((e) => e.toJson()).toList(),
        'body': body?.toJson(),
        'parts': parts?.map((e) => e.toJson()).toList()
      };
}
