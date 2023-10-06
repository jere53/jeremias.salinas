import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/config/route/app_routes.dart';
import 'package:movie_app_jsalinas/src/core/util/data_state.dart';
import 'package:movie_app_jsalinas/src/data/model/genre_model.dart';
import 'package:movie_app_jsalinas/src/domain/entity/genre.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/domain/repository/i_movie_repository.dart';
import 'package:movie_app_jsalinas/src/presentation/view/movies_by_genres_view.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/genre_drawer.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

void main() {
  List<Genre>? genres;

  setUp(() async {
    const String genresJsonPath = 'mock_data/genres.json';

    final String genreData = await rootBundle.loadString(genresJsonPath);

    final Map<String, dynamic> decodedGenreData = jsonDecode(genreData);

    final List<Map<String, dynamic>> genreList =
        List.from(decodedGenreData['genres']);

    genres = GenreModel.fromJson(
      genreList,
    ).toList();
  });

  testWidgets('drawer displays an inkwell for each valid genre',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: GenreDrawer(
            futureValidGenreList: Future(
              () => DataSuccess(genres!),
            ),
          ),
        ),
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    expect(
      find.byType(InkWell, skipOffstage: false),
      findsNWidgets(genres!.length),
    );
  });

  testWidgets('tapping on an inkwell takes us to movie by genre view',
      (widgetTester) async {
    final repository = MockMovieRepository();

    when(() => repository.getValidGenres()).thenAnswer(
      (invocation) async => DataSuccess(genres!),
    );

    when(() => repository.getMoviesByGenre(any())).thenAnswer(
      (realInvocation) async => DataSuccess(
        List.generate(
          50,
          (index) => Movie.fromStatic(),
        ),
      ),
    );

    await widgetTester.pumpWidget(
      MaterialApp(
        routes: AppRoutes(repository).genreRoute,
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: GenreDrawer(
            futureValidGenreList: Future(
              () => DataSuccess(genres!),
            ),
          ),
        ),
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    final inkwellFinder = find.byType(InkWell).first;

    await widgetTester.tap(inkwellFinder);

    await widgetTester.pump();

    expect(find.byType(MoviesByGenreView, skipOffstage: false), findsOneWidget);
  });
}
