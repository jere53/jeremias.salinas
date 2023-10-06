import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/genre_card.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/genre_list.dart';

void main() {
  testWidgets('genre list displays a list of GenreCards with proper text',
      (widgetTester) async {
    final genres = [
      'A',
      'B',
      'C',
    ];

    await widgetTester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: GenreList(
          genres: genres,
        ),
      ),
    );

    await widgetTester.pump();

    for (final genre in genres) {
      final card = find.byWidgetPredicate(
        (widget) => widget is GenreCard && widget.item == genre,
        skipOffstage: false,
      );

      await widgetTester.scrollUntilVisible(
        card,
        10,
        scrollable: find.byType(Scrollable),
      );

      await widgetTester.pump();

      expect(
        card,
        findsOneWidget,
      );
    }
  });

  testWidgets('empty genre list displays an empty list', (widgetTester) async {
    final genres = <String>[];

    await widgetTester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: GenreList(
          genres: genres,
        ),
      ),
    );

    await widgetTester.pump(); // flush the widget tree

    expect(find.byType(ListView), findsOneWidget);

    expect(find.byType(GenreCard), findsNothing);
  });
}
