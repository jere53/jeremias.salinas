import 'package:flutter/material.dart';
import '../../../utils/ui_constants.dart';

class MovieTitleText extends StatelessWidget {
  const MovieTitleText({
    super.key,
    required this.movieTitle,
  });

  final String movieTitle;
  final double height = 70;
  final double fontSize = 30;
  final int maxLines = 2;

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
        style: TextStyle(
          color: UIConstants.titleSectionTextColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
