import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';
import 'package:samay/domain/entities/search_result_entity.dart';
import 'package:samay/domain/repositories/project_repository.dart';
import 'package:samay/domain/states/agency_state.dart';

class SearchProjectsUseCase {
  ProjectRepository projectRepository;
  AgencyState agencyState;

  SearchProjectsUseCase(
      {required this.projectRepository, required this.agencyState});

  Future<Either<ExceptionEntity, SearchResultEntity<ProjectEntity>>> call({
    required int page,
    required int itemsPerPage,
    ProjectFilterEntity? filter,
  }) {
    filter?.agencyId = agencyState.selectedAgency?.id;
    return projectRepository.searchProjects(
      page: page,
      itemsPerPage: itemsPerPage,
      filter: filter,
    );
  }
}
