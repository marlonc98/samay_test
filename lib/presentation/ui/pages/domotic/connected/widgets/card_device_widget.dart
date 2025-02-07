import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:samay/domain/use_cases/domotic/add_interaction_device_use_case.dart';
import 'package:samay/presentation/ui/widgets/image_network_with_load_widget.dart';
import 'package:samay/utils/images_constants.dart';
import 'package:samay/utils/key_words_constants.dart';

class CardDeviceWidget extends StatefulWidget {
  final BluetoothDeviceEntity device;
  final double? elevation;
  final Function(BluetoothDeviceEntity)? onTap;
  final EdgeInsetsGeometry? padding;
  final Function(bool)? turnDeviceOnOff;

  const CardDeviceWidget({
    super.key,
    required this.device,
    this.onTap,
    this.elevation,
    this.padding,
    this.turnDeviceOnOff,
  });

  @override
  State<CardDeviceWidget> createState() => _CardDeviceWidgetState();
}

class _CardDeviceWidgetState extends State<CardDeviceWidget> {
  final localization = GetIt.I.get<LocalizationState>();
  void turnDeviceOnOff(bool value) async {
    Either<ExceptionEntity, void> result = await GetIt.I
        .get<AddInteractionDeviceUseCase>()
        .call(
            widget.device,
            localization.translate(value
                ? KeyWordsConstants.cardDeviceWidgetTurnOn
                : KeyWordsConstants.cardDeviceWidgetTurnOff));
    if (result.isLeft && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result.left.message),
      ));
    }
  }

  @override
  void initState() {
    _checkConnection();
    super.initState();
  }

  void _checkConnection() {
    widget.device.deviceBluetooth?.connectionState
        .listen((BluetoothConnectionState st) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.elevation,
      child: Container(
        padding: widget.padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            InkWell(
                onTap: () => widget.onTap?.call(widget.device),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (widget.device.charge != null)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: CircularProgressIndicator(
                          value: widget.device.charge! / 100,
                          strokeWidth: 10,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              widget.device.charge! > 0.2
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withAlpha(120)
                                  : Colors.red),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ImageNetworkWithLoadWidget(
                      widget.device.imageUrl != null
                          ? widget.device.imageUrl!
                          : ImagesConstants.imageNotFound,
                      height: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ],
                )),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    widget.device.name.isEmpty
                        ? localization
                            .translate(KeyWordsConstants.cardDeviceWidgetNoName)
                        : widget.device.name,
                    overflow: TextOverflow.ellipsis,
                  )),
                  StreamBuilder(
                      stream: widget.device.deviceBluetooth?.connectionState,
                      builder: (context, snapshot) => Switch(
                            value: snapshot.data ==
                                BluetoothConnectionState.connected,
                            onChanged: turnDeviceOnOff,
                          )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
