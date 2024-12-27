import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';

Future<BluetoothCharacteristic?> _getCharacteristicWrite(
    BluetoothDevice device) async {
  List<BluetoothService>? services = await device.discoverServices();
  for (BluetoothService service in services) {
    for (BluetoothCharacteristic characteristic in service.characteristics) {
      if (characteristic.properties.write) {
        return characteristic;
      }
    }
  }
  return null;
}

Future<Either<ExceptionEntity, void>> addInteractionBluetoothApiImpl(
    BluetoothDeviceEntity device, String interaction) async {
  BluetoothCharacteristic? characteristic =
      await _getCharacteristicWrite(device.deviceBluetooth!);
  if (characteristic == null) {
    return Left(ExceptionEntity(code: "No characteristic found"));
  }
  try {
    // List<int> encoded = utf8.encode(interaction);
    List<int> encoded = [0x01, 0x02, 0x03, 0x04];
    await characteristic.write(encoded);
    return const Right(null);
  } catch (e) {
    return Left(ExceptionEntity(code: "Error writing characteristic"));
  }
}
