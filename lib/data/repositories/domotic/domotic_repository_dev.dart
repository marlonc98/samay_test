import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/data/repositories/domotic/api/connect_bluetooth_device_api_impl.dart';
import 'package:samay/data/repositories/domotic/api/get_saved_devices_api_impl.dart';
import 'package:samay/data/repositories/domotic/api/save_connected_bluetooth_api_impl.dart';
import 'package:samay/data/repositories/domotic/api/search_bluetooth_devices_api_impl.dart';
import 'package:samay/data/repositories/domotic/domotic_repository_fake.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';

class DomoticRepositoryDev extends DomoticRepository {
  DomoticRepositoryFake domoticRepositoryFake = DomoticRepositoryFake();
  String fileName = "devices";
  @override
  Future<Either<ExceptionEntity, BluetoothDeviceEntity>> connectBluetoothDevice(
          BluetoothDevice device) =>
      connectBluetoothDeviceApiImpl(device);

  @override
  Future<Either<ExceptionEntity, void>> disconnectBluetoothDevice(
          BluetoothDevice device) =>
      domoticRepositoryFake.disconnectBluetoothDevice(device);

  @override
  Future<Either<ExceptionEntity, List<BluetoothDeviceEntity>>>
      getSavedDevices() => getSavedDevicesApiImpl(fileName);

  @override
  Future<Either<ExceptionEntity, void>> listenBluetoothDeviceData(
          BluetoothDevice device, Function onData) =>
      domoticRepositoryFake.listenBluetoothDeviceData(device, onData);

  @override
  Future<Either<ExceptionEntity, void>> saveBluetoothDevice(
          BluetoothDeviceEntity device) =>
      saveConnectedBluetoothApiImpl(device, fileName);

  @override
  Future<Either<ExceptionEntity, List<BluetoothDevice>>> searchBluetoothDevices(
          Function(List<BluetoothDevice>) onCallBack) =>
      searchBluetoothDevicesApiImpl(onCallBack);

  @override
  Future<Either<ExceptionEntity, void>> turnOfOnDevice(
          BluetoothDeviceEntity device, bool on) =>
      domoticRepositoryFake.turnOfOnDevice(device, on);
}
