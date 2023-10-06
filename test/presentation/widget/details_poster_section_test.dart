import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/details_poster_section.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/like_counter.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_poster.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_score.dart';

import '../../test_cache_manager.dart';

void main() {
  testWidgets('poster section renders all required widgets',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: DetailsPosterSection(
            cacheManager: TestCacheManager(),
            pathToPosterImg: 'placeholder',
            movieScore: '0',
            voteCount: 0,
          ),
        ),
      ),
    );

    expect(find.byType(MoviePoster), findsOneWidget);
    expect(find.byType(MovieScore), findsOneWidget);
    expect(find.byType(LikeCounter), findsOneWidget);
  });
}
