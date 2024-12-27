import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/utils/images_constants.dart';

Future<Either<ExceptionEntity, BluetoothDeviceEntity>>
    connectBluetoothDeviceApiImpl(BluetoothDevice device) async {
  try {
    print("connectBluetoothDeviceApiImpl connecting to device: ${device.name}");
    if (device.isDisconnected) await device.connect();
    print("connectBluetoothDeviceApiImpl connected to device: ${device.name}");
    BluetoothDeviceEntity parsed = BluetoothDeviceEntity(
      name: device.advName,
      address: device.remoteId.str,
      imageUrl: ImagesConstants.tvTemp,
      deviceBluetooth: device,
    );
    print("connectBluetoothDeviceApiImpl to device: ${device.name}");
    return Right(parsed);
  } catch (e) {
    print(
        "connectBluetoothDeviceApiImpl Error connecting to device: ${device.name} $e");
    return Left(ExceptionEntity(code: "Error connecting to device"));
  }
}
