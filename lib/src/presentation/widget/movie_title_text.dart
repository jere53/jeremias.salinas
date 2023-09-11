import 'package:flutter/material.dart';

import '../../core/util/ui_constants.dart';

class MovieTitleText extends StatelessWidget {
  const MovieTitleText({
    super.key,
    required this.movieTitle,
  });

  final String movieTitle;
  static const double height = 70;
  static const double fontSize = 30;
  static const int maxLines = 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Text(
        textAlign: TextAlign.center,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        movieTitle,
        style: const TextStyle(
          color: UIConstants.titleSectionTextColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
