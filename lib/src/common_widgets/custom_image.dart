import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Custom image widget that loads an image as a static asset.
class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: imageUrl.contains('https') ? CachedNetworkImage(imageUrl: imageUrl) : Image.asset(imageUrl),
    );
  }
}
