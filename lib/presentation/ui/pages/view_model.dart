import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/domain/states/Localization/localization_state.dart';
import 'package:provider/provider.dart';

class ViewModel<T> with ChangeNotifier {
  T widget;
  BuildContext context;
  GetIt getIt = GetIt.instance;
  late LocalizationState localization;

  ViewModel({required this.context, required this.widget}) {
    this.localization = Provider.of<LocalizationState>(context);
  }
}
