import 'package:either_dart/either.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/utils/images_constants.dart';

Future<Either<ExceptionEntity, BluetoothDeviceEntity>>
    connectBluetoothDeviceApiImpl(BluetoothDevice device) async {
  try {
    print("connectBluetoothDeviceApiImpl Connecting to device: ${device.name}");
    await FlutterBlueClassic().connect(device.address);
    BluetoothDeviceEntity parsed = BluetoothDeviceEntity(
      name: device.name ?? "Unknown",
      address: device.address,
      imageUrl: ImagesConstants.tvTemp,
      deviceBluetooth: device,
    );
    print("connectBluetoothDeviceApiImpl Connected to device: ${device.name}");
    return Right(parsed);
  } catch (e) {
    print(
        "connectBluetoothDeviceApiImpl Error connecting to device: ${device.name} $e");
    return Left(ExceptionEntity.fromException(e));
  }
}
