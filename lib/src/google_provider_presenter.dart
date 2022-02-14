import 'package:provider/provider.dart';

import '../src/google_provider_service.dart';
import 'ui/google_provider_account_widget.dart';

class GoogleProviderPresenter {
  final GoogleProviderService service;

  GoogleProviderPresenter(this.service);

  ChangeNotifierProvider<GoogleProviderService> accountButton(
      {onLink, onUnlink, onSee}) {
    return ChangeNotifierProvider.value(
        value: service, child: const GoogleProviderAccountWidget());
  }
}
