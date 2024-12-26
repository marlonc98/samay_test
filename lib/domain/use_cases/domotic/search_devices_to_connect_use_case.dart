import 'package:either_dart/either.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';
import 'package:samay/domain/states/domotic_state.dart';

class SearchDevicesToConnectUseCase {
  DomoticRepository domoticRepository;
  DomoticState domoticState;

  SearchDevicesToConnectUseCase({
    required this.domoticRepository,
    required this.domoticState,
  });

  Future<Either<ExceptionEntity, List<BluetoothDevice>>> call(
      Function(List<BluetoothDevice>) onCallBack) async {
    Either<ExceptionEntity, List<BluetoothDevice>> response =
        await domoticRepository.searchBluetoothDevices(onCallBack);
    return response;
  }
}
