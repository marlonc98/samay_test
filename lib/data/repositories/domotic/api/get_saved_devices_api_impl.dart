import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/data/dto/bluetooth_device_from_sp_dto.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/utils/key_words_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Either<ExceptionEntity, List<BluetoothDeviceEntity>>>
    getSavedDevicesApiImpl(String fileName) async {
  try {
    List<String> spDevices = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    spDevices = sp.getStringList(fileName) ?? [];
    List<BluetoothDeviceEntity> devices = [];
    for (String device in spDevices) {
      Map<String, dynamic> asJson = jsonDecode(device);
      BluetoothDeviceEntity parsed = BluetoothDeviceFromSpDto.fromJSON(asJson);
      try {
        if (parsed.deviceBluetooth?.isConnected == false &&
            // ignore: deprecated_member_use
            await FlutterBluePlus.isOn == true) {
          parsed.deviceBluetooth?.connect(autoConnect: true, mtu: null);
        }
        // ignore: empty_catches
      } catch (e) {}
      devices.add(parsed);
    }
    return Right(devices);
  } catch (e) {
    return Left(ExceptionEntity(
        code: KeyWordsConstants.domoticApiErrorGettingSavedDevices));
  }
}
