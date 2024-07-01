import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  CustomNetworkImage({required this.imageUrl, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: DefaultCacheManager().getSingleFile(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Image.file(
              snapshot.data!,
              fit: fit,
            );
          } else if (snapshot.hasError) {
            return Icon(Icons.error);
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
