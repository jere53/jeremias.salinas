import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    super.key,
    required this.pathToPosterImg,
  });

  final String pathToPosterImg;
  static const double width = 200;
  static const double height = 300;
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
          image: DecorationImage(
            image: AssetImage(
              pathToPosterImg,
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
