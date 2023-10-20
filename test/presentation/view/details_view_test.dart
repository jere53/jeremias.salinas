import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/presentation/view/details_view.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/details_backdrop_section.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/details_poster_section.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/details_title_section.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_overview_text.dart';
import 'package:provider/provider.dart';

import '../../test_cache_manager.dart';

void main() {
  testWidgets('Details View renders all sections', (widgetTester) async {
    await widgetTester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Provider<CacheManager>(
          create: (context) => TestCacheManager(),
          builder: (context, child) => DetailsView(
            movie: Movie.fromStatic(),
          ),
        ),
      ),
    );

    expect(find.byType(ListView, skipOffstage: false), findsNWidgets(2));
    expect(
      find.byType(DetailsTitleSection, skipOffstage: false),
      findsOneWidget,
    );
    expect(
      find.byType(DetailsBackdropSection, skipOffstage: false),
      findsOneWidget,
    );
    expect(
      find.byType(DetailsPosterSection, skipOffstage: false),
      findsOneWidget,
    );
    expect(find.byType(MovieOverviewText, skipOffstage: false), findsOneWidget);
  });
}
