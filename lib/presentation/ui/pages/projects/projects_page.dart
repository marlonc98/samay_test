import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/presentation/ui/pages/projects/projects_page_view_model.dart';

class ProjectsPage extends StatelessWidget {
  static const String route = '/cat';
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectsPageViewModel>(
        create: (_) => ProjectsPageViewModel(context: context, widget: this),
        child: Consumer<ProjectsPageViewModel>(
            builder: (context, viewModel, child) => Scaffold(
                    body: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PagedListView<int, ProjectEntity>(
                          padding: const EdgeInsets.all(0),
                          pagingController: viewModel.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<CatEntity>(
                            itemBuilder: (context, item, index) => Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: CatCardWidget(
                                cat: item,
                                onTap: () => Navigator.of(context).pushNamed(
                                    DetailedCatPage.route,
                                    arguments: DetailedCatPage(id: item.id)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
