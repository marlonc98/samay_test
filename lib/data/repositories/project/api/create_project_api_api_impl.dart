import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samay/data/db/db_scheme.dart';
import 'package:samay/data/db/db_setting.dart';
import 'package:samay/data/dto/project_from_local_dto.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/utils/key_words_constants.dart';

@override
Future<Either<ExceptionEntity, ProjectEntity>> createProjectApiImpl(
    ProjectEntity project, XFile image) async {
  try {
    project.imageUrl = image.path;
    Map<String, dynamic> data = ProjectFromLocalDto.toJSON(project);
    data.remove(ProjectTableScheme.id);
    Either<ExceptionEntity, Map<String, dynamic>> response = await GetIt.I
        .get<DbSetting>()
        .insert(table: ProjectTableScheme.table, data: data);
    if (response.isLeft) {
      return Left(response.left);
    }
    return Right(ProjectFromLocalDto.fromJSON(response.right));
  } catch (e) {
    return Left(ExceptionEntity(
        code: KeyWordsConstants.projectApiErrorCreatingProject));
  }
}
