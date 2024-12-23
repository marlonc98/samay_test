import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/repositories/project_repository.dart';

class CreateProjectUseCase {
  ProjectRepository projectRepository;

  CreateProjectUseCase({required this.projectRepository});

  Future<Either<ExceptionEntity, ProjectEntity>> call(
      ProjectEntity project, XFile image) {
    return projectRepository.createProject(project, image);
  }
}
