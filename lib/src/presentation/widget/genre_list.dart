import 'package:flutter/material.dart';

import '../../core/util/ui_constants.dart';

class GenreList extends StatelessWidget {
  const GenreList({
    super.key,
    required this.genres,
  });

  static const double listPadding = 4;
  static const double height = 70;
  static const Color genreCardColor = Colors.black45;

  final List<String> genres;

  Widget buildListItem(String item) {
    return FittedBox(
      child: Card(
        color: genreCardColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(UIConstants.genreCardBorderRadius),
            ),
            border: Border.all(
              width: UIConstants.genreCardBorderWidth,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(listPadding),
            child: Text(
              item,
              style: const TextStyle(
                color: UIConstants.genreCardTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

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
}
