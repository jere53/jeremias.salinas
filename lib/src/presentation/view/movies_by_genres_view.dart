import 'package:flutter/material.dart';

import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/implementation/movies_by_genre_usecase.dart';
import '../../domain/usecase/implementation/valid_genres_usecase.dart';
import '../bloc/movie_with_genre_bloc.dart';
import '../widget/genre_drawer.dart';
import '../widget/movies_by_genre_list_view.dart';

class MoviesByGenreView extends StatefulWidget {
  final MoviesByGenreUsecase moviesByGenreUsecase;
  final ValidGenresUseCase validGenresUseCase;

  const MoviesByGenreView({
    super.key,
    required this.validGenresUseCase,
    required this.moviesByGenreUsecase,
  });

  static const noGenreTitle = 'Null Genre';

  @override
  State<MoviesByGenreView> createState() => _MoviesByGenreViewState();
}

class _MoviesByGenreViewState extends State<MoviesByGenreView> {
  late final MovieWithGenreBloc movieWithGenreBloc;

  @override
  void initState() {
    movieWithGenreBloc = MovieWithGenreBloc(
      moviesByGenreUsecase: widget.moviesByGenreUsecase,
      validGenresUseCase: widget.validGenresUseCase,
    );
    super.initState();
  }

  @override
  void dispose() {
    movieWithGenreBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Genre? targetGenre =
        ModalRoute.of(context)?.settings.arguments as Genre?;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            targetGenre?.name ?? MoviesByGenreView.noGenreTitle,
          ),
        ),
        drawer: GenreDrawer(
          futureValidGenreList: movieWithGenreBloc.fetchValidGenres(),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: StreamBuilder<List<Movie>>(
          initialData: movieWithGenreBloc.movies,
          stream: movieWithGenreBloc.moviesStream,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Movie>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              movieWithGenreBloc.fetchMoviesByGenre(
                targetGenre?.id,
              );

              return const CircularProgressIndicator();
            }

            if (snapshot.hasData) {
              final List<Movie> movies = snapshot.data!;
              final Widget list = MoviesByGenreListView(
                genre: targetGenre,
                movies: movies,
                movieWithGenreBloc: movieWithGenreBloc,
              );
              return list;
            }

            return const Text('error');
          },
        ),
      ),
    );
  }
}
