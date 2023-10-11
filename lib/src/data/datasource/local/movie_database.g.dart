// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorMovieDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MovieDatabaseBuilder databaseBuilder(String name) =>
      _$MovieDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MovieDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$MovieDatabaseBuilder(null);
}

class _$MovieDatabaseBuilder {
  _$MovieDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MovieDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MovieDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MovieDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MovieDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MovieDatabase extends MovieDatabase {
  _$MovieDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  GenreDao? _genreDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Movie` (`title` TEXT NOT NULL, `originalTitle` TEXT NOT NULL, `overview` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, `voteAverage` REAL NOT NULL, `genres` TEXT NOT NULL, `pathToBackdropImg` TEXT NOT NULL, `pathToPosterImg` TEXT NOT NULL, `adult` INTEGER NOT NULL, `originalLanguage` TEXT NOT NULL, `id` INTEGER NOT NULL, `popularity` REAL NOT NULL, `video` INTEGER NOT NULL, `voteCount` INTEGER NOT NULL, `page` INTEGER NOT NULL, `endpoint` INTEGER NOT NULL, PRIMARY KEY (`id`, `endpoint`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Genre` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  GenreDao get genreDao {
    return _genreDaoInstance ??= _$GenreDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (Movie item) => <String, Object?>{
                  'title': item.title,
                  'originalTitle': item.originalTitle,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'voteAverage': item.voteAverage,
                  'genres': _listOfIntConverter.encode(item.genres),
                  'pathToBackdropImg': item.pathToBackdropImg,
                  'pathToPosterImg': item.pathToPosterImg,
                  'adult': item.adult ? 1 : 0,
                  'originalLanguage': item.originalLanguage,
                  'id': item.id,
                  'popularity': item.popularity,
                  'video': item.video ? 1 : 0,
                  'voteCount': item.voteCount,
                  'page': item.page,
                  'endpoint': item.endpoint.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  @override
  Future<List<Movie>> fetchMovies(MovieEndpoint endpoint) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Movie WHERE (endpoint = ?1) ORDER BY page',
        mapper: (Map<String, Object?> row) => Movie(
            title: row['title'] as String,
            originalTitle: row['originalTitle'] as String,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            voteAverage: row['voteAverage'] as double,
            genres: _listOfIntConverter.decode(row['genres'] as String),
            pathToBackdropImg: row['pathToBackdropImg'] as String,
            pathToPosterImg: row['pathToPosterImg'] as String,
            adult: (row['adult'] as int) != 0,
            originalLanguage: row['originalLanguage'] as String,
            id: row['id'] as int,
            popularity: row['popularity'] as double,
            video: (row['video'] as int) != 0,
            voteCount: row['voteCount'] as int,
            page: row['page'] as int,
            endpoint: MovieEndpoint.values[row['endpoint'] as int]),
        arguments: [endpoint.index]);
  }

  @override
  Future<List<Movie>> fetchAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM Movie',
        mapper: (Map<String, Object?> row) => Movie(
            title: row['title'] as String,
            originalTitle: row['originalTitle'] as String,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            voteAverage: row['voteAverage'] as double,
            genres: _listOfIntConverter.decode(row['genres'] as String),
            pathToBackdropImg: row['pathToBackdropImg'] as String,
            pathToPosterImg: row['pathToPosterImg'] as String,
            adult: (row['adult'] as int) != 0,
            originalLanguage: row['originalLanguage'] as String,
            id: row['id'] as int,
            popularity: row['popularity'] as double,
            video: (row['video'] as int) != 0,
            voteCount: row['voteCount'] as int,
            page: row['page'] as int,
            endpoint: MovieEndpoint.values[row['endpoint'] as int]));
  }

  @override
  Future<List<Movie>> fetchMoviesByGenre(String genre) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Movie WHERE instr(genres, ?1) > 0 ORDER BY page',
        mapper: (Map<String, Object?> row) => Movie(
            title: row['title'] as String,
            originalTitle: row['originalTitle'] as String,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            voteAverage: row['voteAverage'] as double,
            genres: _listOfIntConverter.decode(row['genres'] as String),
            pathToBackdropImg: row['pathToBackdropImg'] as String,
            pathToPosterImg: row['pathToPosterImg'] as String,
            adult: (row['adult'] as int) != 0,
            originalLanguage: row['originalLanguage'] as String,
            id: row['id'] as int,
            popularity: row['popularity'] as double,
            video: (row['video'] as int) != 0,
            voteCount: row['voteCount'] as int,
            page: row['page'] as int,
            endpoint: MovieEndpoint.values[row['endpoint'] as int]),
        arguments: [genre]);
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    await _movieInsertionAdapter.insert(movie, OnConflictStrategy.replace);
  }
}

class _$GenreDao extends GenreDao {
  _$GenreDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _genreInsertionAdapter = InsertionAdapter(
            database,
            'Genre',
            (Genre item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Genre> _genreInsertionAdapter;

  @override
  Future<List<Genre>> fetchGenres() async {
    return _queryAdapter.queryList('SELECT * FROM Genre',
        mapper: (Map<String, Object?> row) =>
            Genre(row['id'] as int, row['name'] as String));
  }

  @override
  Future<void> insertGenre(Genre genre) async {
    await _genreInsertionAdapter.insert(genre, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _listOfIntConverter = ListOfIntConverter();
