import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Either<ExceptionEntity, void>> disconnectDeviceApiImpl(
    BluetoothDeviceEntity device, String fileName) async {
  try {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> devices = sp.getStringList(fileName) ?? [];
    List<Map<String, dynamic>> devicesJson =
        devices.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    devicesJson.removeWhere((element) => element["address"] == device.address);
    List<String> stringNew = devicesJson.map((e) => jsonEncode(e)).toList();
    await sp.setStringList(fileName, stringNew);
    await device.deviceBluetooth?.disconnect();
    return const Right(null);
  } catch (e) {
    return Left(ExceptionEntity(code: "Error disconnecting device"));
  }
}
