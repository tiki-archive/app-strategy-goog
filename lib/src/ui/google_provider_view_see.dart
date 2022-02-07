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
          margin: EdgeInsets.symmetric(vertical: 1.75.h),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("What data does Google hold",
                style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.bold,
                    color: ConfigColor.tikiBlue)),
            Container(
                margin: EdgeInsets.only(left: 2.5.w),
                child: Image(
                  image: AssetImage('res/images/right-arrow.png'),
                  height: 14.sp,
                  fit: BoxFit.fitHeight,
                ))
          ]),
        ));
  }
}
