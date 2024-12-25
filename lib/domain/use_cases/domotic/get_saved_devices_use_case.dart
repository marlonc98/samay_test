import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';

class GetSavedDevicesUseCase {
  final DomoticRepository domoticRepository;

  GetSavedDevicesUseCase({
    required this.domoticRepository,
  });

  Future<Either<ExceptionEntity, List<BluetoothDeviceEntity>>> call() async {
    return domoticRepository.getSavedDevices();
  }
}
