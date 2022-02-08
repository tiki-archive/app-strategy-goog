/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../google_provider_service.dart';

class GoogleProviderViewAccount extends StatelessWidget {

  const GoogleProviderViewAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleProviderService service = Provider.of<GoogleProviderService>(context);
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Image(
        image: const AssetImage('res/images/gogle.png', package: 'google_provider'),
        height: service.style.size(3.5),
        fit: BoxFit.fitHeight,
      ),
      Container(
          margin: EdgeInsets.only(left: service.style.size(2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: service.style.size(0.25)),
                  child: Text("Google",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: service.style.grey,
                          height: 1,
                          fontSize: service.style.text(12)))),
              Text(service.model.email!,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: service.style.blue,
                      height: 1,
                      fontSize: service.style.text(14)))
            ],
          ))
    ]);
  }
}
