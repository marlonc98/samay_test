import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';
import 'package:samay/domain/states/domotic_state.dart';

class GetConnectedDevicesUseCase {
  DomoticRepository domoticRepository;
  DomoticState domoticState;

  GetConnectedDevicesUseCase({
    required this.domoticRepository,
    required this.domoticState,
  });

  Future<Either<ExceptionEntity, List<BluetoothDeviceEntity>>> call() async {
    Either<ExceptionEntity, List<BluetoothDeviceEntity>> response =
        await domoticRepository.getSavedDevices();
    if (response.isRight) {
      domoticState.knwonDevices = response.right;
    }
    return response;
  }
}
