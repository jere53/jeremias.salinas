import 'package:flutter/material.dart';

import 'genre_card.dart';

class GenreList extends StatelessWidget {
  const GenreList({
    super.key,
    required this.genres,
  });

  static const double height = 70;
  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        children: [
          for (String item in genres) GenreCard(item: item),
        ],
      ),
    );
  }
}
