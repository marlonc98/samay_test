import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothDeviceEntity {
  String name;
  String address;
  String? imageUrl;
  double? charge;
  bool connected;
  bool on;
  BluetoothDevice? deviceBluetooth;
  List<String> interactions = [];

  BluetoothDeviceEntity(
      {required this.name,
      required this.address,
      this.imageUrl,
      this.connected = false,
      this.on = false,
      this.charge,
      this.deviceBluetooth});
}
