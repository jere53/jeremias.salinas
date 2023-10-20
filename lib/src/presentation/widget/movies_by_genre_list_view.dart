import 'package:flutter/material.dart';

import '../../core/util/function_call_when_bottom_reached.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movie_with_genre_bloc.dart';
import '../view/details_view.dart';
import 'bottom_loader.dart';
import 'movie_card.dart';

import 'package:provider/provider.dart';
class MoviesByGenreListView extends StatefulWidget {
  final List<Movie> movies;
  final Genre? genre;

  @override
  State<MoviesByGenreListView> createState() => _MoviesByGenreListViewState();

  const MoviesByGenreListView({
    super.key,
    required this.movies,
    required this.genre,
  });
}

class _MoviesByGenreListViewState extends State<MoviesByGenreListView>
    with FunctionCallWhenBottomReached {
  @override
  void dispose() {
    disposeFunctionCallWhenBottomReached();
    super.dispose();
  }

  @override
  void onReachBottom() {
    context.read<MovieWithGenreBloc>().fetchMoviesByGenre(widget.genre?.id);
  }

  @override
  Widget build(BuildContext context) {
    final Widget list = ListView.builder(
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return index >= widget.movies.length - 1
            ? const BottomLoader()
            : Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsView(
                          movie: widget.movies[index],
                        ),
                      ),
                    );
                  },
                  child: MovieCard(movie: widget.movies[index]),
                ),
              );
      },
      itemCount: widget.movies.length,
      controller: bottomReachedScrollController,
    );

    listenToScrollController();

    return list;
  }
}
