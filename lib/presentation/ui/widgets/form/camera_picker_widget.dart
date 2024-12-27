// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:samay/utils/key_words_constants.dart';
import 'package:samay/utils/show_modal.dart';

class CameraPickerWidget extends FormField {
  final String title;
  final Function(dynamic value)? onChange;
  final int? maxFiles;
  final dynamic value;
  final bool showDelete;
  final Function(dynamic item)? onTap;

  CameraPickerWidget(
      {super.key,
      super.validator,
      required this.title,
      super.enabled = true,
      this.value,
      this.onChange,
      this.showDelete = true,
      this.onTap,
      this.maxFiles})
      : super(builder: (FormFieldState<dynamic> state) {
          return CameraPickerItem(
            title: title,
            enabled: enabled,
            errorText: state.errorText,
            maxFiles: maxFiles,
            onChange: (dynamic value) {
              state.didChange(value);
              onChange?.call(value);
            },
            value: value,
          );
        });
}

class CameraPickerItem extends StatefulWidget {
  final String title;
  final Function(dynamic value)? onChange;
  final bool enabled;
  final int? maxFiles;
  final String? errorText;
  final dynamic value;
  const CameraPickerItem(
      {super.key,
      this.onChange,
      this.enabled = true,
      required this.value,
      required this.title,
      this.errorText,
      this.maxFiles});

  @override
  createState() => _CameraPickerItemState();
}

class _CameraPickerItemState extends State<CameraPickerItem> {
  List<XFile> selectedFiles = [];
  late LocalizationState localization;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      selectedFiles = [widget.value];
    }
  }

  _openCamera() async {
    if (!widget.enabled) return;
    final XFile? picked = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (picked != null) {
      _change([picked]);
    }
    Navigator.of(context).pop();
  }

  _openImagePicker() async {
    if (!widget.enabled) return;
    final List<XFile> picked = await ImagePicker().pickMultiImage();
    if (picked.isNotEmpty) {
      _change(picked);
    }
    Navigator.of(context).pop();
  }

  _openOneImagePicker() async {
    if (!widget.enabled) return;
    final XFile? picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (picked != null) {
      _change([picked]);
    }
    Navigator.of(context).pop();
  }

  _change(List<XFile> files) {
    setState(() {
      if (widget.maxFiles == 1) {
        widget.onChange?.call(files.first);
        selectedFiles = files;
      } else {
        selectedFiles = files;
        widget.onChange?.call(selectedFiles);
      }
    });
  }

  _handleSelectImage(BuildContext context) {
    final Color colorOfText =
        Brightness.light == MediaQuery.of(context).platformBrightness
            ? Theme.of(context).primaryColor
            : Colors.white;
    final ButtonStyle styleButton = TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: colorOfText,
      iconColor: colorOfText,
    );
    ShowModal.openDialog(
        context: context,
        title:
            localization.translate(KeyWordsConstants.cameraPickerWidgetTitle),
        text: localization.translate(KeyWordsConstants.cameraPickerWidgetText),
        actions: [
          TextButton.icon(
            onPressed: _openCamera,
            style: styleButton,
            label: Text(
              localization
                  .translate(KeyWordsConstants.cameraPickerWidgetCamera),
            ),
            icon: const Icon(
              Icons.camera_alt,
            ),
          ),
          TextButton.icon(
            onPressed:
                widget.maxFiles == 1 ? _openOneImagePicker : _openImagePicker,
            style: styleButton,
            label: Text(
              localization
                  .translate(KeyWordsConstants.cameraPickerWidgetGallery),
            ),
            icon: const Icon(
              Icons.photo_library,
            ),
          ),
        ]);
  }

  _handleDeleteImage(XFile file) {
    setState(() {
      selectedFiles.remove(file);
    });
    widget.onChange?.call(selectedFiles);
  }

  bool _isWebURL(String url) {
    if (url.startsWith("http://") || url.startsWith("https://")) return true;
    return false;
  }

  Widget cardPreviewImage(XFile file) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        child: Stack(
          children: [
            _isWebURL(file.path)
                ? Image.network(
                    file.path,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(file.path),
                    fit: BoxFit.cover,
                  ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black.withAlpha(125),
                child: TextButton.icon(
                    onPressed: () => _handleDeleteImage(file),
                    label: Text(
                      localization.translate(KeyWordsConstants.delete),
                      style: const TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    localization = Provider.of<LocalizationState>(context);
    return Column(
      children: [
        if (widget.enabled)
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () => _handleSelectImage(context),
              child: Container(
                constraints: const BoxConstraints(minHeight: 200),
                width: double.infinity,
                decoration: BoxDecoration(
                  image: selectedFiles.isNotEmpty
                      ? DecorationImage(
                          image: _isWebURL(selectedFiles.first.path)
                              ? NetworkImage(selectedFiles.first.path)
                              : FileImage(File(selectedFiles.first.path)),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withAlpha(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: selectedFiles.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              size: 70,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.color
                                  ?.withAlpha(230),
                            ),
                            Text(
                              widget.title,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          width: double.infinity,
          child: widget.errorText != null
              ? Text(
                  widget.errorText!,
                  style: const TextStyle(color: Colors.red),
                )
              : Container(),
        )
      ],
    );
  }
}
