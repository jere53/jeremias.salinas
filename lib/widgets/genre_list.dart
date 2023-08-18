import 'package:flutter/material.dart';

class GenreList extends StatelessWidget {
  const GenreList({
    super.key,
    required this.genres,
  });

  static const Color cardColor = Colors.black45;
  static const double cardBorderRadius = 3;
  static const Color cardBorderColor = Colors.black;
  static const double cardBorderWidth = 2;
  static const double listPadding = 4;
  static const Color cardTextColor = Colors.white70;
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
          for (String item in genres) buildListItem(item),
        ],
      ),
    );
  }

  Widget buildListItem(String item) {
    return FittedBox(
      child: Card(
        color: cardColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(cardBorderRadius)),
            border: Border.all(
              color: cardBorderColor,
              width: cardBorderWidth,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(listPadding),
            child: Text(
              item,
              style: const TextStyle(
                color: cardTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
