import 'package:floor/floor.dart';

import '../../core/util/enums.dart';
import '../../data/datasource/local/list_of_int_converter.dart';

@entity
class Movie {
  final String title;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  final List<int> genres;

  final String pathToBackdropImg;
  final String pathToPosterImg;
  final bool adult;
  final String originalLanguage;

  @primaryKey
  final int id;

  final double popularity;
  final bool video;
  final int voteCount;

  final int page;
  final MovieEndpoint endpoint;

  String get score => (voteAverage * 10).toInt().toString();

  const Movie({
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.genres,
    required this.pathToBackdropImg,
    required this.pathToPosterImg,
    required this.adult,
    required this.originalLanguage,
    required this.id,
    required this.popularity,
    required this.video,
    required this.voteCount,
    required this.page,
    required this.endpoint,
  });

  static const emptyString = '';

  factory Movie.fromJson(
    Map<String, dynamic> json, [
    int page = 0,
    MovieEndpoint endpoint = MovieEndpoint.popular,
  ]) {
    final List<int> genreIDs = List<int>.from(
      json['genre_ids'] ?? [],
    );
    return Movie(
      title: json['title'] ?? emptyString,
      originalTitle: json['original_title'] ?? emptyString,
      overview: json['overview'] ?? emptyString,
      releaseDate: json['release_date'] ?? emptyString,
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      genres: genreIDs,
      pathToBackdropImg: json['backdrop_path'] ?? emptyString,
      pathToPosterImg: json['poster_path'] ?? emptyString,
      adult: json['adult'] ?? false,
      originalLanguage: json['original_language'] ?? emptyString,
      id: json['id'] ?? 0,
      popularity: json['popularity']?.toDouble() ?? 0.0,
      video: json['video'] ?? false,
      voteCount: json['vote_count'] ?? 0,
      page: page,
      endpoint: endpoint,
    );
  }

  factory Movie.fromStatic() {
    const List<int> genreIDs = [
      12,
      10751,
      16,
      14,
      35,
    ];
    return const Movie(
      title: 'The Super Mario Bros. Movie',
      originalTitle: 'The Super Mario Bros. Movie',
      overview: 'While working underground to fix a water main, Brooklyn '
          'plumbers—and brothers—Mario and Luigi are transported down a mysterious '
          'pipe and wander into a magical new world. But when the brothers are separated, '
          'Mario embarks on an epic quest to find Luigi.',
      releaseDate: '2023-04-05',
      voteAverage: 7.8,
      genres: genreIDs,
      pathToBackdropImg: 'images/SuperMarioBackdrop.jpg',
      pathToPosterImg: 'images/SuperMarioPoster.jpg',
      adult: false,
      originalLanguage: 'en',
      id: 0,
      popularity: 100,
      video: false,
      voteCount: 100000,
      page: 1,
      endpoint: MovieEndpoint.popular,
    );
  }
}
