import 'package:floor/floor.dart';

import '../../../../domain/entity/genre.dart';

@dao
abstract class GenreDao {
  @Query('SELECT * FROM Genre')
  Future<List<Genre>> fetchGenres();
}
