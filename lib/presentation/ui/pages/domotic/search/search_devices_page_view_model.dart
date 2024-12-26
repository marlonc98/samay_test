import 'package:either_dart/either.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/waiter_data_entity.dart';
import 'package:samay/domain/use_cases/domotic/search_devices_to_connect_use_case.dart';
import 'package:samay/presentation/ui/pages/domotic/search/search_devices_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';
import 'package:samay/utils/show_modal.dart';

class SearchDevicesPageViewModel extends ViewModel<SearchDevicesPage> {
  SearchDevicesPageViewModel(
      {required super.context,
      required super.widget,
      required super.isMounted}) {
    searchDevices();
  }

  WaiterDataEntity<List<BluetoothDevice>> waiterDevices =
      WaiterDataEntity<List<BluetoothDevice>>();

  Future<void> searchDevices() async {
    waiterDevices = WaiterDataEntity();

    void onCallBack(List<BluetoothDevice> devices) {
      waiterDevices.data = devices;
      if (mounted) notifyListeners();
    }

    notifyListeners();
    Either<ExceptionEntity, List<BluetoothDevice>> response =
        await getIt.get<SearchDevicesToConnectUseCase>().call(onCallBack);
    if (response.isLeft) {
      waiterDevices = WaiterDataEntity(status: WaiterDataEntityStatus.error);
      if (mounted) {
        notifyListeners();
        // ignore: use_build_context_synchronously
        ShowModal.showSnackBar(context: context, text: response.left.code);
      }
    } else {
      waiterDevices = WaiterDataEntity(
        status: WaiterDataEntityStatus.loaded,
        data: response.right,
      );
      if (mounted) notifyListeners();
    }
  }
}
