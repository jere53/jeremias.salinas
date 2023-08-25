import 'package:flutter/material.dart';
import '../../../pages/movies_page.dart';
import 'utils/movie_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MoviesPage(repository: MovieRepository()),
    );
  }
}
