import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';

class BannerProjectSearcherWidget extends StatefulWidget {
  final Function(ProjectFilterEntity filter) onChangeFilter;
  const BannerProjectSearcherWidget({super.key, required this.onChangeFilter});

  @override
  State<BannerProjectSearcherWidget> createState() =>
      _SearchProjectWidgetState();
}

class _SearchProjectWidgetState extends State<BannerProjectSearcherWidget> {
  ProjectFilterEntity filter = ProjectFilterEntity(
      maxPrice: null, minPrice: null, querySearch: null, agencyId: null);
  final TextEditingController _textController = TextEditingController();

  void _onKeyDownSearch(String? val) {
    filter.querySearch = val;
    if (val == null) {
      return;
    }
    Timer(const Duration(milliseconds: 500), () async {
      await widget.onChangeFilter.call(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
