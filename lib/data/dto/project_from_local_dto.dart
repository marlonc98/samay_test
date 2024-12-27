import 'package:samay/data/db/db_scheme.dart';
import 'package:samay/domain/entities/project_entity.dart';

class ProjectFromLocalDto {
  static ProjectEntity fromJSON(Map<String, dynamic> json) {
    return ProjectEntity(
      id: json[ProjectTableScheme.id].toString(),
      name: json[ProjectTableScheme.name],
      price: json[ProjectTableScheme.price],
      location: json[ProjectTableScheme.location],
      agencyId: json[ProjectTableScheme.agencyId].toString(),
      imageUrl: json[ProjectTableScheme.imageUrl] ?? "",
    );
  }

  static Map<String, dynamic> toJSON(ProjectEntity project) {
    return {
      ProjectTableScheme.id: project.id,
      ProjectTableScheme.name: project.name,
      ProjectTableScheme.price: project.price,
      ProjectTableScheme.location: project.location,
      ProjectTableScheme.agencyId: project.agencyId,
      ProjectTableScheme.imageUrl: project.imageUrl,
    };
  }
}
