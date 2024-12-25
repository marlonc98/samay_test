import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/data/repositories/domotic/api/search_bluetooth_devices_api_impl.dart';
import 'package:samay/data/repositories/domotic/domotic_repository_fake.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';

class DomoticRepositoryDev extends DomoticRepository {
  DomoticRepositoryFake domoticRepositoryFake = DomoticRepositoryFake();
  @override
  Future<Either<ExceptionEntity, BluetoothDeviceEntity>> connectBluetoothDevice(
          BluetoothDevice device) =>
      domoticRepositoryFake.connectBluetoothDevice(device);

  @override
  Future<Either<ExceptionEntity, void>> disconnectBluetoothDevice(
          BluetoothDevice device) =>
      domoticRepositoryFake.disconnectBluetoothDevice(device);

  @override
  Future<Either<ExceptionEntity, List<BluetoothDeviceEntity>>>
      getSavedDevices() => domoticRepositoryFake.getSavedDevices();

  @override
  Future<Either<ExceptionEntity, void>> listenBluetoothDeviceData(
          BluetoothDevice device, Function onData) =>
      domoticRepositoryFake.listenBluetoothDeviceData(device, onData);

  @override
  Future<Either<ExceptionEntity, void>> removeBluetoothDevice(
          BluetoothDeviceEntity device) =>
      domoticRepositoryFake.removeBluetoothDevice(device);

  @override
  Future<Either<ExceptionEntity, void>> saveBluetoothDevice(
          BluetoothDeviceEntity device) =>
      domoticRepositoryFake.saveBluetoothDevice(device);

  @override
  Future<Either<ExceptionEntity, List<BluetoothDevice>>>
      searchBluetoothDevices() => searchBluetoothDevicesApiImpl();

  @override
  Future<Either<ExceptionEntity, void>> turnOfOnDevice(
          BluetoothDeviceEntity device, bool on) =>
      domoticRepositoryFake.turnOfOnDevice(device, on);
}
