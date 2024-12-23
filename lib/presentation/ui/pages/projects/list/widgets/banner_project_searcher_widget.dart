import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';
import 'package:samay/presentation/ui/pages/projects/list/widgets/dropdown_agencies_widget.dart';
import 'package:samay/presentation/ui/pages/projects/list/widgets/filter_project_widget.dart';
import 'package:samay/utils/images_constants.dart';

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
    const limit = 350.0;
    return MediaQuery.of(context).size.height > limit
        ? limit
        : MediaQuery.of(context).size.height;
  }

  void _handleOnChangeAgency(AgencyEntity? agency) {
    filter.agencyId = agency?.id;
    widget.onChangeFilter.call(filter);
  }

  void _handleOnChangeFilter(ProjectFilterEntity filter) {
    this.filter.maxPrice = filter.maxPrice;
    this.filter.minPrice = filter.minPrice;
    this.filter.location = filter.location;
    widget.onChangeFilter.call(this.filter);
  }

  void _handleOpenFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FilterProjectWidget(
        onFilter: _handleOnChangeFilter,
        filter: filter,
      ),
    );
  }

  @override
  SliverAppBar build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: _calculateLimitExpanded(context),
      collapsedHeight: 100,
      pinned: true,
      backgroundColor: Theme.of(context).primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              ImagesConstants.bgProjectsPage,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  DropdownAgenciesWidget(
                    onChange: _handleOnChangeAgency,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SvgPicture.asset(
                    ImagesConstants.logoWhite,
                    height: 50,
                  ),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const Text(
                    'Find your dreams',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )
          ],
        ),
        centerTitle: true,
        title: Container(
          height: 40,
          margin: const EdgeInsets.only(right: 8, left: 8, bottom: 10),
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
                  controller: _textController,
                  onChanged: _onKeyDownSearch,
                  decoration: InputDecoration(
                      isDense: true,
                      prefixIconConstraints: const BoxConstraints(maxWidth: 30),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      hintText: 'Search',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 8, right: 4),
                        child: Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero,
                  iconSize: 20,
                  onPressed: _handleOpenFilter,
                  icon: Icon(
                    Icons.filter_list,
                    color: Theme.of(context).primaryColor,
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 5)),
                  onPressed: () {},
                  child: const Text(
                    "Search",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
