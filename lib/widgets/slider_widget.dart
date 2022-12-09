import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../resources/app_utils.dart';
import '../resources/urls.dart';
Widget buildBannerImage(String image, index) {
  return Container(
    width: double.infinity,
    // color: Colors.blueGrey,
    margin:const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: CachedNetworkImage(
      imageUrl: "$mediaUrl$image",
      errorWidget: (context, url, error) =>const Icon(Icons.image),
          //Image.asset(noImage),
      progressIndicatorBuilder: (ctx, url, progress) => Center(
        child: appLoading(value: progress.progress),
      ),
      fit: BoxFit.fill,
    ),
  );
}