import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/core/util/data_state.dart';
import 'package:movie_app_jsalinas/src/core/util/enums.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/movies_from_endpoint_usecase.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/valid_genres_usecase.dart';
import 'package:movie_app_jsalinas/src/presentation/view/details_view.dart';
import 'package:movie_app_jsalinas/src/presentation/view/movies_view.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_card.dart';

class MockMoviesUseCase extends Mock implements PopularUseCase {}

class MockGenresUseCase extends Mock implements ValidGenresUseCase {}

void main() {
  setUpAll(() => registerFallbackValue(MovieEndpoint.popular));
  testWidgets('movies view fetches movies from the repo and builds a grid',
      (tester) async {
    final moviesUseCase = MockMoviesUseCase();
    final genresUseCase = MockGenresUseCase();
    when(() => genresUseCase.call()).thenAnswer(
      (invocation) async => const DataSuccess([]),
    );

    when(
      () => moviesUseCase.call(any<int>()),
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
          child: MoviesView(
            moviesUseCase: moviesUseCase,
            validGenresUseCase: genresUseCase,
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(MovieCard), findsAtLeastNWidgets(1));
  });

  testWidgets('tapping on grid elements takes us to details view',
      (tester) async {
    final moviesUseCase = MockMoviesUseCase();
    final genresUseCase = MockGenresUseCase();
    when(() => genresUseCase.call()).thenAnswer(
      (invocation) async => const DataSuccess([]),
    );

    when(
      () => moviesUseCase.call(any<int>()),
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
          child: MoviesView(
            moviesUseCase: moviesUseCase,
            validGenresUseCase: genresUseCase,
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(InkWell), findsAtLeastNWidgets(1));

    await tester.tap(find.byType(InkWell).first);

    await tester.pump();
    expect(find.byType(DetailsView, skipOffstage: false), findsOneWidget);
  });
}
