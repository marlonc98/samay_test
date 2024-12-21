import 'package:flutter/material.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';

class FilterProjectWidget extends StatefulWidget {
  final Function(ProjectFilterEntity filter) onFilter;
  final ProjectFilterEntity filter;

  const FilterProjectWidget({
    super.key,
    required this.filter,
    required this.onFilter,
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
