import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/states/domotic_state.dart';
import 'package:samay/presentation/ui/pages/domotic/connected/connected_devices_page_view_model.dart';

class ConnectedDevicesPage extends StatelessWidget {
  static const String route = '/domotic/connected';
  const ConnectedDevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final domoticDevices = Provider.of<DomoticState>(context).knwonDevices;
    return ChangeNotifierProvider<ConnectedDevicesPageViewModel>(
        create: (_) =>
            ConnectedDevicesPageViewModel(context: context, widget: this),
        child: Consumer<ConnectedDevicesPageViewModel>(
            builder: (context, viewModel, child) => Scaffold(
                  body: Column(
                    children: [
                      const Text("ConnectedDevicesPage"),
                      ...domoticDevices.map((device) => Text(device.name)),
                    ],
                  ),
                )));
  }
}
