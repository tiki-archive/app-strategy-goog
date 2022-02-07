import 'package:flutter/cupertino.dart';

import 'google_provider_controller.dart';
import 'google_provider_presenter.dart';
import 'google_provider_style.dart';
import 'model/google_provider_model.dart';

class GoogleProviderService extends ChangeNotifier{
  late final GoogleProviderModel model;
  late final GoogleProviderPresenter presenter;
  late final GoogleProviderController controller;
  late final GoogleProviderStyle style;

  GoogleProviderService({
    required this.style
  }){
    model = GoogleProviderModel();
    presenter = GoogleProviderPresenter(this);
    controller = GoogleProviderController();
  }
}