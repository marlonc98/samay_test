import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/states/domotic_state.dart';
import 'package:samay/presentation/ui/pages/domotic/connected/connected_devices_page_view_model.dart';
import 'package:samay/presentation/ui/pages/domotic/connected/widgets/card_device_widget.dart';
import 'package:samay/presentation/ui/pages/domotic/search/search_devices_page.dart';
import 'package:samay/presentation/ui/widgets/custom_botttom_navigation_widget.dart';
import 'package:samay/presentation/ui/widgets/loading_widget.dart';
import 'package:samay/presentation/ui/widgets/not_found_widget.dart';

class ConnectedDevicesPage extends StatefulWidget {
  static const String route = '/domotic/connected';
  const ConnectedDevicesPage({super.key});

  @override
  State<ConnectedDevicesPage> createState() => _ConnectedDevicesPageState();
}

class _ConnectedDevicesPageState extends State<ConnectedDevicesPage> {
  @override
  Widget build(BuildContext context) {
    final domoticDevices = Provider.of<DomoticState>(context).knwonDevices;
    return ChangeNotifierProvider<ConnectedDevicesPageViewModel>(
        create: (_) => ConnectedDevicesPageViewModel(
            context: context, widget: widget, isMounted: () => mounted),
        child: Consumer<ConnectedDevicesPageViewModel>(
            builder: (context, viewModel, child) {
          if (viewModel.loading && domoticDevices.isEmpty) {
            return const Scaffold(
              body: LoadingWidget(),
            );
          } else if (!viewModel.loading && domoticDevices.isEmpty) {
            return const Scaffold(
              body: NotFoundWidget(),
            );
          }
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(SearchDevicesPage.route),
                child: const Icon(Icons.add),
              ),
              bottomNavigationBar: const CustomBotttomNavigationWidget(
                currentRoute: ConnectedDevicesPage.route,
              ),
              body: RefreshIndicator(
                onRefresh: () => viewModel.refreshDevices(),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: const Text('Connected Devices'),
                      floating: true,
                      snap: true,
                      actions: [
                        IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: viewModel.refreshDevices)
                      ],
                    ),
                    SliverGrid.count(
                        crossAxisCount: 2,
                        children: domoticDevices
                            .map((device) => CardDeviceWidget(
                                  device: device,
                                  onTap: viewModel.handleOnDeviceTap,
                                ))
                            .toList()),
                  ],
                ),
              ));
        }));
  }
}
