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
    searchBluetoothDevicesApiImpl(
        Function(List<BluetoothDevice>) onCallBack) async {
  print("searchBluetoothDevicesApiImpl start ");
  if (await FlutterBluePlus.isSupported == false) {
    return Left(
        ExceptionEntity(code: "Bluetooth not supported by this device"));
  }
  bool isGranted = await checkBluetoothPermissions();
  if (isGranted == false) {
    return Left(ExceptionEntity(code: "Bluetooth permissions not granted"));
  }

  if (await FlutterBluePlus.isOn == false) {
    return Left(ExceptionEntity(code: "Bluetooth is off"));
  }

  // List to store devices found during the scan
  List<BluetoothDevice> devices = [];

  // Listen to scan results
  FlutterBluePlus.scanResults.listen((results) {
    for (var result in results) {
      // Avoid duplicates
      if (!devices.any((device) => device.id == result.device.id)) {
        devices.add(result.device);
        result.device.connectionState.listen((BluetoothConnectionState st) {
          print(
              "Dispositivo leido: ${result.device.toString()} ${result.device.platformName}: ${result.advertisementData.toString()}");
          result.device.servicesList.forEach((service) {
            print(
                "Dispositivo Servicio: ${service.uuid.toString()} ${service.characteristics.toString()}");
          });
          if (st == BluetoothConnectionState.connected) {
            print(
                "Dispositivo conectado: ${result.device.toString()} ${result.device.platformName}: ${result.advertisementData.toString()}");
          }
        });
      }
    }
    onCallBack(devices);
  }).onError((error, stackTrace) {});

  // Start scanning
  await FlutterBluePlus.startScan(
    timeout: const Duration(seconds: 15), // Stop scanning after 15 seconds
  );

  // Wait for the scan to complete
  await Future.delayed(const Duration(seconds: 15));

  // Stop scanning
  await FlutterBluePlus.stopScan();

  return devices.isNotEmpty
      ? Right(devices)
      : Left(ExceptionEntity(code: "No devices found"));
}
