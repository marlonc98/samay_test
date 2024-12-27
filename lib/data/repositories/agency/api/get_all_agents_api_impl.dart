import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/data/db/db_scheme.dart';
import 'package:samay/data/db/db_setting.dart';
import 'package:samay/data/dto/agency_from_local_dto.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';

Future<Either<ExceptionEntity, List<AgencyEntity>>>
    getAllAgentsApiImpl() async {
  try {
    Either<ExceptionEntity, List<Map<String, dynamic>>> response =
        await GetIt.I.get<DbSetting>().getAllFromTable(AgencyTableScheme.table);

    if (response.isLeft) {
      return Left(response.left);
    }
    List<AgencyEntity> listOfAgencies =
        response.right.map((e) => AgencyFromLocalDto.fromJSON(e)).toList();
    return Right(listOfAgencies);
  } catch (e) {
    return Left(ExceptionEntity.fromException(e));
  }
}
