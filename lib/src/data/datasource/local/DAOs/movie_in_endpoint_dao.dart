import 'package:floor/floor.dart';
import '../../../../domain/entity/movie_in_endpoint.dart';

@dao
abstract class MovieInEndpointDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovieInEndpoint(MovieInEndpoint movieInEndpoint);
}
