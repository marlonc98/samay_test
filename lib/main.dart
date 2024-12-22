import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/di/dependency_injection.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/domain/states/domotic_state.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:samay/presentation/routes/route_generator.dart';
import 'package:samay/presentation/ui/theme/light_theme.dart';
import 'package:provider/provider.dart';
import 'dart:async';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LocalizationState>(
          create: (_) => GetIt.instance.get<LocalizationState>()),
      ChangeNotifierProvider<AgencyState>(
          create: (_) => GetIt.instance.get<AgencyState>()),
      ChangeNotifierProvider<DomoticState>(
          create: (_) => GetIt.instance.get<DomoticState>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Name',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<AgencyState>(context).theme ?? lightTheme(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
