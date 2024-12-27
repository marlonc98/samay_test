import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samay/data/repositories/project/api/create_project_api_api_impl.dart';
import 'package:samay/data/repositories/project/api/get_project_by_id_api_impl.dart';
import 'package:samay/data/repositories/project/api/search_projects_api_impl.dart';
import 'package:samay/data/repositories/project/api/update_project_api_impl.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';
import 'package:samay/domain/entities/search_result_entity.dart';
import 'package:samay/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  @override
  Future<Either<ExceptionEntity, ProjectEntity>> createProject(
          ProjectEntity project, XFile image) =>
      createProjectApiImpl(project, image);

  @override
  Future<Either<ExceptionEntity, ProjectEntity>> getPropertyById(String id) =>
      getPropertyByIdApiImpl(id);

  @override
  Future<Either<ExceptionEntity, SearchResultEntity<ProjectEntity>>>
      searchProjects(
              {required int page,
              required int itemsPerPage,
              ProjectFilterEntity? filter}) =>
          searchProjectsApiImpl(
              page: page, itemsPerPage: itemsPerPage, filter: filter);

  @override
  Future<Either<ExceptionEntity, ProjectEntity>> updateProject(
          ProjectEntity project, XFile? image) =>
      updateProjectApiImpl(project, image);
}
