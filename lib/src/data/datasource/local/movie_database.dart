import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../core/util/enums.dart';
import '../../../domain/entity/genre.dart';
import '../../../domain/entity/movie.dart';
import 'DAOs/genre_dao.dart';
import 'DAOs/movie_dao.dart';
import 'list_of_int_converter.dart';

part 'movie_database.g.dart';

@TypeConverters([ListOfIntConverter])
@Database(version: 1, entities: [Movie, Genre])
abstract class MovieDatabase extends FloorDatabase {
  MovieDao get movieDao;
  GenreDao get genreDao;
}
