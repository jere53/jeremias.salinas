import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_overview_text.dart';

void main() {
  testWidgets('expected text is rendered', (widgetTester) async {
    const overviewText = 'This is a sample text';

    await widgetTester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: MovieOverviewText(
          movieOverviewTxt: overviewText,
        ),
      ),
    );

    expect(find.text(MovieOverviewText.overviewSectionTitle), findsOneWidget);
    expect(find.text(overviewText), findsOneWidget);
  });
}
