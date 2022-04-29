/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'tiki_strategy_google_model_company.dart';

class TikiStrategyGoogleModelSender {
  TikiStrategyGoogleModelCompany? company;
  String? name;
  String? email;
  String? category;
  String? unsubscribeMailTo;

  TikiStrategyGoogleModelSender(
      {this.company,
      this.name,
      this.email,
      this.category,
      this.unsubscribeMailTo,
      DateTime? ignoreUntil});

  TikiStrategyGoogleModelSender.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      company = TikiStrategyGoogleModelCompany.fromJson(json['company']);
      name = json['name'];
      email = json['email'];
      category = json['category'];
      unsubscribeMailTo = json['unsubscribe_mail_to'];
    }
  }

  Map<String, dynamic> toJson() => {
        'company': company?.toJson(),
        'name': name,
        'email': email,
        'category': category,
        'unsubscribe_mail_to': unsubscribeMailTo,
      };
}
