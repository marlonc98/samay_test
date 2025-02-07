import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:samay/data/dto/bluetooth_device_from_sp_dto.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/utils/key_words_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Either<ExceptionEntity, void>> saveConnectedBluetoothApiImpl(
    BluetoothDeviceEntity device, String fileName) async {
  try {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> devices = sp.getStringList(fileName) ?? [];
    Map<String, dynamic> asJson = BluetoothDeviceFromSpDto.toJSON(device);
    String asString = jsonEncode(asJson);
    List<Map<String, dynamic>> devicesJson = devices
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList(growable: true);
    if (devicesJson.any((element) => element["address"] == asJson["address"])) {
      return const Right(null);
    }
    devices.add(asString);
    await sp.setStringList(fileName, devices);
    return const Right(null);
  } catch (e) {
    return Left(ExceptionEntity(
        code: KeyWordsConstants.domoticApiErrorSavingNewDevice));
  }
}
