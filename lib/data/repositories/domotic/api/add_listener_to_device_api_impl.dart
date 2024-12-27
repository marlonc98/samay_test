import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';

Future<BluetoothCharacteristic?> getCharactiristicRead(
    BluetoothDevice device) async {
  List<BluetoothService> services = await device.discoverServices();
  if (services.isEmpty) return null;
  for (BluetoothService service in services) {
    for (BluetoothCharacteristic characteristic in service.characteristics) {
      if (characteristic.properties.notify) {
        return characteristic;
      }
    }
  }
  return null;
}

Future<Either<ExceptionEntity, void>> addListenerToDeviceApiImpl(
    BluetoothDeviceEntity btDevice, Function onData) async {
  List<BluetoothService>? services =
      await btDevice.deviceBluetooth?.discoverServices();
  if (services == null || services.isEmpty) {
    return Left(ExceptionEntity(code: "No services found"));
  }
  for (BluetoothService service in services) {
    for (BluetoothCharacteristic characteristic in service.characteristics) {
      if (characteristic.properties.notify) {
        characteristic.setNotifyValue(true);
        characteristic.lastValueStream.listen((value) {
          String decoded = String.fromCharCodes(value);
          btDevice.interactions.add(decoded);
          onData(value);
        });
      }
    }
  }
  return const Right(null);
}
