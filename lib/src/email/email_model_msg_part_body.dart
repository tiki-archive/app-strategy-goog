/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class EmailModelMsgPartBody {
  String? attachmentId;
  int? size;
  String? data;

  EmailModelMsgPartBody({this.attachmentId, this.size, this.data});

  EmailModelMsgPartBody.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      attachmentId = json['attachmentId'];
      size = json['size'];
      data = json['data'];
    }
  }

  Map<String, dynamic> toJson() =>
      {'attachmentId': attachmentId, 'size': size, 'data': data};
}
