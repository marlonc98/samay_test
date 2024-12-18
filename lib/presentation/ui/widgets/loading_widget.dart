import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:samay/utils/images_constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 8),
          Lottie.asset(ImagesConstants.splashLoading, height: 200),
        ],
      ),
    );
  }
}
