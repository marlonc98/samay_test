import 'package:flutter/material.dart';
import 'package:samay/presentation/ui/widgets/not_read_image_widget.dart';

class ImageNetworkWithLoad extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;

  const ImageNetworkWithLoad({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const NotReadImageWidget();
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
            height: height, child: const CircularProgressIndicator());
      },
    );
  }
}
