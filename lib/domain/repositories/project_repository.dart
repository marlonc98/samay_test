import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';
import 'package:samay/domain/entities/search_result_entity.dart';

abstract class ProjectRepository {
  Future<Either<ExceptionEntity, SearchResultEntity<ProjectEntity>>>
      searchProjects({
    required int page,
    required int itemsPerPage,
    ProjectFilterEntity? filter,
  });
  Future<Either<ExceptionEntity, ProjectEntity>> getPropertyById(String id);
}
