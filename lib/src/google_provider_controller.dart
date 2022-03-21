import 'package:flutter/material.dart';
import 'package:google_provider/src/google_provider_service.dart';

class GoogleProviderController {
  final GoogleProviderService service;

  GoogleProviderController(this.service);

  Future<void> signIn() async {
    service.signIn();
  }

  void signOut() {
    service.signOut();
  }

  void seeInfo(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => service.seeInfo()));
  }
}
