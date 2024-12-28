import 'package:flutter/material.dart';
import 'package:samay/utils/images_constants.dart';

class NotReadImageWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? noImage;
  final BoxFit? fit;
  const NotReadImageWidget(
      {super.key, this.height, this.width, this.noImage, this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      noImage ?? ImagesConstants.imageNotFound,
      height: height ?? 250,
      fit: fit ?? BoxFit.cover,
      width: width ?? double.infinity,
    );
  }
}
