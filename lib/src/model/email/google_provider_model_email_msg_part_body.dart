/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../utils/json/json_object.dart';

class GoogleProviderModelEmailMsgPartBody extends JsonObject {
  String? attachmentId;
  int? size;
  String? data;

  GoogleProviderModelEmailMsgPartBody(
      {this.attachmentId, this.size, this.data});

  GoogleProviderModelEmailMsgPartBody.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      attachmentId = json['attachmentId'];
      size = json['size'];
      data = json['data'];
    }
  }

  @override
  Map<String, dynamic> toJson() =>
      {'attachmentId': attachmentId, 'size': size, 'data': data};
}
