import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/release_date_text.dart';

void main() {
  testWidgets('widgets are rendered correctly', (widgetTester) async {
    const date = '2020-3-11';
    const releaseDateText = ReleaseDateText(
      releaseDate: date,
    );
    await widgetTester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: releaseDateText,
      ),
    );

    expect(
      find.text('${ReleaseDateText.releaseDateText} $date'),
      findsOneWidget,
    );
  });
}
