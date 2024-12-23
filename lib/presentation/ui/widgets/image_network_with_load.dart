import 'package:flutter/material.dart';
import 'package:samay/presentation/ui/widgets/not_read_image_widget.dart';

class ImageNetworkWithLoad extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;

  const ImageNetworkWithLoad(
    this.imageUrl, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
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
