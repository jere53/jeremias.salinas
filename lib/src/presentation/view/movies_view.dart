import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/movie.dart';
import '../bloc/movie_from_endpoint_bloc.dart';
import '../widget/genre_drawer.dart';
import '../widget/movies_from_endpoint_grid_view.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({super.key});

  static int amt = 0;

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView>
    with AutomaticKeepAliveClientMixin {
  late MoviesFromEndpointBloc movieBloc;

  @override
  bool get wantKeepAlive => true;


  @override
  void didChangeDependencies() {
    movieBloc = context.watch<MoviesFromEndpointBloc>();
    super.didChangeDependencies();
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

              if (movies.isEmpty) {
                return const Center(
                  child: Text('No Movies found'),
                );
              }

              final Widget list = MoviesFromEndpointGridView(
                movies: movies,
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
