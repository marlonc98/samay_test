import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samay/presentation/ui/widgets/not_read_image_widget.dart';

class ImageNetworkWithLoadWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;

  const ImageNetworkWithLoadWidget(
    this.imageUrl, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  _isWeb() {
    return imageUrl.startsWith('http') || imageUrl.startsWith('https');
  }

  _isFile() {
    return imageUrl.startsWith('/data/user/0/');
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: _isWeb()
          ? NetworkImage(imageUrl)
          : (_isFile() ? FileImage(File(imageUrl)) : AssetImage(imageUrl)),
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return NotReadImageWidget(
          height: height,
          width: width,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
            height: height,
            width: width,
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
}
