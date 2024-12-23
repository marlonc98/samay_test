import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/entities/waiter_data_entity.dart';
import 'package:samay/domain/use_cases/project/get_project_by_id_use_case.dart';
import 'package:samay/presentation/ui/pages/projects/detailed/project_detailed_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';

class ProjectDetailedPageViewModel extends ViewModel<ProjectDetailedPage> {
  ProjectDetailedPageViewModel(
      {required super.context, required super.widget}) {
    _handleGetProject();
  }

  WaiterDataEntity<ProjectEntity> projectWaiterDataEntity = WaiterDataEntity();

  void _handleGetProject() async {
    Either<ExceptionEntity, ProjectEntity> projectEither =
        await GetIt.I.get<GetProjectByIdUseCase>().call(widget.id);
    projectWaiterDataEntity = projectWaiterDataEntity.fromEither(projectEither);
    notifyListeners();
  }
}
