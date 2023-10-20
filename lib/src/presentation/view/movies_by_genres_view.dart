import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movie_with_genre_bloc.dart';
import '../widget/genre_drawer.dart';
import '../widget/movies_by_genre_list_view.dart';

class MoviesByGenreView extends StatefulWidget {
  const MoviesByGenreView({super.key});

  static const noGenreTitle = 'Null Genre';

  @override
  State<MoviesByGenreView> createState() => _MoviesByGenreViewState();
}

class _MoviesByGenreViewState extends State<MoviesByGenreView> {
  MovieWithGenreBloc? bloc;


  @override
  void didChangeDependencies() {
    bloc = context.watch<MovieWithGenreBloc>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieWithGenreBloc = context.read<MovieWithGenreBloc>();
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

              if (movies.isEmpty) {
                return const Center(
                  child: Text('No Movies found'),
                );
              }

              final Widget list = MoviesByGenreListView(
                genre: targetGenre,
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
