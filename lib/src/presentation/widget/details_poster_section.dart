import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'like_counter.dart';
import 'movie_poster.dart';
import 'movie_score.dart';

class DetailsPosterSection extends StatelessWidget {
  const DetailsPosterSection({
    super.key,
    required this.pathToPosterImg,
    required this.movieScore,
    required this.voteCount,
    this.cacheManager,
  });

  final BaseCacheManager? cacheManager;
  final String pathToPosterImg;
  final String movieScore;
  final int voteCount;

  static const double posterHeight = 300;
  static const double posterWidth = 200;
  static const double sectionSize = 280;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: sectionSize,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MoviePoster(
            cacheManager: cacheManager,
            pathToPosterImg: pathToPosterImg,
            height: posterHeight,
            width: posterWidth,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MovieScore(
                movieScore: movieScore,
                voteCount: voteCount,
              ),
              const LikeCounter(),
            ],
          ),
        ],
      ),
    );
  }
}
