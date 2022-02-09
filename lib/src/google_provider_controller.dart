import 'package:google_provider/src/google_provider_service.dart';

class GoogleProviderController{

  final GoogleProviderService service;

  GoogleProviderController(this.service);

  Future<void> signIn() async {
    await service.signIn();
  }

  void signOut() {
  }

  void seeInfo() {
  }
}