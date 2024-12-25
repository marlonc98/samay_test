import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/presentation/ui/pages/domotic/connected/widgets/card_device_widget.dart';
import 'package:samay/presentation/ui/pages/domotic/detailed/detailed_device_page_view_model.dart';

class DetailedDevicePage extends StatelessWidget {
  static const String route = '/domotic/detailed';
  final BluetoothDeviceEntity device;
  const DetailedDevicePage({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailedDevicePageViewModel>(
      create: (_) =>
          DetailedDevicePageViewModel(context: context, widget: this),
      child: Consumer<DetailedDevicePageViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          body: CustomScrollView(slivers: [
            SliverAppBar(
              title: Text(device.name),
              floating: false,
              snap: false,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList.list(children: [
                CardDeviceWidget(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                  elevation: 0,
                  device: device,
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
                              children: device.interactions.isEmpty
                                  ? const [Text("No interactions yet")]
                                  : device.interactions
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
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Interaction',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            controller: viewModel.interactionController,
                            enabled:
                                device.deviceBluetooth?.isConnected ?? false,
                            onSubmitted: (value) {
                              viewModel.handleAddInteraction(value);
                            },
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
                              viewModel.handleAddInteraction('Interaction');
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
