import 'package:flutter/material.dart';

import '../../core/util/ui_constants.dart';

class MovieScore extends StatelessWidget {
  const MovieScore({
    super.key,
    required this.movieScore,
    required this.voteCount,
  });

  final int voteCount;
  final String movieScore;
  static const double iconSize = UIConstants.posterSectionIconSize;
  static const int scoreFlex = 10;
  static const int voteCountFlex = 8;
  static const TextStyle scoreTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 70,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle voteCountTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 15,
  );

  static const maxVoteNumber = 99999;

  String _getFormattedVoteCount() {
    if (voteCount > maxVoteNumber) {
      return '$maxVoteNumber+ votes';
    }

    return '$voteCount votes';
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: scoreFlex,
              child: Text(
                textAlign: TextAlign.center,
                movieScore,
                style: scoreTextStyle,
              ),
            ),
            Flexible(
              flex: voteCountFlex,
              child: Text(
                textAlign: TextAlign.center,
                _getFormattedVoteCount(),
                style: voteCountTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
