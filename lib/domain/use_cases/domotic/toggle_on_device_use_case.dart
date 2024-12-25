import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';
import 'package:samay/domain/states/domotic_state.dart';

class ToggleOnDeviceUseCase {
  DomoticRepository domoticRepository;
  DomoticState domoticState;

  ToggleOnDeviceUseCase({
    required this.domoticRepository,
    required this.domoticState,
  });

  Future<Either<ExceptionEntity, void>> call(
      BluetoothDeviceEntity device, bool on) async {
    Either<ExceptionEntity, void> response =
        await domoticRepository.turnOfOnDevice(device, on);
    if (response.isRight) {
      domoticState.knwonDevices
          .where((deviceKnown) => deviceKnown.address == device.address)
          .forEach((deviceKnown) {
        deviceKnown.on = on;
      });
      domoticState.notify();
    }
    return response;
  }
}
