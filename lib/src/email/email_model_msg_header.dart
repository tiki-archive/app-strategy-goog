/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class EmailModelMsgHeader {
  String? name;
  String? value;

  EmailModelMsgHeader({this.name, this.value});

  EmailModelMsgHeader.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      name = json['name'];
      value = json['value'];
    }
  }

  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}
