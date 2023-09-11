import 'package:flutter/material.dart';

import 'src/config/theme/app_themes.dart';
import 'src/data/repository/movie_repository.dart';
import 'src/domain/repository/i_movie_repository.dart';
import 'src/presentation/view/movies_view.dart';

void main() {
  final IMovieRepository repository = MovieRepository();
  runApp(
    MyApp(
      repository: repository,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.repository,
  });

  final IMovieRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: MoviesView(
        repository: repository,
      ),
    );
  }
}
