import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/parameter/movie_parameter.dart';
import '../../core/util/data_state.dart';
import '../../core/util/debouncer.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/implementation/movies_from_endpoint_usecase.dart';
import '../../domain/usecase/implementation/valid_genres_usecase.dart';

class MoviesFromEndpointBloc implements IBloc {
  static const titlePopular = 'Popular';
  static const titleUpcoming = 'Upcoming';
  static const titleTopRated = 'Top Rated';
  static const titleNowPlaying = 'Now Playing';

  final Debouncer debouncer = Debouncer(milliseconds: 1000);
  int _currentPage = 1;
  final MoviesFromEndpointUseCase moviesUseCase;
  final ValidGenresUseCase validGenresUseCase;

  MoviesFromEndpointBloc({
    required this.moviesUseCase,
    required this.validGenresUseCase,
  });

  final List<Movie> _movies = <Movie>[];

  List<Movie> get movies => _movies;

  final StreamController<List<Movie>> _streamController =
      StreamController<List<Movie>>.broadcast();

  Stream<List<Movie>> get moviesStream => _streamController.stream;

  Future<void> _fetchMoviesDebounced(int page) async {
    final results = await moviesUseCase(
      MovieApiParams(
        page: page,
      ),
    );
    if (results is DataSuccess) {
      _movies.addAll(results.data!);
      _streamController.sink.add(_movies);
      _currentPage++;
    } else {
      _streamController.sink.addError(results.error!);
    }
  }

  void fetchMovies() {
    debouncer.run(() => _fetchMoviesDebounced(_currentPage));
  }

  Future<DataState<List<Genre>>> fetchValidGenres() {
    return validGenresUseCase();
  }

  String viewTitle() {
    switch (moviesUseCase) {
      case PopularUseCase():
        return titlePopular;
      case UpcomingUseCase():
        return titleUpcoming;
      case TopRatedUseCase():
        return titleTopRated;
      case NowPlayingUseCase():
        return titleNowPlaying;
    }
  }

  @override
  void dispose() {
    _streamController.close();
    debouncer.dispose();
  }

  @override
  Future<void> initialize() async {}
}
