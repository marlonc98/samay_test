import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/repositories/project_repository.dart';
import 'package:samay/domain/states/agency_state.dart';

class CreateProjectUseCase {
  ProjectRepository projectRepository;
  AgencyState agencyState;

  CreateProjectUseCase(
      {required this.projectRepository, required this.agencyState});

  Future<Either<ExceptionEntity, ProjectEntity>> call(
      ProjectEntity project, XFile image) {
    project.agencyId = agencyState.selectedAgency!.id;
    return projectRepository.createProject(project, image);
  }
}
