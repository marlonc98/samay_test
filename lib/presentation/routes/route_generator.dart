import 'package:flutter/material.dart';
import 'package:samay/presentation/ui/pages/domotic/connected/connected_devices_page.dart';
import 'package:samay/presentation/ui/pages/domotic/detailed/detailed_device_page.dart';
import 'package:samay/presentation/ui/pages/domotic/search/search_devices_page.dart';
import 'package:samay/presentation/ui/pages/projects/create/project_create_page.dart';
import 'package:samay/presentation/ui/pages/projects/detailed/project_detailed_page.dart';
import 'package:samay/presentation/ui/pages/projects/list/projects_page.dart';
import 'package:samay/presentation/ui/pages/splash/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case SplashPage.route:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case ProjectsPage.route:
        return MaterialPageRoute(builder: (_) => const ProjectsPage());
      case ProjectDetailedPage.route:
        return MaterialPageRoute(builder: (_) => args as ProjectDetailedPage);
      case ProjectCreatePage.route:
        var argsc = args as ProjectCreatePage?;
        return MaterialPageRoute(
            builder: (_) => argsc ?? const ProjectCreatePage());
      case ConnectedDevicesPage.route:
        return MaterialPageRoute(builder: (_) => const ConnectedDevicesPage());
      case DetailedDevicePage.route:
        return MaterialPageRoute(builder: (_) => args as DetailedDevicePage);
      case SearchDevicesPage.route:
        return MaterialPageRoute(builder: (_) => const SearchDevicesPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}
