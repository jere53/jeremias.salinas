import 'package:flutter/material.dart';

import '../../core/util/ui_constants.dart';

class GenreCard extends StatelessWidget {
  final String item;
  static const double listPadding = 4;

  const GenreCard({
    super.key,
    required this.item,
  });

  static const Color genreCardColor = Colors.black45;

  @override
  Widget build(BuildContext context) {
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
}
