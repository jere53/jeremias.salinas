import 'package:flutter/material.dart';

import 'src/config/route/app_routes.dart';
import 'src/config/theme/app_themes.dart';
import 'src/data/datasource/remote/movie_api_service.dart';
import 'src/data/repository/movie_api_repository.dart';
import 'src/domain/repository/i_movie_repository.dart';

void main() {
  final IMovieRepository repository = MovieApiRepository(MovieApiService());
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
    final AppRoutes appRoutes = AppRoutes(repository);
    final pageList = appRoutes
        .getMovieEndpointRoutes()
        .values
        .map((e) => e.call(context))
        .toList();

    return MaterialApp(
      theme: AppTheme.dark,
      routes: appRoutes.routes,
      home: Scaffold(
        body: PageView(
          controller: PageController(),
          children: pageList,
        ),
      ),
    );
  }
}
