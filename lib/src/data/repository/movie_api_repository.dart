import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../data/model/genre_model.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_movie_repository.dart';
import '../datasource/remote/movie_api_service.dart';

class MovieApiRepository implements IMovieRepository {
  final MovieApiService movieApiProvider;

  MovieApiRepository(this.movieApiProvider);

  @override
  Future<DataState<List<Movie>>> getMovies([
    int page = 1,
    MovieEndpoint endpoint = MovieEndpoint.popular,
  ]) async {
    try {
      if (GenreModel.validGenres.isEmpty) {
        GenreModel.validGenres = (await getValidGenres()).data ?? [];
      }
      return DataSuccess(
        await movieApiProvider.fetchMovies(
          page,
          endpoint,
        ),
      );
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<Movie>>> getMoviesByGenre(
    int genre, [
    int page = 1,
  ]) async {
    try {
      return DataSuccess(
        await movieApiProvider.fetchMoviesByGenre(
          genre,
          page,
        ),
      );
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<Genre>>> getValidGenres() async {
    try {
      return DataSuccess(
        await movieApiProvider.fetchGenres(),
      );
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }
}
