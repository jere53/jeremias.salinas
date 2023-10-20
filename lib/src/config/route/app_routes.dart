import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../core/util/constants.dart' as constants;
import '../../domain/repository/i_movie_repository.dart';
import '../../domain/usecase/implementation/movies_by_genre_usecase.dart';
import '../../domain/usecase/implementation/movies_from_endpoint_usecase.dart';
import '../../domain/usecase/implementation/valid_genres_usecase.dart';
import '../../presentation/bloc/movie_from_endpoint_bloc.dart';
import '../../presentation/bloc/movie_with_genre_bloc.dart';
import '../../presentation/view/movies_by_genres_view.dart';
import '../../presentation/view/movies_view.dart';

class AppRoutes {
  final IMovieRepository repository;

  AppRoutes(this.repository);

  Map<String, Widget Function(BuildContext)>? endpointRoutes;

  Map<String, Widget Function(BuildContext)> get routes {
    final map = <String, Widget Function(BuildContext)>{};
    map.addAll(endpointRoutes ?? {});
    map.addAll(genreRoute);
    return map;
  }

  Map<String, Widget Function(BuildContext)> get genreRoute => {
        constants.genreAppRoute: (context) =>
            Provider<MovieWithGenreBloc>(
              create: (context) => MovieWithGenreBloc(
                moviesByGenreUsecase: MoviesByGenreUsecase(
                  repository: repository,
                ),
                validGenresUseCase: ValidGenresUseCase(
                  repository: repository,
                ),
              ),
              builder: (context, child) => const MoviesByGenreView(),
            ),
      };

  Map<String, Widget Function(BuildContext)> getMovieEndpointRoutes() =>
      endpointRoutes ??= {
        constants.endpointPopular: (context) =>
            Provider<MoviesFromEndpointBloc>(
              create: (context) => MoviesFromEndpointBloc(
                moviesUseCase: PopularUseCase(
                  repository: repository,
                ),
                validGenresUseCase: ValidGenresUseCase(
                  repository: repository,
                ),
              ),
              builder: (context, child) => const MoviesView(),
            ),
        constants.endpointNowPlaying: (context) =>
            Provider<MoviesFromEndpointBloc>(
              create: (context) => MoviesFromEndpointBloc(
                moviesUseCase: NowPlayingUseCase(
                  repository: repository,
                ),
                validGenresUseCase: ValidGenresUseCase(
                  repository: repository,
                ),
              ),
              builder: (context, child) => const MoviesView(),
            ),
        constants.endpointUpcoming: (context) =>
            Provider<MoviesFromEndpointBloc>(
              create: (context) => MoviesFromEndpointBloc(
                moviesUseCase: UpcomingUseCase(
                  repository: repository,
                ),
                validGenresUseCase: ValidGenresUseCase(
                  repository: repository,
                ),
              ),
              builder: (context, child) => const MoviesView(),
            ),
        constants.endpointTopRated: (context) =>
            Provider<MoviesFromEndpointBloc>(
              create: (context) => MoviesFromEndpointBloc(
                moviesUseCase: TopRatedUseCase(
                  repository: repository,
                ),
                validGenresUseCase: ValidGenresUseCase(
                  repository: repository,
                ),
              ),
              builder: (context, child) => const MoviesView(),
            ),
      };
}
