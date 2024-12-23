import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/repositories/project_repository.dart';

class GetProjectByIdUseCase {
  ProjectRepository projectRepository;

  GetProjectByIdUseCase({required this.projectRepository});

  Future<Either<ExceptionEntity, ProjectEntity>> call(String id) {
    return projectRepository.getPropertyById(id);
  }
}
