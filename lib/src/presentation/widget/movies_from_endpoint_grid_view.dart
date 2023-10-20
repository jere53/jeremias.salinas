import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/util/function_call_when_bottom_reached.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movie_from_endpoint_bloc.dart';
import '../view/details_view.dart';
import 'bottom_loader.dart';
import 'movie_card.dart';

class MoviesFromEndpointGridView extends StatefulWidget {
  final List<Movie> movies;
  @override
  State<MoviesFromEndpointGridView> createState() =>
      _MoviesFromEndpointGridViewState();

  const MoviesFromEndpointGridView({
    super.key,
    required this.movies,
  });
}

class _MoviesFromEndpointGridViewState extends State<MoviesFromEndpointGridView>
    with FunctionCallWhenBottomReached {
  @override
  void onReachBottom() {
    context.read<MoviesFromEndpointBloc>().fetchMovies();
  }

  @override
  void dispose() {
    disposeFunctionCallWhenBottomReached();
    super.dispose();
  }

  static const double gridItemHeight = 450;
  static const int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    final Widget list = GridView.builder(
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: gridItemHeight,
      ),
      controller: bottomReachedScrollController,
    );

    listenToScrollController();

    return list;
  }
}
