import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/presentation/ui/pages/domotic/search/search_devices_page_view_model.dart';

class SearchDevicesPage extends StatelessWidget {
  static const String route = '/domotic/search';
  const SearchDevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchDevicesPageViewModel>(
        create: (_) =>
            SearchDevicesPageViewModel(context: context, widget: this),
        child: Consumer<SearchDevicesPageViewModel>(
            builder: (context, viewModel, child) => const Scaffold(
                  body: Column(
                    children: [
                      Text("SearchDevicesPage"),
                    ],
                  ),
                )));
  }
}
