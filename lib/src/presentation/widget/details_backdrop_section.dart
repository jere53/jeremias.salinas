import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../src/core/util/constants.dart' as constants;
import 'genre_list.dart';

class DetailsBackdropSection extends StatelessWidget {
  const DetailsBackdropSection({
    super.key,
    required this.pathToBackdropImg,
    required this.genres,
    required this.decoration,
    this.cacheManager,
  });

  final BaseCacheManager? cacheManager;
  final BoxDecoration decoration;
  final String pathToBackdropImg;
  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: decoration,
          child: CachedNetworkImage(
            cacheManager: cacheManager ?? DefaultCacheManager(),
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
            imageUrl: '${constants.baseImgUrl}$pathToBackdropImg',
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
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        GenreList(
          genres: genres,
        ),
      ],
    );
  }
}
