import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';

BluetoothDeviceEntity btDevice = BluetoothDeviceEntity(
    name: 'AC',
    address: '12:34:56:78:90:AB',
    on: true,
    imageUrl: 'assets/temp_images/ac.png',
    charge: 100);
BluetoothDeviceEntity btDevice2 = BluetoothDeviceEntity(
    name: 'TV',
    address: '12:34:56:78:90:AB',
    imageUrl: 'assets/temp_images/tv.png',
    on: true,
    charge: 40);
BluetoothDeviceEntity btDevice3 = BluetoothDeviceEntity(
    name: 'Light',
    address: '12:34:56:78:90:AB',
    imageUrl: 'assets/temp_images/light.png',
    on: false,
    charge: 100);
BluetoothDeviceEntity btDevice4 = BluetoothDeviceEntity(
    name: 'Music',
    address: '12:34:56:78:90:AB',
    imageUrl: 'assets/temp_images/music.png',
    on: false,
    charge: 60);

class DomoticRepositoryFake extends DomoticRepository {
  @override
  Future<Either<ExceptionEntity, BluetoothDeviceEntity>> connectBluetoothDevice(
      BluetoothDevice device) async {
    await Future.delayed(const Duration(seconds: 2));
    return Right(btDevice4);
  }

  @override
  Future<Either<ExceptionEntity, void>> disconnectBluetoothDevice(
      BluetoothDeviceEntity device) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Right(null);
  }

  @override
  Future<Either<ExceptionEntity, List<BluetoothDeviceEntity>>>
      getSavedDevices() async {
    await Future.delayed(const Duration(seconds: 1));
    return Right([
      btDevice2,
      btDevice2,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
      btDevice3,
    ]);
  }

  @override
  Future<Either<ExceptionEntity, void>> listenBluetoothDeviceData(
      BluetoothDeviceEntity device, Function onData) async {
    await Future.delayed(const Duration(seconds: 1));
    onData("Data received");
    return const Right(null);
  }

  @override
  Future<Either<ExceptionEntity, void>> saveBluetoothDevice(
      BluetoothDeviceEntity device) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Right(null);
  }

  @override
  Future<Either<ExceptionEntity, List<BluetoothDevice>>> searchBluetoothDevices(
      Function(List<BluetoothDevice>) onCallBack) async {
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
  Future<Either<ExceptionEntity, void>> addInteraction(
      BluetoothDeviceEntity device, String interaction) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Right(null);
  }
}
