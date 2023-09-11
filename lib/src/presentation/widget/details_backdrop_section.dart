import 'package:flutter/material.dart';

import 'genre_list.dart';

class DetailsBackdropSection extends StatelessWidget {
  const DetailsBackdropSection({
    super.key,
    required this.pathToBackdropImg,
    required this.genres,
    required this.decoration,
  });

  final BoxDecoration decoration;
  final String pathToBackdropImg;
  final List<String> genres;

  static const String pathToPlaceholder = "images/placeholder.png";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: decoration,
          child: Image.asset(
            pathToBackdropImg,
            fit: BoxFit.cover,
            errorBuilder: (
              BuildContext context,
              Object exception,
              StackTrace? stackTrace,
            ) {
              return Image.asset(
                pathToPlaceholder,
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
