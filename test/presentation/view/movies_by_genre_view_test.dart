import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/core/util/data_state.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/domain/repository/i_movie_repository.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/movies_by_genre_usecase.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/valid_genres_usecase.dart';
import 'package:movie_app_jsalinas/src/presentation/bloc/movie_with_genre_bloc.dart';
import 'package:movie_app_jsalinas/src/presentation/view/details_view.dart';
import 'package:movie_app_jsalinas/src/presentation/view/movies_by_genres_view.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_card.dart';
import 'package:provider/provider.dart';

import '../../test_cache_manager.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

class MockGenresUseCase extends Mock implements ValidGenresUseCase {}

class MockMoviesByGenreUseCase extends Mock implements MoviesByGenreUsecase {}

void main() {
  testWidgets(
      'movies by genre view fetches movies from the repo and builds a list',
      (tester) async {
    final moviesByGenreUseCase = MockMoviesByGenreUseCase();
    final genresUseCase = MockGenresUseCase();
    when(() => genresUseCase.call()).thenAnswer(
      (invocation) async => const DataSuccess([]),
    );

    when(
      () => moviesByGenreUseCase.call(any()),
    ).thenAnswer(
      (_) async => DataSuccess(
        List.generate(
          20,
          (index) => Movie.fromStatic(),
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: MultiProvider(
            providers: [
              Provider<MovieWithGenreBloc>(
                create: (context) => MovieWithGenreBloc(
                  moviesByGenreUsecase: moviesByGenreUseCase,
                  validGenresUseCase: genresUseCase,
                ),
              ),
              Provider<CacheManager>(create: (context) => TestCacheManager())
            ],
            builder: (context, child) => const MoviesByGenreView(),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(Scrollable), findsOneWidget);
    expect(find.byType(MovieCard), findsAtLeastNWidgets(1));
  });

  testWidgets('tapping on list elements takes us to details view',
      (tester) async {
    final moviesByGenreUseCase = MockMoviesByGenreUseCase();
    final genresUseCase = MockGenresUseCase();
    when(() => genresUseCase.call()).thenAnswer(
      (invocation) async => const DataSuccess([]),
    );

    when(
      () => moviesByGenreUseCase.call(any()),
    ).thenAnswer(
      (_) async => DataSuccess(
        List.generate(
          20,
          (index) => Movie.fromStatic(),
        ),
      ),
    );

    await tester.pumpWidget(
      Provider<CacheManager>(
        create: (context) => TestCacheManager(),
        child: MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: MultiProvider(
              providers: [
                Provider<MovieWithGenreBloc>(
                  create: (context) => MovieWithGenreBloc(
                    moviesByGenreUsecase: moviesByGenreUseCase,
                    validGenresUseCase: genresUseCase,
                  ),
                ),
              ],
              builder: (context, child) => const MoviesByGenreView(),
            ),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(Scrollable), findsOneWidget);
    expect(find.byType(InkWell), findsAtLeastNWidgets(1));

    await tester.tap(find.byType(InkWell).first);

    await tester.pump();
    expect(find.byType(DetailsView, skipOffstage: false), findsOneWidget);
  });
}
