import 'package:flutter/material.dart';
import '../../../utils/ui_constants.dart';

class ReleaseDateText extends StatelessWidget {
  static const String releaseDateText = 'Released: ';
  static const int releaseDateMaxLines = 1;
  static const double releaseDateFontSize = 10;
  const ReleaseDateText({
    super.key,
    required this.releaseDate,
  });

  final String releaseDate;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: releaseDateMaxLines,
      overflow: TextOverflow.ellipsis,
      '$releaseDateText $releaseDate',
      style: const TextStyle(
        color: UIConstants.titleSectionTextColor,
        fontSize: releaseDateFontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
