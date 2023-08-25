import 'package:flutter/material.dart';

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
  static const String pathToPlaceholder = "images/placeholder.png";

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
        child: Image.asset(
          pathToPosterImg,
          height: height,
          width: width,
          fit: BoxFit.cover,
          errorBuilder: (
            BuildContext context,
            Object exception,
            StackTrace? stackTrace,
          ) {
            return Image.asset(
              pathToPlaceholder,
              width: width,
              height: height,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
