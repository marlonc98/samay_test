import 'package:flutter/material.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/presentation/ui/widgets/image_with_network_load.dart';

class CardProjectWidget extends StatelessWidget {
  final ProjectEntity project;
  final Function? onTap;

  const CardProjectWidget({
    super.key,
    required this.project,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5)), // Adjust the radius
            child: ImageNetworkWithLoad(imageUrl: project.imageUrl),
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(project.location,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              )),
        ],
      ),
    );
  }
}
