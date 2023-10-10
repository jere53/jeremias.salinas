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

  @Query('SELECT * FROM Movie WHERE (page = :page AND genre = :genre)')
  Future<List<Movie>> fetchMoviesByGenre(
      int genre,
      int page,
      );
}
