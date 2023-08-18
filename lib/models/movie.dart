class Movie {
  final String title;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final List<String> genres;
  final String pathToBackdropImg;
  final String pathToPosterImg;

  String get score => ((voteAverage * 10).toInt().toString());

  const Movie(
    this.title,
    this.originalTitle,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.genres,
    this.pathToBackdropImg,
    this.pathToPosterImg,
  );

  factory Movie.fromStatic() => const Movie(
        'The Super Mario Bros. Movie',
        'The Super Mario Bros. Movie',
        'While working underground to fix a water main, Brooklyn '
            'plumbers—and brothers—Mario and Luigi are transported down a mysterious '
            'pipe and wander into a magical new world. But when the brothers are separated, '
            'Mario embarks on an epic quest to find Luigi.',
        '2023-04-05',
        7.8,
        [
          'Animation',
          'Family',
          'Adventure',
          'Fantasy',
          'Comedy',
        ],
        'images/SuperMarioBackdrop.jpg',
        'images/SuperMarioPoster.jpg',
      );
}
