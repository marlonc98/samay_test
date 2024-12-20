import 'package:flutter/material.dart';
import 'package:samay/domain/entities/project_entity.dart';

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
    return const SizedBox(
      height: 100,
      child: Placeholder(),
    );
  }
}
