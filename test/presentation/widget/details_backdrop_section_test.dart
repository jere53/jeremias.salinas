import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/details_backdrop_section.dart';
import 'package:provider/provider.dart';

import '../../test_cache_manager.dart';

void main() {
  testWidgets('details backdrop renders image', (widgetTester) async {
    await widgetTester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Provider<CacheManager>(
          create: (context) => TestCacheManager(),
          builder: (context, child) => const DetailsBackdropSection(
            pathToBackdropImg: 'placeholder',
            genres: [],
            decoration: BoxDecoration(),
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });
}
