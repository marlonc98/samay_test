import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/entities/waiter_data_entity.dart';
import 'package:samay/presentation/ui/pages/domotic/search/search_devices_page_view_model.dart';
import 'package:samay/presentation/ui/pages/domotic/search/widgets/bluettoth_item_widget.dart';
import 'package:samay/presentation/ui/widgets/loading_widget.dart';
import 'package:samay/presentation/ui/widgets/not_found_widget.dart';
import 'package:samay/utils/key_words_constants.dart';

class SearchDevicesPage extends StatefulWidget {
  static const String route = '/domotic/search';
  const SearchDevicesPage({super.key});
  @override
  State<SearchDevicesPage> createState() => _SearchDevicesPageState();
}

class _SearchDevicesPageState extends State<SearchDevicesPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchDevicesPageViewModel>(
        create: (_) => SearchDevicesPageViewModel(
            context: context, widget: widget, isMounted: () => mounted),
        child: Consumer<SearchDevicesPageViewModel>(
            builder: (context, viewModel, child) {
          return Scaffold(
              body: RefreshIndicator(
            onRefresh: viewModel.refresh,
            child: CustomScrollView(slivers: [
              SliverAppBar(
                title: Text(viewModel.localization
                    .translate(KeyWordsConstants.searchDevicesPageTitle)),
                floating: true,
                snap: true,
                actions: [
                  IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: viewModel.waiterDevices.status !=
                              WaiterDataEntityStatus.loading
                          ? viewModel.searchDevices
                          : null)
                ],
              ),
              if (viewModel.waiterDevices.status ==
                      WaiterDataEntityStatus.loading &&
                  (viewModel.waiterDevices.data?.isEmpty ?? true))
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: LoadingWidget(),
                  ),
                ),
              if (viewModel.waiterDevices.status ==
                  WaiterDataEntityStatus.error)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: NotFoundWidget(),
                  ),
                ),
              if (viewModel.waiterDevices.data?.isNotEmpty ?? false)
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverList.list(
                    children: viewModel.waiterDevices.data!
                        .map((device) => BluettoothItemWidget(
                              device: device,
                            ))
                        .toList(),
                  ),
                )
            ]),
          ));
        }));
  }
}
