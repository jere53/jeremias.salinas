import 'package:flutter/material.dart';

import '../../domain/entity/movie.dart';
import '../../domain/usecase/implementation/movies_from_endpoint_usecase.dart';
import '../../domain/usecase/implementation/valid_genres_usecase.dart';
import '../bloc/movie_from_endpoint_bloc.dart';
import '../widget/genre_drawer.dart';
import '../widget/movies_from_endpoint_grid_view.dart';

class MoviesView extends StatefulWidget {
  final MoviesFromEndpointUseCase moviesUseCase;
  final ValidGenresUseCase validGenresUseCase;

  const MoviesView({
    super.key,
    required this.moviesUseCase,
    required this.validGenresUseCase,
  });

  static int amt = 0;

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView>
    with AutomaticKeepAliveClientMixin {
  late final MoviesFromEndpointBloc movieBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    movieBloc = MoviesFromEndpointBloc(
      moviesUseCase: widget.moviesUseCase,
      validGenresUseCase: widget.validGenresUseCase,
    );
    super.initState();
  }

  @override
  void dispose() {
    movieBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            movieBloc.viewTitle(),
          ),
        ),
        drawer: GenreDrawer(
          futureValidGenreList: movieBloc.fetchValidGenres(),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: StreamBuilder<List<Movie>>(
          initialData: movieBloc.movies,
          stream: movieBloc.moviesStream,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Movie>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              movieBloc.fetchMovies();

              return const CircularProgressIndicator();
            }

            if (snapshot.hasData) {
              final List<Movie> movies = snapshot.data!;
              final Widget list = MoviesFromEndpointGridView(
                movies: movies,
                movieBloc: movieBloc,
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
