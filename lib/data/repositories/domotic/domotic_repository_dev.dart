import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/data/repositories/domotic/api/add_interaction_bluetooth_api_impl.dart';
import 'package:samay/data/repositories/domotic/api/add_listener_to_device_api_impl.dart';
import 'package:samay/data/repositories/domotic/api/connect_bluetooth_device_api_impl.dart';
import 'package:samay/data/repositories/domotic/api/disconnect_device_api_impl.dart';
import 'package:samay/data/repositories/domotic/api/get_saved_devices_api_impl.dart';
import 'package:samay/data/repositories/domotic/api/save_connected_bluetooth_api_impl.dart';
import 'package:samay/data/repositories/domotic/api/search_bluetooth_devices_api_impl.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';

class DomoticRepositoryDev extends DomoticRepository {
  String fileName = "devices";
  @override
  Future<Either<ExceptionEntity, BluetoothDeviceEntity>> connectBluetoothDevice(
          BluetoothDevice device) =>
      connectBluetoothDeviceApiImpl(device);

  @override
  Future<Either<ExceptionEntity, void>> disconnectBluetoothDevice(
          BluetoothDeviceEntity device) =>
      disconnectDeviceApiImpl(device, fileName);

  @override
  Future<Either<ExceptionEntity, List<BluetoothDeviceEntity>>>
      getSavedDevices() => getSavedDevicesApiImpl(fileName);

  @override
  Future<Either<ExceptionEntity, void>> listenBluetoothDeviceData(
          BluetoothDeviceEntity device, Function onData) =>
      addListenerToDeviceApiImpl(device, onData);

  @override
  Future<Either<ExceptionEntity, void>> saveBluetoothDevice(
          BluetoothDeviceEntity device) =>
      saveConnectedBluetoothApiImpl(device, fileName);

  @override
  Future<Either<ExceptionEntity, List<BluetoothDevice>>> searchBluetoothDevices(
          Function(List<BluetoothDevice>) onCallBack) =>
      searchBluetoothDevicesApiImpl(onCallBack);

  @override
  Future<Either<ExceptionEntity, void>> addInteraction(
          BluetoothDeviceEntity device, String interaction) =>
      addInteractionBluetoothApiImpl(device, interaction);
}
