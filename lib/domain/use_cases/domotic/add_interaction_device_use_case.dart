import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';
import 'package:samay/domain/states/domotic_state.dart';

class AddInteractionDeviceUseCase {
  DomoticRepository domoticRepository;
  DomoticState domoticState;

  AddInteractionDeviceUseCase({
    required this.domoticRepository,
    required this.domoticState,
  });

  Future<Either<ExceptionEntity, void>> call(
      BluetoothDeviceEntity device, String interaction) async {
    device.interactions.add("Starting: $interaction");
    domoticState.notify();
    Either<ExceptionEntity, void> response =
        await domoticRepository.addInteraction(device, interaction);
    if (response.isRight) {
      device.interactions.add("Done: $interaction");
      domoticState.modifyOnDevice(device);
    } else {
      device.interactions.add("Error: $interaction");
      domoticState.modifyOnDevice(device);
    }
    return response;
  }
}
