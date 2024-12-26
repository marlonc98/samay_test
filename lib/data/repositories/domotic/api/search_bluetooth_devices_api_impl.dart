import 'package:either_dart/either.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkBluetoothPermissions() async {
  if (await Permission.bluetoothScan.request().isGranted &&
      await Permission.bluetoothConnect.request().isGranted) {
    return true;
  }
  return false;
}

Future<Either<ExceptionEntity, List<BluetoothDevice>>>
    searchBluetoothDevicesApiImpl(
        Function(List<BluetoothDevice>) onCallBack) async {
  final _flutterBlueClassicPlugin = GetIt.I.get<FlutterBlueClassic>();
  print("searchBluetoothDevicesApiImpl start ");
  if (await _flutterBlueClassicPlugin.isSupported == false) {
    return Left(
        ExceptionEntity(code: "Bluetooth not supported by this device"));
  }
  bool isGranted = await checkBluetoothPermissions();
  if (isGranted == false) {
    return Left(ExceptionEntity(code: "Bluetooth permissions not granted"));
  }

  if (await _flutterBlueClassicPlugin.isEnabled == false) {
    return Left(ExceptionEntity(code: "Bluetooth is off"));
  }

  // List to store devices found during the scan
  List<BluetoothDevice> devices = [];

  // Listen to scan results
  _flutterBlueClassicPlugin.scanResults.listen((device) {
    // Avoid duplicates
    if (!devices.any((element) => element.address == device.address)) {
      devices.add(device);
    }
    try {
      print(
          "searchBluetoothDevicesApiImpl device: ${device.type} ${device.toString()}");
    } catch (e) {
      print(e);
    }
    onCallBack(
        devices.where((element) => element.name?.isNotEmpty ?? false).toList());
  }).onError((error, stackTrace) {});

  // Start scanning
  _flutterBlueClassicPlugin.startScan(); // Stop scanning after 15 seconds

  // Wait for the scan to complete
  await Future.delayed(const Duration(seconds: 15));

  // Stop scanning
  _flutterBlueClassicPlugin.stopScan();

  return devices.isNotEmpty
      ? Right(devices
          .where((element) => element.name?.isNotEmpty ?? false)
          .toList())
      : Left(ExceptionEntity(code: "No devices found"));
}
