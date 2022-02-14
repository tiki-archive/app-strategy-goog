/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:google_provider/src/utils/json/json_object.dart';
import 'package:google_provider/src/utils/json/json_utils.dart';

import 'google_provider_model_email_msg.dart';

class GoogleProviderModelEmailMsgs extends JsonObject {
  List<GoogleProviderModelEmailMsg>? messages;
  int? resultSizeEstimate;
  String? nextPageToken;

  GoogleProviderModelEmailMsgs(
      {this.messages, this.resultSizeEstimate, this.nextPageToken});

  GoogleProviderModelEmailMsgs.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      messages = JsonUtils.listFromJson(
          json['messages'], (json) => GoogleProviderModelEmailMsg.fromJson(json));
      resultSizeEstimate = json['resultSizeEstimate'];
      nextPageToken = json['nextPageToken'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'messages': JsonUtils.listToJson(messages),
        'resultSizeEstimate': resultSizeEstimate,
        'nextPageToken': nextPageToken
      };
}
