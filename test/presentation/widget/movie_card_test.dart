import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/core/util/enums.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/genre_card.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_card.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_poster.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_score.dart';

class MockedMovieCard extends MovieCard {
  const MockedMovieCard({required super.movie});

  @override
  List<String> getGenreNames() {
    return List.generate(movie.genres.length, (index) => 'g');
  }
}

void main() {
  testWidgets('Movie card renders all required widgets', (widgetTester) async {
    final movie = Movie.fromStatic();
    final movieCard = MovieCard(movie: movie);
    await widgetTester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: movieCard,
      ),
    );

    expect(find.byType(MovieScore), findsOneWidget);
    expect(find.byType(MoviePoster), findsOneWidget);
    expect(find.text(movieCard.releaseYear), findsOneWidget);
    expect(find.text(movie.title), findsOneWidget);
  });

  testWidgets(
      'Movie card renders all required widgets even when passed invalid data',
      (widgetTester) async {
    const movie = Movie(
      title: 'title',
      originalTitle: 'originalTitle',
      overview: 'overview',
      releaseDate: 'releaseDate',
      voteAverage: 0,
      genres: [],
      pathToBackdropImg: 'pathToBackdropImg',
      pathToPosterImg: 'pathToPosterImg',
      adult: false,
      originalLanguage: 'originalLanguage',
      id: 0,
      popularity: 0,
      video: false,
      voteCount: 0,
      page: 1,
      endpoint: MovieEndpoint.popular,
    );

    const movieCard = MovieCard(movie: movie);
    await widgetTester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: movieCard,
      ),
    );

    expect(find.byType(MovieScore), findsOneWidget);
    expect(find.byType(MoviePoster), findsOneWidget);
    expect(find.text(movieCard.releaseYear), findsOneWidget);
    expect(find.text(movie.title), findsOneWidget);
  });

  testWidgets('Movie card displays correct amount of GenreCards',
      (widgetTester) async {
    final movie = Movie.fromStatic();
    final movieCard = MockedMovieCard(movie: movie);
    await widgetTester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: movieCard,
      ),
    );

    expect(
      find.byType(GenreCard, skipOffstage: false),
      findsNWidgets(
        min(MovieCard.displayedGenresAmount, movie.genres.length),
      ),
    );
  });
}
