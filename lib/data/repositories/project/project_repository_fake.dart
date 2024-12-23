import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samay/domain/entities/aditional_field_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';
import 'package:samay/domain/entities/search_result_entity.dart';
import 'package:samay/domain/repositories/project_repository.dart';

ProjectEntity fakeProject = ProjectEntity(
    id: 'id',
    agencyId: 'agencyId',
    location: '123 Disney Way, Willingmington, WV 24291',
    name: 'Home on Beachront',
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer fermentum tincidunt ultricies. Donec tempus dignissim orci, et malesuada odio commodo at. Nullam euismod ligula nec velit accumsan fringilla. Cras vehicula nunc ac felis viverra, eu sollicitudin dui suscipit. Nam magna ipsum, posuere porta felis sit amet, placerat finibus dolor. Nullam dictum condimentum massa, sit amet aliquam quam. Cras nec orci imperdiet, venenatis dolor vel, auctor velit. Quisque ut erat eu mi dapibus lacinia. \n Etiam porttitor eros quis massa porttitor auctor. Sed a blandit orci. Maecenas egestas suscipit consequat. Nam et ante ante. Suspendisse lobortis ut erat vitae consectetur. Duis eget lorem accumsan, hendrerit sapien nec, lobortis ante. Nunc in tortor tempor ipsum lobortis scelerisque vel eu diam. Duis sed nisl ut metus placerat facilisis. Fusce porttitor, leo at iaculis imperdiet, est justo consequat quam, vitae aliquam sapien elit nec leo. \n \nLorem ipsum dolor sit amet, consectetur adipiscing elit. Integer fermentum tincidunt ultricies. Donec tempus dignissim orci, et malesuada odio commodo at. Nullam euismod ligula nec velit accumsan fringilla. Cras vehicula nunc ac felis viverra, eu sollicitudin dui suscipit. Nam magna ipsum, posuere porta felis sit amet, placerat finibus dolor. Nullam dictum condimentum massa, sit amet aliquam quam. Cras nec orci imperdiet, venenatis dolor vel, auctor velit. Quisque ut erat eu mi dapibus lacinia. \n Etiam porttitor eros quis massa porttitor auctor. Sed a blandit orci. Maecenas egestas suscipit consequat. Nam et ante ante. Suspendisse lobortis ut erat vitae consectetur. Duis eget lorem accumsan, hendrerit sapien nec, lobortis ante. Nunc in tortor tempor ipsum lobortis scelerisque vel eu diam. Duis sed nisl ut metus placerat facilisis. Fusce porttitor, leo at iaculis imperdiet, est justo consequat quam, vitae aliquam sapien elit nec leo.",
    price: 450000,
    aditionalFields: [
      AditionalFieldEntity(
          name: "Certificates",
          type: AditionalFielType.text,
          hint: "ISO ...",
          value: "ISO 121212, ISO 121212"),
      AditionalFieldEntity(
          name: "Built Year",
          type: AditionalFielType.number,
          value: "2021",
          hint: "1999..."),
      AditionalFieldEntity(
          name: 'Taxes Dates',
          type: AditionalFielType.date,
          value: DateTime.now(),
          hint: "205-12-11")
    ],
    imageUrl:
        'https://dvvjkgh94f2v6.cloudfront.net/4969bd64/43360858/83dcefb7.jpeg');

class ProjectRepositoryFake extends ProjectRepository {
  @override
  Future<Either<ExceptionEntity, ProjectEntity>> getPropertyById(
      String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(fakeProject);
  }

  @override
  Future<Either<ExceptionEntity, SearchResultEntity<ProjectEntity>>>
      searchProjects(
          {required int page,
          required int itemsPerPage,
          ProjectFilterEntity? filter}) async {
    await Future.delayed(const Duration(seconds: 1));
    const pageLimit = 3;
    if (page > pageLimit) {
      return Right(SearchResultEntity(
          currentPage: page,
          data: [],
          itemsPerPage: itemsPerPage,
          totalItems: pageLimit * itemsPerPage,
          lastpage: page));
    }
    return Right(SearchResultEntity(
        currentPage: page,
        data: List.generate(itemsPerPage, (index) => fakeProject),
        itemsPerPage: itemsPerPage,
        totalItems: pageLimit * itemsPerPage,
        lastpage: page));
  }

  @override
  Future<Either<ExceptionEntity, ProjectEntity>> createProject(
      ProjectEntity project, XFile image) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(fakeProject);
  }

  @override
  Future<Either<ExceptionEntity, ProjectEntity>> updateProject(
      ProjectEntity project, XFile? image) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(fakeProject);
  }
}
