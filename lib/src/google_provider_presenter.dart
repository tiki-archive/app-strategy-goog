import 'package:provider/provider.dart';

import '../src/google_provider_service.dart';
import 'ui/google_provider_view_link.dart';
import 'ui/google_provider_view_linked.dart';

class GoogleProviderPresenter{
  final GoogleProviderService service;

  GoogleProviderPresenter(this.service);

  ChangeNotifierProvider<GoogleProviderService> accountButton() {
    return ChangeNotifierProvider.value(
        value: service,
        child: service.model.isLinked ?
          const GoogleProviderViewLink() :
          const GoogleProviderViewLinked());
  }
}