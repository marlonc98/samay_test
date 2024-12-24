import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/presentation/ui/pages/domotic/detailed/detailed_device_page_view_model.dart';

class DetailedDevicePage extends StatelessWidget {
  static const String route = '/domotic/detailed';
  final String id;
  const DetailedDevicePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailedDevicePageViewModel>(
        create: (_) =>
            DetailedDevicePageViewModel(context: context, widget: this),
        child: Consumer<DetailedDevicePageViewModel>(
            builder: (context, viewModel, child) => const Scaffold(
                  body: Column(
                    children: [
                      Text("DetailedDevicePage"),
                    ],
                  ),
                )));
  }
}
