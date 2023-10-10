import 'package:floor/floor.dart';

import '../../../../core/util/enums.dart';
import '../../../../domain/entity/movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie WHERE (page = :page AND endpoint = :endpoint)')
  Future<List<Movie>> fetchMovies(
    int page,
    MovieEndpoint endpoint,
  );

  @Query('SELECT * FROM Movie')
  Future<List<Movie>> fetchAllMovies(
      );

  @Query("SELECT * FROM Movie WHERE :page > -2 AND instr(genres, :genre) > 0")
  //FIXME figure out how to implement paging
  Future<List<Movie>> fetchMoviesByGenre(
      String genre,
      int page,
      );

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(Movie movie);
}
