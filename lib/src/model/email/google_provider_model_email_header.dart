/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import 'package:google_provider/src/utils/json/json_object.dart';

class GoogleProviderModelEmailHeader extends JsonObject {
  String? name;
  String? value;

  GoogleProviderModelEmailHeader({this.name, this.value});

  GoogleProviderModelEmailHeader.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      name = json['name'];
      value = json['value'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}
