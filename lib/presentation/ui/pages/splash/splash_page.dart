import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samay/presentation/ui/pages/splash/splash_page_view_model.dart';
import 'package:samay/utils/images_constants.dart';
import 'package:samay/utils/key_words_constants.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  static const String route = '/splash';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashPageViewModel>(
      create: (_) => SplashPageViewModel(context: context, widget: this),
      child: Consumer<SplashPageViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImagesConstants.logo,
                        height: 50,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
                ),
                Text(
                  viewModel.localization
                      .translate(KeyWordsConstants.splashPageVersion),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
