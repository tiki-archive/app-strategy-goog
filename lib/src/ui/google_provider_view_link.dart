import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../google_provider_service.dart';

class GoogleProviderViewLink extends StatelessWidget {
  static const double _scale = 0.9;

  final String _text = "Sign in with Google";

  final onLink;

  const GoogleProviderViewLink({Key? key, this.onLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleProviderService service = Provider.of<GoogleProviderService>(context);
    return GestureDetector(
        onTap: service.controller.onLink,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: service.style.size(8) * _scale),
          height: service.style.size(40) * _scale,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(service.style.size(5) * _scale),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0D000000),
                blurRadius: service.style.size(2),
                offset: Offset(service.style.size(0.75), service.style.size(0.75)), // Shadow position
              ),
            ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Image(
              image: const AssetImage('res/images/google-icon.png', package: 'google_provider'),
              height: service.style.size(18) * _scale,
              fit: BoxFit.fitHeight,
            ),
            Container(
                margin: EdgeInsets.only(left: service.style.size(24) * _scale),
                child: Text(_text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: service.style.size(14) * _scale,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        color: Colors.black54))),
          ]),
        ));
  }
}
