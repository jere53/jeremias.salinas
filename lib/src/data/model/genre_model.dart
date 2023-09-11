import '../../domain/entity/genre.dart';

class GenreModel {
  static List<Genre> validGenres = [];

  static List<Genre> fromJson(Iterable<Map<String, dynamic>> list) {
    final result = <Genre>[];
    for (final item in list) {
        result.add(Genre.fromJson(item));
      }
    return result;
  }
}
