import 'package:flutter/material.dart';
import '../../../utils/ui_constants.dart';

class GenreList extends StatelessWidget {
  const GenreList({
    super.key,
    required this.genres,
  });

  static const double listPadding = 4;
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
        color: UIConstants.genreCardColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(UIConstants.genreCardBorderRadius)),
            border: Border.all(
              color: UIConstants.genreCardBorderColor,
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
}
