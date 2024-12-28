import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:samay/presentation/ui/pages/projects/list/projects_page.dart';
import 'package:samay/utils/key_words_constants.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<LocalizationState>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(localization
                .translate(KeyWordsConstants.notFoundWidgetNotResults)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            TextButton(
                onPressed: () =>
                    Navigator.of(context).popAndPushNamed(ProjectsPage.route),
                child: Text(
                  localization
                      .translate(KeyWordsConstants.notFoundWidgetGoBack),
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge?.color),
                )),
            SizedBox(
                height: (MediaQuery.of(context).size.height * 0.4 - 300) > 0
                    ? (MediaQuery.of(context).size.height * 0.4 - 300)
                    : 0),
          ],
        ),
      ),
    );
  }
}
