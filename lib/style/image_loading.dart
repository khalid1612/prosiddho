import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageLoading {
  static Widget cachedNetworkImage(
    String url, {
    double radius = 0,
    BoxFit boxfit,
    ColorFilter colorFilter,
  }) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: imageProvider,
              fit: boxfit ?? BoxFit.fill,
              colorFilter: colorFilter,
              // colorFilter:  ColorFilter.mode(Colors.red, BlendMode.colorBurn),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
