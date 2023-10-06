import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/details_title_section.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_title_text.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/release_date_text.dart';

void main() {
  testWidgets('title section renders all required widgets',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: DetailsTitleSection(
          movieTitle: 'movieTitle',
          movieReleaseDate: 'date',
          decoration: BoxDecoration(),
        ),
      ),
    );

    expect(find.byType(MovieTitleText), findsOneWidget);
    expect(find.byType(ReleaseDateText), findsOneWidget);
  });
}
