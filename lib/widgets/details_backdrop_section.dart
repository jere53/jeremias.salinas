import 'package:flutter/material.dart';
import '../../../widgets/genre_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: decoration,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(pathToBackdropImg),
              fit: BoxFit.cover,
            ),
          ),
        ),
        GenreList(
          genres: genres,
        ),
      ],
    );
  }
}
