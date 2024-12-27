import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/use_cases/domotic/add_interaction_device_use_case.dart';
import 'package:samay/domain/use_cases/domotic/disconnect_device_use_case.dart';
import 'package:samay/presentation/ui/pages/domotic/detailed/detailed_device_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';
import 'package:samay/utils/show_modal.dart';

class DetailedDevicePageViewModel extends ViewModel<DetailedDevicePage> {
  DetailedDevicePageViewModel(
      {required super.context,
      required super.widget,
      required super.isMounted});
  TextEditingController interactionController = TextEditingController();

  void handleDeleteDevice() async {
    Either<ExceptionEntity, void> response =
        await GetIt.I.get<DisconnectDeviceUseCase>().call(widget.device);
    if (response.isLeft && mounted) {
      ShowModal.showSnackBar(
          // ignore: use_build_context_synchronously
          context: context,
          text: response.left.code,
          error: true);
    } else if (mounted) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  void handleAddInteraction() async {
    String interaction = interactionController.text;
    interactionController.clear();
    Either<ExceptionEntity, void> response = await GetIt.I
        .get<AddInteractionDeviceUseCase>()
        .call(widget.device, interaction);
    if (mounted && response.isLeft) {
      ShowModal.showSnackBar(
          // ignore: use_build_context_synchronously
          context: context,
          text: response.left.code,
          error: true);
    }
    if (mounted) notifyListeners();
  }

  void turnDeviceOnOff(bool value) async {
    widget.device.on = value;
    notifyListeners();
    Either<ExceptionEntity, void> response = await GetIt.I
        .get<AddInteractionDeviceUseCase>()
        .call(widget.device, value ? "Turn On" : "Turn Off");
    if (response.isLeft && mounted) {
      ShowModal.showSnackBar(
          // ignore: use_build_context_synchronously
          context: context,
          text: response.left.code,
          error: true);
    }
  }
}
