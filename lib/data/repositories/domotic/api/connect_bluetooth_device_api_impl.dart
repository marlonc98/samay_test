import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/utils/images_constants.dart';

Future<Either<ExceptionEntity, BluetoothDeviceEntity>>
    connectBluetoothDeviceApiImpl(BluetoothDevice device) async {
  try {
    if (device.isDisconnected) await device.connect();
    BluetoothDeviceEntity parsed = BluetoothDeviceEntity(
      name: device.advName,
      address: device.remoteId.str,
      imageUrl: ImagesConstants.tvTemp,
      deviceBluetooth: device,
    );
    return Right(parsed);
  } catch (e) {
    return Left(ExceptionEntity(code: "Error connecting to device"));
  }
}
