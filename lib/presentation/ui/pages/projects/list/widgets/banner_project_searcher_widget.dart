import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
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

  double _calculateLimitExpanded(BuildContext context) {
    const limit = 300.0;
    return MediaQuery.of(context).size.height > limit
        ? limit
        : MediaQuery.of(context).size.height;
  }

  @override
  SliverAppBar build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: _calculateLimitExpanded(context),
      collapsedHeight: 100,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/bg_projects_page.jpg',
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Placeholder(
                    fallbackHeight: 30,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/logo/applogo.png',
                    height: 100,
                  ),
                  const Text('Welcome'),
                  const Text('find your dreams'),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            )
          ],
        ),
        centerTitle: true,
        title: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.only(top: 6, bottom: 6, right: 6),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      prefixIconConstraints: const BoxConstraints(maxWidth: 30),
                      hintStyle: TextStyle(color: Colors.amber),
                      hintText: 'Search',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 4),
                        child: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                      border: InputBorder.none),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero,
                  iconSize: 20,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.filter_list,
                  )),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 5)),
                  onPressed: () {},
                  child: const Text(
                    "search",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
