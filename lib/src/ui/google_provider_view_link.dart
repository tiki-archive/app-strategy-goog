import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import '../google_provider_service.dart';

class GoogleProviderViewLink extends StatelessWidget {
  final String _text = "Sign in with Google";

  const GoogleProviderViewLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleProviderService service = Provider.of<GoogleProviderService>(context);
    return GestureDetector(
        onTap: service.controller.signIn,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: SizeProvider.instance.size(8)),
          height: SizeProvider.instance.size(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SizeProvider.instance.size(5)),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0D000000),
                blurRadius: SizeProvider.instance.size(2),
                offset: Offset(SizeProvider.instance.size(0.75),
                    SizeProvider.instance.size(0.75)), // Shadow position
              ),
            ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              height: SizeProvider.instance.size(18),
              width: SizeProvider.instance.size(18),
              child: FittedBox(
                fit:BoxFit.fill,
                child: ImgProvider.googleIcon)
            ),
            Container(
                margin: EdgeInsets.only(left: SizeProvider.instance.size(24)),
                child: Text(_text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: SizeProvider.instance.size(14),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        color: Colors.black54))),
          ]),
        ));
  }
}
