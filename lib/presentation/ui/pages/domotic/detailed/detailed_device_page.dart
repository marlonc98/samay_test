import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/presentation/ui/pages/domotic/connected/widgets/card_device_widget.dart';
import 'package:samay/presentation/ui/pages/domotic/detailed/detailed_device_page_view_model.dart';

class DetailedDevicePage extends StatefulWidget {
  static const String route = '/domotic/detailed';
  final BluetoothDeviceEntity device;
  const DetailedDevicePage({super.key, required this.device});

  @override
  State<DetailedDevicePage> createState() => _DetailedDevicePageState();
}

class _DetailedDevicePageState extends State<DetailedDevicePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailedDevicePageViewModel>(
      create: (_) => DetailedDevicePageViewModel(
          context: context, widget: widget, isMounted: () => mounted),
      child: Consumer<DetailedDevicePageViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          body: CustomScrollView(slivers: [
            SliverAppBar(
              title: Text(widget.device.name),
              floating: false,
              snap: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.link_off),
                  onPressed: viewModel.handleDeleteDevice,
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList.list(children: [
                CardDeviceWidget(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                  elevation: 0,
                  device: widget.device,
                  turnDeviceOnOff: viewModel.turnDeviceOnOff,
                ),
              ]),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100, left: 8, right: 8),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 01,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.device.interactions.isEmpty
                                  ? const [Text("No interactions yet")]
                                  : widget.device.interactions
                                      .map((interaction) => Text(interaction))
                                      .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Brightness.light ==
                                    MediaQuery.of(context).platformBrightness
                                ? Colors.white
                                : Colors.black,
                          ),
                          child: StreamBuilder(
                            stream:
                                widget.device.deviceBluetooth?.connectionState,
                            builder: (context, snapshot) => TextField(
                              decoration: const InputDecoration(
                                hintText: 'Interaction',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              controller: viewModel.interactionController,
                              enabled: snapshot.data ==
                                  BluetoothConnectionState.connected,
                              onSubmitted: (value) {
                                viewModel.handleAddInteraction();
                              },
                            ),
                          ),
                        )),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              viewModel.handleAddInteraction();
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
