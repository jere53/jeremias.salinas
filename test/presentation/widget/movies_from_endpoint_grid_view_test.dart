import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/presentation/bloc/movie_from_endpoint_bloc.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movies_from_endpoint_grid_view.dart';

class MockMovieFromEndpointBloc extends Mock
    implements MoviesFromEndpointBloc {}

void main() {
  final bloc = MockMovieFromEndpointBloc();

  testWidgets('movie view renders a gridview when passed a list of movies',
      (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MoviesFromEndpointGridView(
          movies: List.generate(
            50,
            (index) => Movie.fromStatic(),
          ),
          movieBloc: bloc,
        ),
      ),
    );

    final grid = find.byType(GridView);

    expect(grid, findsOneWidget);
  });

  testWidgets('movie view renders a grid view when passed an empty list',
      (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MoviesFromEndpointGridView(
          movies: const [],
          movieBloc: bloc,
        ),
      ),
    );

    final grid = find.byType(GridView);

    expect(grid, findsOneWidget);
  });

  testWidgets('scrolling at the end of the list calls getMovies',
      (tester) async {
    int numberOfCalls = 0;

    when(() => bloc.fetchMovies()).thenAnswer((invocation) => numberOfCalls++);
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: MoviesFromEndpointGridView(
            movieBloc: bloc,
            movies: List.generate(
              50,
              (index) => Movie.fromStatic(),
            ),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));

    final gridView = tester.widget<GridView>(
      find.byType(GridView),
    );
    final ctrl = gridView.controller!;

    ctrl.jumpTo(
      ctrl.position.maxScrollExtent,
    );

    await tester.pump();

    final gesture = await tester.startGesture(Offset.zero);
    await gesture.moveBy(
      const Offset(0, 100),
    );
    await gesture.up();

    await tester.pump(
      const Duration(seconds: 1),
    );

    expect(numberOfCalls, greaterThan(0));
  });
}
