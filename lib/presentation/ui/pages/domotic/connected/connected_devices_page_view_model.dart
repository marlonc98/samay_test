import 'package:either_dart/either.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/waiter_data_entity.dart';
import 'package:samay/domain/states/domotic_state.dart';
import 'package:samay/domain/use_cases/domotic/get_connected_devices_use_case.dart';
import 'package:samay/presentation/ui/pages/domotic/connected/connected_devices_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';

class ConnectedDevicesPageViewModel extends ViewModel<ConnectedDevicesPage> {
  ConnectedDevicesPageViewModel(
      {required super.context, required super.widget});

  bool loading = false;

  void loadDevices() async {
    loading = true;
    notifyListeners();
    Either<Exception, List<BluetoothDeviceEntity>> result =
        await getIt.get<GetConnectedDevicesUseCase>().call();
    loading = false;
    notifyListeners();
  }
}
