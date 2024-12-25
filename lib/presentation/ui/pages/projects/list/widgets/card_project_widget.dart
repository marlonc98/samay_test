import 'package:flutter/material.dart';
import 'package:samay/domain/entities/project_entity.dart';
import 'package:samay/presentation/ui/widgets/image_network_with_load_widget.dart';

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
    return InkWell(
      onTap: () => onTap?.call(),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)), // Adjust the radius
              child: ImageNetworkWithLoadWidget(project.imageUrl),
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
                    Text(
                      project.location,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
