import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/use_cases/domotic/toggle_on_device_use_case.dart';
import 'package:samay/presentation/ui/widgets/image_network_with_load_widget.dart';
import 'package:samay/utils/images_constants.dart';

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
  void turnDeviceOnOff(bool value) async {
    setState(() {
      widget.device.on = value;
    });
    Either<ExceptionEntity, void> result =
        await GetIt.I.get<ToggleOnDeviceUseCase>().call(widget.device, value);
    if (result.isLeft && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result.left.message),
      ));
    }
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
                    widget.device.name,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Switch(
                    value: widget.device.connected ?? false,
                    onChanged: turnDeviceOnOff,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
