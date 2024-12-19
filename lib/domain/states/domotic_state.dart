import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class DomoticState {
  abstract List<BluetoothDevice> devices;
}