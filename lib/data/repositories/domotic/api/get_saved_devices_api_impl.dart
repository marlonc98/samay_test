import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:samay/data/dto/bluetooth_device_from_sp_dto.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Either<ExceptionEntity, List<BluetoothDeviceEntity>>>
    getSavedDevicesApiImpl(String fileName) async {
  try {
    List<String> spDevices = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    spDevices = sp.getStringList(fileName) ?? [];
    List<BluetoothDeviceEntity> devices = [];
    for (String device in spDevices) {
      print("getSavedDevicesApiImpl to device string: ${device}");
      Map<String, dynamic> asJson = jsonDecode(device);
      BluetoothDeviceEntity parsed = BluetoothDeviceFromSpDto.fromJSON(asJson);
      try {
        // FlutterBlueClassic().connect(parsed.address);
      } catch (e) {
        print(
            "getSavedDevicesApiImpl error connecting to device: ${parsed.name} $e");
      }
      devices.add(parsed);
    }
    print("getSavedDevicesApiImpl $devices");
    return Right(devices);
  } catch (e) {
    print("getSavedDevicesApiImpl Error getting saved devices: $e");
    return Left(ExceptionEntity.fromException(e));
  }
}
