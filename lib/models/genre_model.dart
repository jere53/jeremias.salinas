import 'genre.dart';

class GenreModel {
  static List<Genre> validGenres = [];

  static List<Genre>? fromJson(List<dynamic>? list) {
    var result = <Genre>[];
    list?.forEach(
      (item) {
        result.add(Genre.fromJson(item));
      },
    );
    return result;
  }
}
