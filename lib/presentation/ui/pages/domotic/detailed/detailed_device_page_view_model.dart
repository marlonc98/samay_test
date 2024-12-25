import 'package:flutter/material.dart';
import 'package:samay/presentation/ui/pages/domotic/detailed/detailed_device_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';

class DetailedDevicePageViewModel extends ViewModel<DetailedDevicePage> {
  DetailedDevicePageViewModel({required super.context, required super.widget});
  TextEditingController interactionController = TextEditingController();

  void addInteraction(String interaction) {
    final copyInteractions = widget.device.interactions;
    widget.device.interactions = [interaction, ...copyInteractions];
    interactionController.clear();
    notifyListeners();
  }

  void turnDeviceOnOff(bool value) {
    widget.device.on = value;
    addInteraction('Device turned ${value ? 'on' : 'off'}');
    notifyListeners();
  }
}
