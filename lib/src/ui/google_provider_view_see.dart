/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../google_provider_service.dart';


class GoogleProviderViewSee extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    GoogleProviderService service = Provider.of<GoogleProviderService>(context);
    return Container(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: service.style.size(8)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("What data does Google hold",
                style: TextStyle(
                    fontSize: service.style.text(11.5),
                    fontWeight: FontWeight.bold,
                    color: service.style.infoLinkColor)),
            Container(
                margin: EdgeInsets.only(left: service.style.size(8)),
                child: Image(
                  image: const AssetImage('res/images/right-arrow.png', package: 'google_provider'),
                  height: service.style.text(14),
                  fit: BoxFit.fitHeight,
                ))
          ]),
        ));
  }
}
