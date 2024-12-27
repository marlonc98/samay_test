import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';
import 'package:samay/domain/states/domotic_state.dart';

class DisconnectDeviceUseCase {
  final DomoticRepository domoticRepository;
  final DomoticState domoticState;

  DisconnectDeviceUseCase({
    required this.domoticRepository,
    required this.domoticState,
  });

  Future<Either<ExceptionEntity, void>> call(
      BluetoothDeviceEntity device) async {
    Either<ExceptionEntity, void> response =
        await domoticRepository.disconnectBluetoothDevice(device);
    if (response.isRight) {
      domoticState.knwonDevices
          .removeWhere((element) => element.address == device.address);
      domoticState.notify();
    }
    return const Right(null);
  }
}
