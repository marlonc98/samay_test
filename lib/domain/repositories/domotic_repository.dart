import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class DomoticRepository {
  Future<Either<ExceptionEntity, List<BluetoothDevice>>>
      searchBluetoothDevices();
  Future<Either<ExceptionEntity, List<BluetoothDeviceEntity>>>
      getSavedDevices();
  Future<Either<ExceptionEntity, void>> saveBluetoothDevice(
      BluetoothDeviceEntity device);
  Future<Either<ExceptionEntity, void>> removeBluetoothDevice(
      BluetoothDeviceEntity device);
  Future<Either<ExceptionEntity, BluetoothDeviceEntity>> connectBluetoothDevice(
      BluetoothDevice device);
  Future<Either<ExceptionEntity, void>> disconnectBluetoothDevice(
      BluetoothDevice device);
  Future<Either<ExceptionEntity, void>> turnOfOnDevice(
      BluetoothDeviceEntity device, bool on);
  Future<Either<ExceptionEntity, void>> listenBluetoothDeviceData(
      BluetoothDevice device, Function onData);
}
