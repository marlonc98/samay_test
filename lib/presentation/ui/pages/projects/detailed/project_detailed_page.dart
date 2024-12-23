import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/entities/waiter_data_entity.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/presentation/ui/pages/projects/detailed/project_detailed_widget_view_model.dart';
import 'package:samay/presentation/ui/widgets/image_network_with_load.dart';
import 'package:samay/presentation/ui/widgets/loading_widget.dart';
import 'package:samay/presentation/ui/widgets/not_found_widget.dart';
import 'package:samay/utils/currency_format.dart';

class ProjectDetailedPage extends StatelessWidget {
  static const String route = '/projects/detailed';
  final String id;
  const ProjectDetailedPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final AgencyState agencyState = Provider.of<AgencyState>(context);
    return ChangeNotifierProvider<ProjectDetailedPageViewModel>(
        create: (_) =>
            ProjectDetailedPageViewModel(context: context, widget: this),
        child: Consumer<ProjectDetailedPageViewModel>(
            builder: (context, viewModel, child) {
          if (viewModel.projectWaiterDataEntity.status ==
              WaiterDataEntityStatus.loading) {
            return const Scaffold(
              body: LoadingWidget(),
            );
          } else if (viewModel.projectWaiterDataEntity.status ==
              WaiterDataEntityStatus.error) {
            return const Scaffold(
              body: NotFoundWidget(),
            );
          }
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Stack(
                      children: [
                        ImageNetworkWithLoad(
                          viewModel.projectWaiterDataEntity.data!.imageUrl,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * .8,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            top: 15,
                            left: 15,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: (agencyState.selectedAgency == null
                                        ? Colors.black
                                        : Theme.of(context).primaryColor)
                                    .withAlpha(100),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.arrow_back,
                                size: 20,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Home",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 28),
                  ),
                  Text(
                    viewModel.projectWaiterDataEntity.data!.location,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "DESCRIPTION",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    viewModel.projectWaiterDataEntity.data!.description ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            bottomSheet: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            CurrencyFormat.formatWithSimbolCurrency(
                                viewModel.projectWaiterDataEntity.data!.price),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white)),
                        const SizedBox(width: 8),
                        const Text("+ taxes/fees"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Contact"),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
