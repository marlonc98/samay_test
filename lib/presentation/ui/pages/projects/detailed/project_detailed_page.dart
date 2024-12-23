import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/entities/aditional_field_entity.dart';
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
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    actions: [
                      InkWell(
                        onTap: viewModel.handleEdit,
                        child: Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (agencyState.selectedAgency == null
                                    ? Colors.black
                                    : Theme.of(context).primaryColor)
                                .withAlpha(100),
                          ),
                          padding: const EdgeInsets.all(18),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    leading: Container(
                      margin: const EdgeInsets.only(left: 8),
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
                    ),
                    expandedHeight: MediaQuery.of(context).size.width * .8,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: ImageNetworkWithLoad(
                            viewModel.projectWaiterDataEntity.data!.imageUrl,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * .8,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          viewModel.projectWaiterDataEntity.data!.description ??
                              "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        ...viewModel
                            .projectWaiterDataEntity.data!.aditionalFields
                            .map((AditionalFieldEntity aditional) => SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        aditional.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        aditional.value.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                )),
                        const SizedBox(height: 100),
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomSheet: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
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
