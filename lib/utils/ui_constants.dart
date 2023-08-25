import 'dart:ui' show Color;

abstract class UIConstants {
  ///Details page Background color
  static const Color detailsBackgroundColor = Color(0xFF263238);

  ///Details page Backdrop
  static const double backdropAspectRatio = 16 / 9;
  static const List<double> backdropGradientStops = [
    0,
    0.1,
  ];
  static const List<Color> backdropGradientColors = [
    Color(0x8A000000),
    Color(0x00000000),
  ];

  ///Details page Title section
  static const Color titleSectionTextColor = Color(0xFFFFFFFF);
  static const double titleTextAreaPadding = 8;

  ///Details page Poster section
  static const double posterSectionSize = 280;
  static const double posterSectionIconSize = 120;

  ///Details page Overview section
  static const Color overviewSectionTextColor = Color(0x99FFFFFF);
  static const Color overviewTitleBackgroundColor = Color(0xFF37474F);

  ///Genre Card styling
  static const Color genreCardColor = Color(0x73000000);
  static const double genreCardBorderRadius = 3;
  static const Color genreCardBorderColor = Color(0xFF000000);
  static const double genreCardBorderWidth = 2;
  static const Color genreCardTextColor = Color(0xB3FFFFFF);
}
