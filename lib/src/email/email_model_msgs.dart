/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'email_model_msg.dart';

class EmailModelMsgs {
  List<EmailModelMsg>? messages;
  int? resultSizeEstimate;
  String? nextPageToken;

  EmailModelMsgs({this.messages, this.resultSizeEstimate, this.nextPageToken});

  EmailModelMsgs.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      if (json['messages'] != null) {
        messages = (json['messages'] as List)
            .map((json) => EmailModelMsg.fromJson(json))
            .toList();
      }
      resultSizeEstimate = json['resultSizeEstimate'];
      nextPageToken = json['nextPageToken'];
    }
  }

  Map<String, dynamic> toJson() => {
        'messages': messages?.map((e) => e.toJson()).toList(),
        'resultSizeEstimate': resultSizeEstimate,
        'nextPageToken': nextPageToken
      };
}
