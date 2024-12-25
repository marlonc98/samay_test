import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';

class BluetoothDeviceFromSpDto {
  static Map<String, dynamic> toJSON(BluetoothDeviceEntity device) {
    return {
      'name': device.name,
      'address': device.address,
      'imageUrl': device.imageUrl,
    };
  }

  static BluetoothDeviceEntity fromJSON(Map<String, dynamic> json) {
    return BluetoothDeviceEntity(
      name: json['name'],
      address: json['address'],
      imageUrl: json['imageUrl'],
      deviceBluetooth: BluetoothDevice.fromId(json["address"]),
    );
  }
}
