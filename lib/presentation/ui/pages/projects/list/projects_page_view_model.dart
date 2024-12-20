import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';
import 'package:samay/presentation/ui/pages/projects/list/projects_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';

class ProjectsPageViewModel extends ViewModel<ProjectsPage> {
  ProjectsPageViewModel({required super.context, required super.widget});

  PagingController<int, ProjectEntity> pagingController =
      PagingController(firstPageKey: 1);

  void handleOnChangeFilter(ProjectFilterEntity filter) async {}
  void handleOnClickAddProject() async {}
}
