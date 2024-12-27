import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/entities/aditional_field_entity.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/waiter_data_entity.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/presentation/ui/pages/projects/create/project_create_page_view_model.dart';
import 'package:samay/presentation/ui/widgets/custom_botttom_navigation_widget.dart';
import 'package:samay/presentation/ui/widgets/form/camera_picker_widget.dart';
import 'package:samay/presentation/ui/widgets/form/date_picker_widget.dart';
import 'package:samay/presentation/ui/widgets/form/validators.dart';
import 'package:samay/presentation/ui/widgets/loading_widget.dart';
import 'package:samay/presentation/ui/widgets/not_found_widget.dart';
import 'package:samay/utils/currency_format.dart';
import 'package:samay/utils/key_words_constants.dart';

class ProjectCreatePage extends StatelessWidget {
  static const String route = '/projects/create';
  final String? id;
  const ProjectCreatePage({super.key, this.id});

  InputDecoration _inputDecoration(
      {required String label,
      required String hint,
      required BuildContext context}) {
    return InputDecoration(
        labelText: label,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        labelStyle: Theme.of(context).textTheme.titleSmall,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hint);
  }

  Widget _getWidgetFromAditionalField({
    required AditionalFieldEntity aditionalField,
    required BuildContext context,
    required Map<String, dynamic> valuesForm,
  }) {
    final _getKeyName = Provider.of<ProjectCreatePageViewModel>(context)
        .getKeyValue(aditionalField.name);
    switch (aditionalField.type) {
      case AditionalFielType.text:
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: _inputDecoration(
              label: aditionalField.name,
              hint: aditionalField.hint,
              context: context),
          initialValue: valuesForm[_getKeyName],
          validator: (val) => Validators.check(
              text: val,
              context: context,
              required: !aditionalField.optional,
              fields: valuesForm,
              type: FormType.text,
              keyText: _getKeyName),
        );
      case AditionalFielType.number:
        return TextFormField(
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: valuesForm[_getKeyName]?.toString(),
          decoration: _inputDecoration(
              label: aditionalField.name,
              hint: aditionalField.hint,
              context: context),
          validator: (val) => Validators.check(
              text: val,
              context: context,
              maxValue: 999999999,
              minValue: 0,
              required: !aditionalField.optional,
              fields: valuesForm,
              type: FormType.number,
              keyText: _getKeyName),
        );
      case AditionalFielType.date:
        return DatePickerWidget(
            title: aditionalField.name,
            defaultValue: valuesForm[_getKeyName],
            validator: (val) => Validators.check(
                text: val,
                context: context,
                required: !aditionalField.optional,
                fields: valuesForm,
                type: FormType.date,
                keyText: _getKeyName));
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AgencyEntity? agency =
        Provider.of<AgencyState>(context).selectedAgency;
    return ChangeNotifierProvider<ProjectCreatePageViewModel>(
      create: (_) => ProjectCreatePageViewModel(context: context, widget: this),
      child: Consumer<ProjectCreatePageViewModel>(
          builder: (context, viewModel, child) {
        if (id != null &&
            viewModel.projectWaiterDataEntity.status ==
                WaiterDataEntityStatus.loading) {
          return const Scaffold(
            body: LoadingWidget(),
          );
        } else if (id != null &&
            viewModel.projectWaiterDataEntity.status ==
                WaiterDataEntityStatus.error) {
          return const Scaffold(
            body: NotFoundWidget(),
          );
        }
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            title: Text(viewModel.localization.translate(id == null
                ? KeyWordsConstants.projectCreatePageTitleCreate
                : KeyWordsConstants.projectCreatePageTitleEdit)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CameraPickerWidget(
                        value: viewModel.valuesForm[
                            KeyWordsConstants.projectCreatePageImageField],
                        maxFiles: 1,
                        onChange: (value) => viewModel.valuesForm[
                                KeyWordsConstants.projectCreatePageImageField] =
                            value,
                        // validator: (val) => Validators.check(
                        //     text: val, context: context, required: true),
                        title: viewModel.localization.translate(
                            KeyWordsConstants.projectCreatePageImageField)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: viewModel.valuesForm[
                          KeyWordsConstants.projectCreatePageNameField],
                      decoration: _inputDecoration(
                          label: viewModel.localization.translate(
                              KeyWordsConstants.projectCreatePageNameField),
                          hint: viewModel.localization.translate(
                              KeyWordsConstants.projectCreatePageNameHint),
                          context: context),
                      validator: (val) => Validators.check(
                          text: val,
                          context: context,
                          minLength: 3,
                          maxLength: 50,
                          required: true,
                          fields: viewModel.valuesForm,
                          keyText:
                              KeyWordsConstants.projectCreatePageNameField),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: viewModel.valuesForm[
                          KeyWordsConstants.projectCreatePageAddressField],
                      decoration: _inputDecoration(
                          label: viewModel.localization.translate(
                              KeyWordsConstants.projectCreatePageAddressField),
                          hint: viewModel.localization.translate(
                              KeyWordsConstants.projectCreatePageAddressHint),
                          context: context),
                      validator: (val) => Validators.check(
                          text: val,
                          context: context,
                          minLength: 3,
                          maxLength: 50,
                          required: true,
                          fields: viewModel.valuesForm,
                          keyText:
                              KeyWordsConstants.projectCreatePageAddressField),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: viewModel.controllerPrice,
                      onChanged: (String? val) {
                        CurrencyFormat.loadControllerCurrency(
                            viewModel.controllerPrice,
                            CurrencyFormat.usdToInt(viewModel.valuesForm[
                                    KeyWordsConstants
                                        .projectCreatePagePriceField]
                                .toString()));
                        viewModel.valuesForm[KeyWordsConstants
                            .projectCreatePagePriceField] = val;
                      },
                      decoration: _inputDecoration(
                          label: viewModel.localization.translate(
                              KeyWordsConstants.projectCreatePagePriceField),
                          hint: viewModel.localization.translate(
                              KeyWordsConstants.projectCreatePagePriceHint),
                          context: context),
                      validator: (val) => Validators.check(
                        text: val,
                        context: context,
                        maxValue: 9999999999,
                        minValue: 0,
                        required: true,
                        type: FormType.currency,
                        fields: viewModel.valuesForm,
                        keyText: KeyWordsConstants.projectCreatePagePriceField,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLines: 5,
                      minLines: 3,
                      initialValue: viewModel.valuesForm[
                          KeyWordsConstants.projectCreatePageDescriptionField],
                      decoration: _inputDecoration(
                          label: viewModel.localization.translate(
                              KeyWordsConstants
                                  .projectCreatePageDescriptionField),
                          hint: viewModel.localization.translate(
                              KeyWordsConstants
                                  .projectCreatePageDescriptionHint),
                          context: context),
                      validator: (val) => Validators.check(
                          text: val,
                          context: context,
                          required: true,
                          fields: viewModel.valuesForm,
                          keyText: KeyWordsConstants
                              .projectCreatePageDescriptionField),
                    ),
                    const SizedBox(height: 8),
                    ...agency?.aditionalFields
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: _getWidgetFromAditionalField(
                                      aditionalField: e,
                                      context: context,
                                      valuesForm: viewModel.valuesForm),
                                ))
                            .toList() ??
                        [],
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: viewModel.handleOnSave,
                      child: Text(viewModel.localization.translate(id != null
                          ? KeyWordsConstants.update
                          : KeyWordsConstants.save)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar:
              CustomBotttomNavigationWidget(key: key, currentRoute: route),
        );
      }),
    );
  }
}
