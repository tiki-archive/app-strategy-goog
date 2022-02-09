/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../google_provider_service.dart';

class GoogleProviderViewUnlink extends StatelessWidget {
  static const String _text = "Unlink";

  const GoogleProviderViewUnlink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleProviderService service = Provider.of<GoogleProviderService>(context);
    return GestureDetector(
        onTap: service.controller.signOut,
        behavior: HitTestBehavior.opaque,
        child: Container(
            padding: EdgeInsets.only(
                top: service.style.size(15),
                left: service.style.size(18),
                right: service.style.size(18)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _text,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: service.style.text(9.5),
                      color: service.style.unLinkColor),
                ),
                Container(
                    margin: EdgeInsets.only(left: service.style.size(3)),
                    child: Image(
                      image: const AssetImage('res/images/icon-circle-x.png', package: 'google_provider'),
                      height: service.style.text(9.5) * 1.4,
                      fit: BoxFit.fitHeight,
                    )),
              ],
            )));
  }
}
