import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkBluetoothPermissions() async {
  if (await Permission.bluetoothScan.request().isGranted &&
      await Permission.bluetooth.request().isGranted &&
      await Permission.bluetoothAdvertise.request().isGranted &&
      await Permission.location.request().isGranted &&
      await Permission.bluetoothConnect.request().isGranted) {
    return true;
  }
  return false;
}

Future<Either<ExceptionEntity, List<BluetoothDevice>>>
    searchBluetoothDevicesApiImpl(
        Function(List<BluetoothDevice>) onCallBack) async {
  if (await FlutterBluePlus.isSupported == false) {
    return Left(
        ExceptionEntity(code: "Bluetooth not supported by this device"));
  }
  bool isGranted = await checkBluetoothPermissions();
  if (isGranted == false) {
    return Left(ExceptionEntity(code: "Bluetooth permissions not granted"));
  }

  // ignore: deprecated_member_use
  if (await FlutterBluePlus.isOn == false) {
    return Left(ExceptionEntity(code: "Bluetooth is off"));
  }

  // List to store devices found during the scan
  List<ScanResult> resultsSaved = [];

  List<BluetoothDevice> devices() {
    resultsSaved.sort((a, b) => b.rssi.compareTo(a.rssi));
    return resultsSaved
        .map((result) => result.device)
        .where((device) =>
            device.advName.isNotEmpty || device.platformName.isNotEmpty)
        .toList();
  }

  // Listen to scan results
  FlutterBluePlus.scanResults.listen((results) {
    for (var result in results) {
      // Avoid duplicates
      if (!resultsSaved
          // ignore: deprecated_member_use
          .any((resultSaved) => resultSaved.device.id == result.device.id)) {
        resultsSaved.add(result);
      }
    }
    onCallBack(devices());
  }).onError((error, stackTrace) {});

  //order by

  // Start scanning
  await FlutterBluePlus.startScan(
    timeout: const Duration(seconds: 15), // Stop scanning after 15 seconds
  );

  // Wait for the scan to complete
  await Future.delayed(const Duration(seconds: 15));

  // Stop scanning
  await FlutterBluePlus.stopScan();

  return devices().isNotEmpty
      ? Right(devices())
      : Left(ExceptionEntity(code: "No devices found"));
}
