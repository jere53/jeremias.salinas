import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/core/parameter/movie_parameter.dart';
import 'package:movie_app_jsalinas/src/core/util/data_state.dart';
import 'package:movie_app_jsalinas/src/core/util/enums.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/domain/repository/i_movie_repository.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/movies_from_endpoint_usecase.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

void main() {
  setUp(() => registerFallbackValue(MovieEndpoint.popular));

  group('fetchMoviesFromEndpoint', () {
    test('returns a list of Movies if the API call completes successfully',
        () async {
      final repository = MockMovieRepository();

      when(() => repository.getMovies(any(), any()))
          .thenAnswer((_) async => DataSuccess([Movie.fromStatic()]));

      final params = MovieApiParams(page: 1);
      expect(
        await PopularUseCase(repository: repository).call(params),
        isA<DataSuccess>(),
      );
      expect(
        await UpcomingUseCase(repository: repository).call(params),
        isA<DataSuccess>(),
      );
      expect(
        await NowPlayingUseCase(repository: repository).call(params),
        isA<DataSuccess>(),
      );
      expect(
        await TopRatedUseCase(repository: repository).call(params),
        isA<DataSuccess>(),
      );
    });

    test('if API call throws, then usecase returns a DataFailed state',
        () async {
      final repository = MockMovieRepository();

      when(() => repository.getMovies(any(), any<MovieEndpoint>()))
          .thenAnswer((_) async => DataFailed(Exception('api call failed')));

      final params = MovieApiParams(page: 1);
      expect(
        await PopularUseCase(repository: repository).call(params),
        isA<DataFailed>(),
      );
      expect(
        await UpcomingUseCase(repository: repository).call(params),
        isA<DataFailed>(),
      );
      expect(
        await NowPlayingUseCase(repository: repository).call(params),
        isA<DataFailed>(),
      );
      expect(
        await TopRatedUseCase(repository: repository).call(params),
        isA<DataFailed>(),
      );
    });
  });
}
