import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../src/core/util/constants.dart' as constants;
import 'package:provider/provider.dart';
class MoviePoster extends StatelessWidget {
  const MoviePoster({
    super.key,
    required this.pathToPosterImg,
    required this.width,
    required this.height,
  });

  final String pathToPosterImg;
  final double width;
  final double height;
  static const double borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: borderWidth,
          ),
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: CachedNetworkImage(
            cacheManager: context.read<CacheManager>(),
            progressIndicatorBuilder: (
              context,
              url,
              progress,
            ) {
              return Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              );
            },
            imageUrl: '${constants.baseImgUrl}$pathToPosterImg',
            imageBuilder: (
              context,
              imageProvider,
            ) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            errorWidget: (
              context,
              url,
              error,
            ) {
              return Image.asset(
                constants.pathToPlaceholderImg,
                width: width,
                height: height,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}
