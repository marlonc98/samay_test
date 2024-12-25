import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/domain/entities/bluetooth_device_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/use_cases/domotic/connect_device_use_case.dart';
import 'package:samay/presentation/ui/pages/domotic/detailed/detailed_device_page.dart';

class BluettoothItemWidget extends StatefulWidget {
  final BluetoothDevice device;
  const BluettoothItemWidget({
    super.key,
    required this.device,
  });

  @override
  State<BluettoothItemWidget> createState() => _BluettoothItemWidgetState();
}

class _BluettoothItemWidgetState extends State<BluettoothItemWidget> {
  bool connecting = false;

  void handleOnDeviceTap() async {
    if (connecting) {
      return;
    }
    setState(() {
      connecting = true;
    });
    Either<ExceptionEntity, BluetoothDeviceEntity> response =
        await GetIt.I.get<ConnectDeviceUseCase>().call(widget.device);
    if (response.isLeft) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.left.message),
      ));
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushNamed(DetailedDevicePage.route,
        arguments: DetailedDevicePage(device: response.right));
    setState(() {
      connecting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.device.platformName.isNotEmpty
                  ? widget.device.platformName
                  : widget.device.advName.isNotEmpty
                      ? widget.device.advName
                      : "Unknown device",
            ),
            Text(widget.device.isConnected ? "Connected" : ""),
          ],
        ),
        trailing: connecting ? const CircularProgressIndicator() : null,
        subtitle: Text(widget.device.remoteId.toString()),
        onTap: () => handleOnDeviceTap(),
      ),
    );
  }
}
