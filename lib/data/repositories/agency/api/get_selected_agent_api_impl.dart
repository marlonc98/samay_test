import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/data/db/db_scheme.dart';
import 'package:samay/data/db/db_setting.dart';
import 'package:samay/data/dto/agency_from_local_dto.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Either<ExceptionEntity, AgencyEntity?>> getSelectedAgentApiImpl(
    String spId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? selectedAgentId = prefs.getString(spId);
  if (selectedAgentId == null) {
    return const Right(null);
  }

  Either<ExceptionEntity, Map<String, dynamic>> getFromLocal = await GetIt.I
      .get<DbSetting>()
      .getById(table: AgencyTableScheme.table, id: int.parse(selectedAgentId));
  if (getFromLocal.isLeft) {
    return Left(getFromLocal.left);
  }

  return Right(AgencyFromLocalDto.fromJSON(getFromLocal.right));
}
