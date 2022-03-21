import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../google_provider_service.dart';
import 'google_provider_view_link.dart';
import 'google_provider_view_linked.dart';

class GoogleProviderAccountWidget extends StatelessWidget {
  const GoogleProviderAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleProviderService service = Provider.of<GoogleProviderService>(context);
    if (service.model.isLinked) {
      return const GoogleProviderViewLinked();
    }
    return const GoogleProviderViewLink();
  }
}
