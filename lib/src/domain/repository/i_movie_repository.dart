import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../entity/genre.dart';
import '../entity/movie.dart';

abstract class IMovieRepository {
  Future<DataState<List<Movie>>> getMovies([
    int page = 1,
    MovieEndpoint endpoint,
  ]);

  Future<DataState<List<Movie>>> getMoviesByGenre(int genre, [int page = 1]);

  Future<DataState<List<Genre>>> getValidGenres();
}
