import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/presentation/routes/route_generator.dart';
import 'package:samay/presentation/ui/pages/projects/create/project_create_page.dart';
import 'package:samay/presentation/ui/pages/projects/list/projects_page.dart';

class RouteBottomNavigation {
  String route;
  IconData icon;
  String label;
  bool display;

  RouteBottomNavigation({
    required this.route,
    required this.icon,
    required this.label,
    this.display = true,
  });
}

class CustomBotttomNavigationWidget extends StatelessWidget {
  final String? currentRoute;
  const CustomBotttomNavigationWidget({
    required super.key,
    this.currentRoute,
  });

  List<RouteBottomNavigation> getRoutes(AgencyEntity? agency) {
    List<RouteBottomNavigation> availableRoutes = [
      RouteBottomNavigation(
        route: ProjectsPage.route,
        icon: Icons.house,
        label: "Projects",
      ),
      RouteBottomNavigation(
        route: ProjectCreatePage.route,
        icon: Icons.add,
        label: "Add projects",
        display: agency != null,
      ),
      RouteBottomNavigation(
        route: ProjectCreatePage.route, //Add domotic
        icon: Icons.bluetooth,
        label: "Domotic",
      ),
    ];

    return availableRoutes.where((element) => element.display).toList();
  }

  @override
  Widget build(BuildContext context) {
    final AgencyState agencyState = Provider.of<AgencyState>(context);
    return BottomNavigationBar(
      currentIndex: getRoutes(agencyState.selectedAgency)
          .indexWhere((element) => element.route == currentRoute),
      onTap: (index) {
        Navigator.of(context)
            .pushNamed(getRoutes(agencyState.selectedAgency)[index].route);
      },
      items: getRoutes(agencyState.selectedAgency)
          .map((e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.label,
              ))
          .toList(),
    );
  }
}
