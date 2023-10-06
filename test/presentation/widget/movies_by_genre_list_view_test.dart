import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/domain/entity/genre.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/presentation/bloc/movie_with_genre_bloc.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movies_by_genre_list_view.dart';

class MockMovieWithGenreBloc extends Mock implements MovieWithGenreBloc {}

void main() {
  final bloc = MockMovieWithGenreBloc();

  testWidgets(
      'movie genre view renders a listview when passed a list of movies',
      (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MoviesByGenreListView(
          movies: List.generate(50, (index) => Movie.fromStatic()),
          genre: const Genre(12, 'Action'),
          movieWithGenreBloc: bloc,
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
        child: MoviesByGenreListView(
          movies: const [],
          genre: const Genre(12, 'Action'),
          movieWithGenreBloc: bloc,
        ),
      ),
    );
    final listWidget = find.byType(ListView);

    expect(listWidget, findsOneWidget);
  });
}
