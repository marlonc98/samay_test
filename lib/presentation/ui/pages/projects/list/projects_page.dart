import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/presentation/ui/pages/projects/detailed/project_detailed_page.dart';
import 'package:samay/presentation/ui/pages/projects/list/projects_page_view_model.dart';
import 'package:samay/presentation/ui/pages/projects/list/widgets/banner_project_searcher_widget.dart';
import 'package:samay/presentation/ui/pages/projects/list/widgets/card_project_widget.dart';

class ProjectsPage extends StatelessWidget {
  static const String route = '/projects';
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectsPageViewModel>(
        create: (_) => ProjectsPageViewModel(context: context, widget: this),
        child: Consumer<ProjectsPageViewModel>(
            builder: (context, viewModel, child) => Scaffold(
                    body: CustomScrollView(
                  slivers: [
                    BannerProjectSearcherWidget(
                        onChangeFilter: viewModel.handleOnChangeFilter),
                    PagedSliverList<int, ProjectEntity>(
                      pagingController: viewModel.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<ProjectEntity>(
                        itemBuilder: (context, item, index) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: CardProjectWidget(
                            project: item,
                            onTap: () => Navigator.of(context).pushNamed(
                                ProjectDetailedPage.route,
                                arguments: ProjectDetailedPage(id: item.id)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
