import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
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
    searchBluetoothDevicesApiImpl() async {
  if (await FlutterBluePlus.isSupported == false) {
    print(
        "searchBluetoothDevicesApiImpl Bluetooth not supported by this device");
    return Left(
        ExceptionEntity(code: "Bluetooth not supported by this device"));
  }
  bool isGranted = await checkBluetoothPermissions();
  if (isGranted == false) {
    print("searchBluetoothDevicesApiImpl Bluetooth permissions not granted");
    return Left(ExceptionEntity(code: "Bluetooth permissions not granted"));
  }

  if (await FlutterBluePlus.isOn == false) {
    print("searchBluetoothDevicesApiImpl Bluetooth is off");
    return Left(ExceptionEntity(code: "Bluetooth is off"));
  }

  // List to store devices found during the scan
  List<BluetoothDevice> devices = [];

  // Listen to scan results
  FlutterBluePlus.scanResults.listen((results) {
    print("searchBluetoothDevicesApiImpl Scan results: $results");
    for (var result in results) {
      // Avoid duplicates
      if (!devices.any((device) => device.id == result.device.id)) {
        devices.add(result.device);
      }
    }
  }).onError((error, stackTrace) {
    print("searchBluetoothDevicesApiImpl Scan error: $error");
  });

  // Start scanning
  await FlutterBluePlus.startScan(
    timeout: const Duration(seconds: 15), // Stop scanning after 15 seconds
  );

  // Wait for the scan to complete
  await Future.delayed(const Duration(seconds: 15));

  // Stop scanning
  await FlutterBluePlus.stopScan();

  print("searchBluetoothDevicesApiImpl Devices found: ${devices.length}");
  return devices.isNotEmpty
      ? Right(devices)
      : Left(ExceptionEntity(code: "No devices found"));
}
