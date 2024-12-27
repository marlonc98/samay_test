import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/data/db/db_scheme.dart';
import 'package:samay/data/db/db_setting.dart';
import 'package:samay/data/dto/project_from_local_dto.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';
import 'package:samay/domain/entities/search_result_entity.dart';
import 'package:samay/utils/key_words_constants.dart';

Future<Either<ExceptionEntity, SearchResultEntity<ProjectEntity>>>
    searchProjectsApiImpl(
        {required int page,
        required int itemsPerPage,
        ProjectFilterEntity? filter}) async {
  try {
    List<String> queries = [];
    if (filter?.agencyId != null && filter!.agencyId!.isNotEmpty) {
      queries.add("${ProjectTableScheme.agencyId} = ${filter.agencyId}");
    }
    if (filter?.location != null && filter!.location!.isNotEmpty) {
      queries.add("${ProjectTableScheme.location} like %${filter.location}%");
    }
    if (filter?.querySearch != null && filter!.querySearch!.isNotEmpty) {
      queries.add("${ProjectTableScheme.name} like %${filter.querySearch}%");
    }
    if (filter?.maxPrice != null && filter!.maxPrice! > 0) {
      queries.add("${ProjectTableScheme.price} <= ${filter.maxPrice}");
    }
    if (filter?.minPrice != null && filter!.minPrice! > 0) {
      queries.add("${ProjectTableScheme.price} >= ${filter.minPrice}");
    }

    String query = queries.join(" and ");

    Either<ExceptionEntity, SearchResultEntity<dynamic>> response =
        await GetIt.I.get<DbSetting>().search(
            table: ProjectTableScheme.table,
            page: page - 1,
            itemsPerPage: itemsPerPage,
            query: query);
    if (response.isLeft) {
      return Left(response.left);
    } else {
      List<ProjectEntity> projects = response.right.data
          .map((e) => ProjectFromLocalDto.fromJSON(e))
          .toList();
      return Right(SearchResultEntity<ProjectEntity>(
        currentPage: response.right.currentPage,
        data: projects,
        totalItems: response.right.totalItems,
        itemsPerPage: response.right.itemsPerPage,
        lastpage: response.right.lastpage,
      ));
    }
  } catch (e) {
    return Left(ExceptionEntity(
        code: KeyWordsConstants.projectApiErrorSearchingProjects));
  }
}
