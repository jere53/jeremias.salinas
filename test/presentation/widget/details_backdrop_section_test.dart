import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/details_backdrop_section.dart';

import '../../test_cache_manager.dart';

void main() {
  testWidgets('details backdrop renders image', (widgetTester) async {
    await widgetTester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: DetailsBackdropSection(
          pathToBackdropImg: 'placeholder',
          genres: const [],
          decoration: const BoxDecoration(),
          cacheManager: TestCacheManager(),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });
}
