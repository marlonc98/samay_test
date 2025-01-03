import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:samay/presentation/ui/pages/projects/create/project_create_page.dart';
import 'package:samay/presentation/ui/pages/projects/detailed/project_detailed_page.dart';
import 'package:samay/presentation/ui/pages/projects/list/projects_page_view_model.dart';
import 'package:samay/presentation/ui/pages/projects/list/widgets/banner_project_searcher_widget.dart';
import 'package:samay/presentation/ui/pages/projects/list/widgets/card_project_widget.dart';
import 'package:samay/presentation/ui/widgets/custom_botttom_navigation_widget.dart';
import 'package:samay/utils/key_words_constants.dart';

class ProjectsPage extends StatelessWidget {
  static const String route = '/projects';
  const ProjectsPage({super.key});

  SliverToBoxAdapter _addProjectButton(BuildContext context) {
    final localization = Provider.of<LocalizationState>(context);
    return SliverToBoxAdapter(
      child: Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(ProjectCreatePage.route),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  localization
                      .translate(KeyWordsConstants.projectPageAddProject),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                  margin: const EdgeInsets.only(left: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final agencyState = Provider.of<AgencyState>(context);
    return ChangeNotifierProvider<ProjectsPageViewModel>(
        create: (_) => ProjectsPageViewModel(context: context, widget: this),
        child: Consumer<ProjectsPageViewModel>(
            builder: (context, viewModel, child) => Scaffold(
                resizeToAvoidBottomInset: true,
                bottomNavigationBar: CustomBotttomNavigationWidget(
                  key: key,
                  currentRoute: route,
                ),
                body: CustomScrollView(
                  slivers: [
                    BannerProjectSearcherWidget(
                        onChangeFilter: viewModel.handleOnChangeFilter),
                    if (agencyState.selectedAgency != null)
                      _addProjectButton(context),
                    PagedSliverList<int, ProjectEntity>(
                      pagingController: viewModel.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<ProjectEntity>(
                        itemBuilder: (context, item, index) => Container(
                          margin: const EdgeInsets.only(
                              bottom: 8, left: 16, right: 16),
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
