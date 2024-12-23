import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samay/domain/entities/aditional_field_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/domain/entities/waiter_data_entity.dart';
import 'package:samay/domain/use_cases/project/create_project_use_case.dart';
import 'package:samay/domain/use_cases/project/get_project_by_id_use_case.dart';
import 'package:samay/presentation/ui/pages/projects/create/project_create_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';
import 'package:samay/utils/currency_format.dart';
import 'package:samay/utils/key_words_constants.dart';

class ProjectCreatePageViewModel extends ViewModel<ProjectCreatePage> {
  ProjectCreatePageViewModel({required super.context, required super.widget}) {
    if (widget.id != null) handleLoadData();
  }

  TextEditingController controllerPrice = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> valuesForm = {};
  WaiterDataEntity<ProjectEntity> projectWaiterDataEntity = WaiterDataEntity();

  Map<String, dynamic> getCopyValuesForm() {
    Map<String, dynamic> copy = Map<String, dynamic>.from(valuesForm);
    copy.remove(KeyWordsConstants.projectCreatePageNameField);
    copy.remove(KeyWordsConstants.projectCreatePageAddressField);
    copy.remove(KeyWordsConstants.projectCreatePagePriceField);
    copy.remove(KeyWordsConstants.projectCreatePageDescriptionField);
    return copy;
  }

  String getKeyValue(String initial) =>
      initial.toLowerCase().replaceAll(" ", "_");

  void handleLoadData() async {
    Either<ExceptionEntity, ProjectEntity> projectEither =
        await GetIt.I.get<GetProjectByIdUseCase>().call(widget.id!);
    projectWaiterDataEntity = projectWaiterDataEntity.fromEither(projectEither);
    if (projectEither.isRight) {
      valuesForm[KeyWordsConstants.projectCreatePageImageField] =
          XFile(projectEither.right.imageUrl);
      valuesForm[KeyWordsConstants.projectCreatePageNameField] =
          projectEither.right.name;
      valuesForm[KeyWordsConstants.projectCreatePageAddressField] =
          projectEither.right.location;
      valuesForm[KeyWordsConstants.projectCreatePagePriceField] =
          projectEither.right.price;
      controllerPrice.text =
          CurrencyFormat.formatCurrency(projectEither.right.price);
      valuesForm[KeyWordsConstants.projectCreatePageDescriptionField] =
          projectEither.right.description;
      for (AditionalFieldEntity field in projectEither.right.aditionalFields) {
        valuesForm[getKeyValue(field.name)] = field.value;
      }
    }

    notifyListeners();
  }

  void _handleOnEditProject() async {
    ProjectEntity currentProject = ProjectEntity(
      id: widget.id!,
      agencyId: projectWaiterDataEntity.data!.agencyId,
      location: valuesForm[KeyWordsConstants.projectCreatePageAddressField],
      price: valuesForm[KeyWordsConstants.projectCreatePagePriceField],
      imageUrl: "",
      name: valuesForm[KeyWordsConstants.projectCreatePageNameField],
      aditionalFields: projectWaiterDataEntity.data!.aditionalFields
          .map((AditionalFieldEntity field) {
        return AditionalFieldEntity(
          name: field.name,
          value: valuesForm[getKeyValue(field.name)],
          type: field.type,
          optional: field.optional,
          hint: field.hint,
        );
      }).toList(),
    );
    Either<ExceptionEntity, ProjectEntity> response = await GetIt.I
        .get<CreateProjectUseCase>()
        .call(currentProject,
            valuesForm[KeyWordsConstants.projectCreatePageImageField]);
  }

  void _handleOnCreateProject() async {}

  void handleOnSave() {
    if (widget.id != null) {
      _handleOnEditProject();
    } else {
      _handleOnCreateProject();
    }
  }
}
