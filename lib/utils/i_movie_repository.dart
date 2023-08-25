import '../../../models/movie.dart';

abstract interface class IMovieRepository {
  Future<List<Movie>?> getMovies();
}
