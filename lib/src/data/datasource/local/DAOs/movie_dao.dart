import 'package:floor/floor.dart';

import '../../../../core/util/enums.dart';
import '../../../../domain/entity/movie.dart';

@dao
abstract class MovieDao {
  @Query(
    'SELECT * FROM Movie WHERE id IN (SELECT movie_id FROM MovieInEndpoint WHERE endpoint = :endpoint AND page = :page)',
  )
  Future<List<Movie>> fetchMovies(
    MovieEndpoint endpoint,
    int page,
  );

  @Query(
    "SELECT * FROM Movie WHERE instr(genres, :genre) > 0 AND id IN (SELECT movie_id FROM MovieInEndpoint WHERE endpoint = :endpoint AND page = :page)",
  )
  Future<List<Movie>> fetchMoviesByGenre(
    String genre,
    int page,
    MovieEndpoint endpoint,
  );

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(Movie movie);
}
