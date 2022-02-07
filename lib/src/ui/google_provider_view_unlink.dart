/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../google_provider_service.dart';

class GoogleProviderViewUnlink extends StatelessWidget {
  static const String _text = "Unlink";
  static const num _fontSize = 9.5;

  const GoogleProviderViewUnlink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleProviderService service = Provider.of<GoogleProviderService>(context);
    return GestureDetector(
        onTap: service.controller.onUnlink,
        behavior: HitTestBehavior.opaque,
        child: Container(
            padding: EdgeInsets.only(
                top: 1.5.h, bottom: 1.5.h, left: 6.w, right: 3.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _text,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: _fontSize.sp,
                      color: ConfigColor.tikiRed),
                ),
                Container(
                    margin: EdgeInsets.only(left: 1.w),
                    child: Image(
                      image: AssetImage('res/images/icon-circle-x.png'),
                      height: (_fontSize * 1.4).sp,
                      fit: BoxFit.fitHeight,
                    )),
              ],
            )));
  }
}
