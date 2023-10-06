import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_title_text.dart';

void main() {
  testWidgets('widgets are rendered correctly', (widgetTester) async {
    const movieTitleText = MovieTitleText(movieTitle: 'Title!');
    await widgetTester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: movieTitleText,
      ),
    );

    expect(find.text(movieTitleText.movieTitle), findsOneWidget);
  });
}
