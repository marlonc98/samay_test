import 'package:either_dart/src/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';

const BluetoothDeviceEntity btDevice = BluetoothDeviceEntity(
    rssid: '1232',
    name: 'AC',
    address: '12:34:56:78:90:AB',
    imageUrl: 'assets/temp_images/ac.png',
    charge: 100);
const BluetoothDeviceEntity btDevice2 = BluetoothDeviceEntity(
    rssid: '1232',
    name: 'TV',
    address: '12:34:56:78:90:AB',
    imageUrl: 'assets/temp_images/tv.png',
    charge: 40);
const BluetoothDeviceEntity btDevice3 = BluetoothDeviceEntity(
    rssid: '1232',
    name: 'Light',
    address: '12:34:56:78:90:AB',
    imageUrl: 'assets/temp_images/light.png',
    charge: 100);
const BluetoothDeviceEntity btDevice4 = BluetoothDeviceEntity(
    rssid: '1232',
    name: 'Music',
    address: '12:34:56:78:90:AB',
    imageUrl: 'assets/temp_images/music.png',
    charge: 60);

class DomoticRepositoryFake extends DomoticRepository {
  @override
  Future<Either<ExceptionEntity, void>> connectBluetoothDevice(
      BluetoothDevice device) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Right(null);
  }

  @override
  Future<Either<ExceptionEntity, void>> disconnectBluetoothDevice(
      BluetoothDevice device) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Right(null);
  }

  @override
  Future<Either<ExceptionEntity, List<BluetoothDeviceEntity>>>
      getSavedDevices() async {
    await Future.delayed(const Duration(seconds: 1));
    return const Right([
      btDevice2,
      btDevice3,
    ]);
  }

  @override
  Future<Either<ExceptionEntity, void>> listenBluetoothDeviceData(
      BluetoothDevice device, Function onData) async {
    await Future.delayed(const Duration(seconds: 1));
    onData("Data received");
    return const Right(null);
  }

  @override
  Future<Either<ExceptionEntity, void>> removeBluetoothDevice(
      BluetoothDeviceEntity device) async {
    await Future.delayed(const Duration(seconds: 1));
    await Future.delayed(const Duration(seconds: 1));
    return const Right(null);
  }

  @override
  Future<Either<ExceptionEntity, void>> saveBluetoothDevice(
      BluetoothDeviceEntity device) async {
    await Future.delayed(const Duration(seconds: 1));
    await Future.delayed(const Duration(seconds: 1));
    return const Right(null);
  }

  @override
  Future<Either<ExceptionEntity, List<BluetoothDevice>>>
      searchBluetoothDevices() async {
    await Future.delayed(const Duration(seconds: 1));
    return Right([
      BluetoothDevice(remoteId: const DeviceIdentifier('12:12:56:78:90:AB')),
      BluetoothDevice(remoteId: const DeviceIdentifier('12:23:56:78:90:AB')),
      BluetoothDevice(remoteId: const DeviceIdentifier('12:34:56:78:90:AB')),
      BluetoothDevice(remoteId: const DeviceIdentifier('12:45:56:78:90:AB')),
      BluetoothDevice(remoteId: const DeviceIdentifier('12:45:56:78:90:AB')),
      BluetoothDevice(remoteId: const DeviceIdentifier('12:45:56:78:90:AB')),
      BluetoothDevice(remoteId: const DeviceIdentifier('12:45:56:78:90:AB')),
      BluetoothDevice(remoteId: const DeviceIdentifier('12:45:56:78:90:AB')),
    ]);
  }

  @override
  Future<Either<ExceptionEntity, void>> sendBluetoothDeviceData(
      BluetoothDevice device, String data) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Right(null);
  }
}
