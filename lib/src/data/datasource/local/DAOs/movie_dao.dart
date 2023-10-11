import 'package:floor/floor.dart';

import '../../../../core/util/enums.dart';
import '../../../../domain/entity/movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie WHERE (endpoint = :endpoint) ORDER BY page')
  Future<List<Movie>> fetchMovies(
    MovieEndpoint endpoint,
  );

  @Query('SELECT * FROM Movie')
  Future<List<Movie>> fetchAllMovies(
      );

  @Query("SELECT * FROM Movie WHERE instr(genres, :genre) > 0 ORDER BY page")
  Future<List<Movie>> fetchMoviesByGenre(
      String genre,
      );

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(Movie movie);
}
