import 'package:flutter/foundation.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';

abstract class DomoticState with ChangeNotifier {
  abstract List<BluetoothDeviceEntity> knwonDevices;
  void notify();
}
