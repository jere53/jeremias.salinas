import 'package:flutter/material.dart';
import '../../../utils/ui_constants.dart';

class MovieScore extends StatelessWidget {
  const MovieScore({
    super.key,
    required this.movieScore,
  });

  final String movieScore;
  static const double iconSize = UIConstants.posterSectionIconSize;
  static const TextStyle scoreTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 70,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: iconSize,
      width: iconSize,
      decoration: const BoxDecoration(
        color: Colors.amber,
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          textAlign: TextAlign.center,
          movieScore,
          style: scoreTextStyle,
        ),
      ),
    );
  }
}
