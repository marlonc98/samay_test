import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/states/domotic_state.dart';

class DomoticStateImpl extends DomoticState {
  List<BluetoothDeviceEntity> _knwonDevices = [];
  @override
  List<BluetoothDeviceEntity> get knwonDevices => _knwonDevices;
  @override
  set knwonDevices(List<BluetoothDeviceEntity> value) {
    _knwonDevices = value;
    notifyListeners();
  }

  @override
  void notify() => notifyListeners();

  @override
  void modifyOnDevice(BluetoothDeviceEntity device) {
    final index = _knwonDevices
        .indexWhere((element) => element.address == device.address);
    if (index != -1) {
      _knwonDevices[index] = device;
      notifyListeners();
    }
  }
}
