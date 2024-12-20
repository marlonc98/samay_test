import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/states/agency_state.dart';

class RouteBottomNavigation {
  String route;
  IconData icon;

  RouteBottomNavigation({
    required this.route,
    required this.icon,
  });
}

class CustomBotttomNavigationWidget extends StatelessWidget {
  final String? currentRoute;
  const CustomBotttomNavigationWidget({
    required super.key,
    this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final AgencyState agencyState = Provider.of<AgencyState>(context);
    return BottomNavigationBar(items: [
      const BottomNavigationBarItem(icon: Icon(Icons.house)),
      if (agencyState.selectedAgency != null)
        const BottomNavigationBarItem(icon: Icon(Icons.add)),
      const BottomNavigationBarItem(icon: Icon(Icons.bluetooth))
    ]);
  }
}
