import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/presentation/ui/pages/projects/create/project_create_page_view_model.dart';

class ProjectCreatePage extends StatelessWidget {
  static const String route = '/projects/create';
  final String? id;
  const ProjectCreatePage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectCreatePageViewModel>(
        create: (_) =>
            ProjectCreatePageViewModel(context: context, widget: this),
        child: Consumer<ProjectCreatePageViewModel>(
            builder: (context, viewModel, child) =>
                const Scaffold(body: Placeholder())));
  }
}
