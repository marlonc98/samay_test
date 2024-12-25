import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';
import 'package:samay/domain/states/domotic_state.dart';

class ConnectDeviceUseCase {
  final DomoticRepository domoticRepository;
  final DomoticState domoticState;

  ConnectDeviceUseCase({
    required this.domoticRepository,
    required this.domoticState,
  });

  Future<Either<ExceptionEntity, BluetoothDeviceEntity>> call(
      BluetoothDevice device) async {
    Either<ExceptionEntity, BluetoothDeviceEntity> response =
        await domoticRepository.connectBluetoothDevice(device);
    if (response.isRight) {
      domoticState.knwonDevices.add(response.right);
      domoticState.notify();
    }
    return response;
  }
}
