/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import 'package:google_provider/src/utils/json/json_object.dart';

class GoogleProviderModelEmailMsgHeader extends JsonObject {
  String? name;
  String? value;

  GoogleProviderModelEmailMsgHeader({this.name, this.value});

  GoogleProviderModelEmailMsgHeader.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      name = json['name'];
      value = json['value'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}
