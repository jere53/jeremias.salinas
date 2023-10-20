import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/domain/entity/genre.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/presentation/bloc/movie_with_genre_bloc.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movies_by_genre_list_view.dart';
import 'package:provider/provider.dart';

import '../../test_cache_manager.dart';

class MockMovieWithGenreBloc extends Mock implements MovieWithGenreBloc {}

void main() {
  final bloc = MockMovieWithGenreBloc();

  testWidgets(
      'movie genre view renders a listview when passed a list of movies',
      (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MultiProvider(
          providers: [
            Provider<MovieWithGenreBloc>(
              create: (context) => bloc,
            ),
            Provider<CacheManager>(create: (context) => TestCacheManager())
          ],
          builder: (context, child) => MoviesByGenreListView(
            movies: List.generate(50, (index) => Movie.fromStatic()),
            genre: const Genre(12, 'Action'),
          ),
        ),
      ),
    );

    final listWidget = find.byType(ListView);

    expect(listWidget, findsOneWidget);
  });

  testWidgets('movie genre view renders a listview when passed an empty list',
      (tester) async {
    final bloc = MockMovieWithGenreBloc();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MultiProvider(
          providers: [
            Provider<MovieWithGenreBloc>(
              create: (context) => bloc,
            ),
            Provider<CacheManager>(create: (context) => TestCacheManager())
          ],
          builder: (context, child) => MoviesByGenreListView(
            movies: List.generate(50, (index) => Movie.fromStatic()),
            genre: const Genre(12, 'Action'),
          ),
        ),
      ),
    );
    final listWidget = find.byType(ListView);

    expect(listWidget, findsOneWidget);
  });
}
