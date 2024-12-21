// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/domain/use_cases/default/load_use_case.dart';
import 'package:samay/presentation/ui/pages/projects/list/projects_page.dart';
import 'package:samay/presentation/ui/pages/view_model.dart';

class SplashPageViewModel extends ViewModel {
  SplashPageViewModel({required super.context, required super.widget}) {
    initApp();
  }

  void initApp() async {
    await GetIt.instance.get<LoadUseCase>().call();
    Navigator.of(context).pushReplacementNamed(ProjectsPage.route);
  }
}
