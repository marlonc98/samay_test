import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/presentation/ui/pages/domotic/detailed/detailed_device_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';

class DetailedDevicePageViewModel extends ViewModel<DetailedDevicePage> {
  DetailedDevicePageViewModel({required super.context, required super.widget}) {
    listenInteractions();
  }
  TextEditingController interactionController = TextEditingController();

  void _addInteractionToList(String interaction) async {
    final copyInteractions = widget.device.interactions;
    widget.device.interactions = [interaction, ...copyInteractions];
    interactionController.clear();
    notifyListeners();
  }

  void handleAddInteraction(String interaction) async {
    if (interaction.isEmpty) return;
    BluetoothCharacteristic? characteristic =
        await getCharacteristicWrite(widget.device.deviceBluetooth!);
    if (characteristic == null) return;
    characteristic.write(utf8.encode(interaction));
    _addInteractionToList(interaction);
  }

  Future<BluetoothCharacteristic?> getCharacteristicWrite(
      BluetoothDevice device) async {
    List<BluetoothService>? services =
        await widget.device.deviceBluetooth?.discoverServices();
    if (services == null) return null;
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          return characteristic;
        }
      }
    }
    return null; // Si no se encuentra una característica de escritura
  }

  Future<BluetoothCharacteristic?> getCharactiristicRead(
      BluetoothDevice device) async {
    List<BluetoothService>? services =
        await widget.device.deviceBluetooth?.discoverServices();
    if (services == null) return null;
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.notify) {
          return characteristic;
        }
      }
    }
    return null; // Si no se encuentra una característica de lectura
  }

  void listenInteractions() async {
    BluetoothCharacteristic? characteristic =
        await getCharactiristicRead(widget.device.deviceBluetooth!);
    print(
        "DetailedDevicePageViewModel listenInteractions characteristics $characteristic");
    if (characteristic == null) {
      print("DetailedDevicePageViewModel no characteistics");
      return;
    }
    // Convertir los datos a bytes
    characteristic.setNotifyValue(true);
    characteristic.lastValueStream.listen((List<int> value) {
      print("DetailedDevicePageViewModel listenInteractions value $value");
      String interaction = utf8.decode(value, allowMalformed: true);
      _addInteractionToList(interaction);
    });
  }

  void turnDeviceOnOff(bool value) {
    widget.device.on = value;
    handleAddInteraction('Device turned ${value ? 'on' : 'off'}');
    notifyListeners();
  }
}
