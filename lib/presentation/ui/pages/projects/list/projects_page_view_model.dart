import 'package:either_dart/either.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';
import 'package:samay/domain/entities/search_result_entity.dart';
import 'package:samay/domain/use_cases/project/search_projects_use_case.dart';
import 'package:samay/presentation/ui/pages/projects/list/projects_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';
import 'package:samay/utils/show_modal.dart';

class ProjectsPageViewModel extends ViewModel<ProjectsPage> {
  ProjectsPageViewModel({required super.context, required super.widget}) {
    _initPaginController();
  }
  ProjectFilterEntity filter = ProjectFilterEntity();
  String searching = "";
  int page = 1;
  final _itemsPerPage = 10;

  PagingController<int, ProjectEntity> pagingController =
      PagingController(firstPageKey: 1);

  void _initPaginController() {
    pagingController.addPageRequestListener((pageKey) {
      page = pageKey;
      _searchProjects();
    });
  }

  void handleOnChangeFilter(ProjectFilterEntity filter) async {
    this.filter = filter;
    page = 1;
    _searchProjects();
  }

  void _searchProjects() async {
    Either<ExceptionEntity, SearchResultEntity<ProjectEntity>> response =
        await getIt.get<SearchProjectsUseCase>().call(
              itemsPerPage: _itemsPerPage,
              page: page,
              filter: filter,
            );
    if (response.isLeft) {
      if (mounted) {
        ShowModal.showSnackBar(
            // ignore: use_build_context_synchronously
            context: context,
            text: localization.translate(response.left.code),
            error: true);
      }
      return;
    }
    if (page == 1) pagingController.itemList = [];
    if (response.right.data.isNotEmpty) {
      if (response.right.data.length < _itemsPerPage) {
        pagingController.appendLastPage(response.right.data);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(response.right.data, nextPageKey);
      }
    } else {
      pagingController.appendLastPage(response.right.data);
    }
  }
}
