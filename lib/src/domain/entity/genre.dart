import 'package:floor/floor.dart';

@entity
class Genre {
  @primaryKey
  final int id;

  final String name;

  const Genre(
    this.id,
    this.name,
  );

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      json['id'] ?? 0,
      json['name'] ?? '',
    );
  }
}
