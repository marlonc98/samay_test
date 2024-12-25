import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/use_cases/domotic/get_connected_devices_use_case.dart';
import 'package:samay/presentation/ui/pages/domotic/connected/connected_devices_page.dart';
import 'package:samay/presentation/ui/pages/domotic/detailed/detailed_device_page.dart';
import 'package:samay/presentation/ui/pages/domotic/search/search_devices_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';

class ConnectedDevicesPageViewModel extends ViewModel<ConnectedDevicesPage> {
  ConnectedDevicesPageViewModel(
      {required super.context, required super.widget}) {
    _loadDevices();
  }

  bool loading = false;

  Future<void> _loadDevices() async {
    loading = true;
    notifyListeners();
    Either<ExceptionEntity, List<BluetoothDeviceEntity>> response =
        await getIt.get<GetConnectedDevicesUseCase>().call();
    if (response.isRight && response.right.isEmpty) {
      Navigator.of(context).pushNamed(SearchDevicesPage.route);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> refreshDevices() async {
    await _loadDevices();
  }

  void handleOnDeviceTap(BluetoothDeviceEntity device) {
    Navigator.of(context).pushNamed(DetailedDevicePage.route,
        arguments: DetailedDevicePage(device: device));
  }
}
