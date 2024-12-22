import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';
import 'package:samay/domain/entities/search_result_entity.dart';
import 'package:samay/domain/repositories/project_repository.dart';

ProjectEntity fakeProject = ProjectEntity(
    id: 'id',
    agencyId: 'agencyId',
    location: '123 Disney Way, Willingmington, WV 24291',
    name: 'Home on Beachront',
    price: 450000,
    imageUrl:
        'https://dvvjkgh94f2v6.cloudfront.net/4969bd64/43360858/83dcefb7.jpeg');

class ProjectRepositoryFake extends ProjectRepository {
  @override
  Future<Either<ExceptionEntity, ProjectEntity>> getPropertyById(
      String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(fakeProject);
  }

  @override
  Future<Either<ExceptionEntity, SearchResultEntity<ProjectEntity>>>
      searchProjects(
          {required int page,
          required int itemsPerPage,
          ProjectFilterEntity? filter}) async {
    await Future.delayed(const Duration(seconds: 1));
    const pageLimit = 3;
    if (page > pageLimit) {
      return Right(SearchResultEntity(
          currentPage: page,
          data: [],
          itemsPerPage: itemsPerPage,
          totalItems: pageLimit * itemsPerPage,
          lastpage: page));
    }
    return Right(SearchResultEntity(
        currentPage: page,
        data: List.generate(itemsPerPage, (index) => fakeProject),
        itemsPerPage: itemsPerPage,
        totalItems: pageLimit * itemsPerPage,
        lastpage: page));
  }
}
