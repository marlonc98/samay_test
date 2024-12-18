import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samay/domain/states/Localization/localization_state.dart';
import 'package:samay/domain/use_cases/default/load_use_case.dart';
import 'package:lottie/lottie.dart';
import 'package:samay/utils/images_constants.dart';
import 'package:samay/utils/key_words_constants.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  static const String route = '/splash';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationState = Provider.of<LocalizationState>(context);
    return AnimatedSplashScreen(
      backgroundColor: Theme.of(context).colorScheme.primary,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            localizationState.translate(KeyWordsConstants.splashPageTitle),
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5 - 240,
          ),
          Lottie.asset(ImagesConstants.splashLoading, height: 200),
          const SizedBox(
            height: 4,
          ),
          Text(
            localizationState.translate(KeyWordsConstants.splashPageVersion),
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
      function: GetIt.instance.get<LoadUseCase>().call,
      nextScreen: const Placeholder(),
    );
  }
}
