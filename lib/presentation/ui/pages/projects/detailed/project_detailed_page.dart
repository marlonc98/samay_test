import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/presentation/ui/pages/projects/detailed/project_detailed_widget_view_model.dart';

class ProjectDetailedPage extends StatelessWidget {
  static const String route = '/projects/detailed';
  final String id;
  const ProjectDetailedPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectDetailedPageViewModel>(
        create: (_) =>
            ProjectDetailedPageViewModel(context: context, widget: this),
        child: Consumer<ProjectDetailedPageViewModel>(
            builder: (context, viewModel, child) =>
                const Scaffold(body: Placeholder())));
  }
}
