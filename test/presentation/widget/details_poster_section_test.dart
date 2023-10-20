import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/details_poster_section.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/like_counter.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_poster.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_score.dart';
import 'package:provider/provider.dart';

import '../../test_cache_manager.dart';

void main() {
  testWidgets('poster section renders all required widgets',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: Provider<CacheManager>(
            create: (context) => TestCacheManager(),
            builder: (context, child) => const DetailsPosterSection(
              pathToPosterImg: 'placeholder',
              movieScore: '0',
              voteCount: 0,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(MoviePoster), findsOneWidget);
    expect(find.byType(MovieScore), findsOneWidget);
    expect(find.byType(LikeCounter), findsOneWidget);
  });
}
