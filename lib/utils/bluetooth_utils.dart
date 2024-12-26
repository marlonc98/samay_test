import 'package:flutter_blue_classic/flutter_blue_classic.dart';

class BluetoothUtils {
  static bool isConnected(BluetoothDevice device) {
    try {
      // Attempt to read the RSSI of the device.
      // This will fail if the device is not connected.
      int rssiThreshold = -70; // Example threshold
      return device.rssi != null && device.rssi! > rssiThreshold;
    } catch (e) {
      return false;
    }
  }
}
