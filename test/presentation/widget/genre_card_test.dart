import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/genre_card.dart';

void main() {
  testWidgets('genre card displays proper text', (widgetTester) async {
    await widgetTester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: GenreCard(item: 'MyText'),
      ),
    );

    expect(find.text('MyText'), findsOneWidget);
  });
}
