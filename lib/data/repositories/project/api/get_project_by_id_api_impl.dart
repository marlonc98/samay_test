import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/data/db/db_scheme.dart';
import 'package:samay/data/db/db_setting.dart';
import 'package:samay/data/dto/project_from_local_dto.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';

Future<Either<ExceptionEntity, ProjectEntity>> getPropertyByIdApiImpl(
    String id) async {
  try {
    Either<ExceptionEntity, Map<String, dynamic>> response = await GetIt.I
        .get<DbSetting>()
        .getById(id: int.parse(id), table: ProjectTableScheme.table);
    if (response.isLeft) {
      return Left(response.left);
    }
    return Right(ProjectFromLocalDto.fromJSON(response.right));
  } catch (e) {
    return Left(ExceptionEntity.fromException(e));
  }
}
