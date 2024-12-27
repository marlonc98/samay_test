import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samay/data/db/db_scheme.dart';
import 'package:samay/data/db/db_setting.dart';
import 'package:samay/data/dto/project_from_local_dto.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';

Future<Either<ExceptionEntity, ProjectEntity>> updateProjectApiImpl(
    ProjectEntity project, XFile? image) async {
  try {
    if (image != null) {
      project.imageUrl = image.path;
    }
    Map<String, dynamic> data = ProjectFromLocalDto.toJSON(project);
    Either<ExceptionEntity, Map<String, dynamic>> response =
        await GetIt.I.get<DbSetting>().update(
              id: int.parse(project.id),
              table: ProjectTableScheme.table,
              values: data,
            );
    if (response.isLeft) {
      return Left(response.left);
    }
    return Right(ProjectFromLocalDto.fromJSON(response.right));
  } catch (e) {
    return Left(ExceptionEntity.fromException(e));
  }
}
