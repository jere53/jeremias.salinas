import 'package:flutter/material.dart';
import '../../../widgets/like_counter.dart';
import '../../../utils/ui_constants.dart';
import '../../../widgets/movie_poster.dart';
import '../../../widgets/movie_score.dart';

class DetailsPosterSection extends StatelessWidget {
  const DetailsPosterSection({
    super.key,
    required this.pathToPosterImg,
    required this.movieScore,
  });

  final String pathToPosterImg;
  final String movieScore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: UIConstants.posterSectionSize,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MoviePoster(
            pathToPosterImg: pathToPosterImg,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MovieScore(
                movieScore: movieScore,
              ),
              const LikeCounter(),
            ],
          ),
        ],
      ),
    );
  }
}
