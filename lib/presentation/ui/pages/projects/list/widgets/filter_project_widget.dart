import 'package:flutter/material.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';

class FilterProjectWidget extends StatefulWidget {
  final Function(ProjectFilterEntity filter) onFiler;

  const FilterProjectWidget({
    super.key,
    required this.onFiler,
  });

  @override
  State<StatefulWidget> createState() => _FilterProjectWidget();
}

class _FilterProjectWidget extends State<FilterProjectWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
