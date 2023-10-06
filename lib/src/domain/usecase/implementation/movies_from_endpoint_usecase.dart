import 'dart:async';

import '/src/domain/usecase/usecase_interface.dart';
import '../../../core/util/data_state.dart';
import '../../../core/util/enums.dart';
import '../../entity/movie.dart';
import '../../repository/i_movie_repository.dart';

sealed class MoviesFromEndpointUseCase implements IUseCase {
  Future<DataState<List<Movie>>> _fetchMovies(int page);

  @override
  Future<DataState> call(dynamic params) {
    return _fetchMovies(params.page ?? 0);
  }
}

class PopularUseCase extends MoviesFromEndpointUseCase {
  final IMovieRepository repository;

  PopularUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Movie>>> _fetchMovies(int page) {
    return repository.getMovies(
      page,
      MovieEndpoint.popular,
    );
  }
}

class UpcomingUseCase extends MoviesFromEndpointUseCase {
  final IMovieRepository repository;

  UpcomingUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Movie>>> _fetchMovies(int page) {
    return repository.getMovies(
      page,
      MovieEndpoint.upcoming,
    );
  }
}

class TopRatedUseCase extends MoviesFromEndpointUseCase {
  final IMovieRepository repository;

  TopRatedUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Movie>>> _fetchMovies(int page) {
    return repository.getMovies(
      page,
      MovieEndpoint.topRated,
    );
  }
}

class NowPlayingUseCase extends MoviesFromEndpointUseCase {
  final IMovieRepository repository;

  NowPlayingUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Movie>>> _fetchMovies(int page) {
    return repository.getMovies(
      page,
      MovieEndpoint.nowPlaying,
    );
  }
}
