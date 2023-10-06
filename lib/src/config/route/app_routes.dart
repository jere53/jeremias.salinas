import 'package:flutter/cupertino.dart';

import '../../core/util/constants.dart' as constants;
import '../../domain/repository/i_movie_repository.dart';
import '../../domain/usecase/implementation/movies_by_genre_usecase.dart';
import '../../domain/usecase/implementation/movies_from_endpoint_usecase.dart';
import '../../domain/usecase/implementation/valid_genres_usecase.dart';
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
        constants.genreAppRoute: (context) => MoviesByGenreView(
              moviesByGenreUsecase: MoviesByGenreUsecase(
                repository: repository,
              ),
              validGenresUseCase: ValidGenresUseCase(
                repository: repository,
              ),
            ),
      };

  Map<String, Widget Function(BuildContext)> getMovieEndpointRoutes() =>
      endpointRoutes ??= {
        constants.endpointPopular: (context) => MoviesView(
              moviesUseCase: PopularUseCase(
                repository: repository,
              ),
              validGenresUseCase: ValidGenresUseCase(
                repository: repository,
              ),
            ),
        constants.endpointNowPlaying: (context) => MoviesView(
              moviesUseCase: NowPlayingUseCase(
                repository: repository,
              ),
              validGenresUseCase: ValidGenresUseCase(
                repository: repository,
              ),
            ),
        constants.endpointUpcoming: (context) => MoviesView(
              moviesUseCase: UpcomingUseCase(
                repository: repository,
              ),
              validGenresUseCase: ValidGenresUseCase(
                repository: repository,
              ),
            ),
        constants.endpointTopRated: (context) => MoviesView(
              moviesUseCase: TopRatedUseCase(
                repository: repository,
              ),
              validGenresUseCase: ValidGenresUseCase(
                repository: repository,
              ),
            ),
      };
}
