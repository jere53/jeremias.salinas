import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/parameter/movie_parameter.dart';
import '../../core/util/data_state.dart';
import '../../core/util/debouncer.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/implementation/movies_by_genre_usecase.dart';
import '../../domain/usecase/implementation/valid_genres_usecase.dart';

class MovieWithGenreBloc implements IBloc {
  final Debouncer debouncer = Debouncer(milliseconds: 1000);
  int _currentPage = 1;
  final MoviesByGenreUsecase moviesByGenreUsecase;
  final ValidGenresUseCase validGenresUseCase;
  int? targetGenre;

  MovieWithGenreBloc({
    required this.moviesByGenreUsecase,
    required this.validGenresUseCase,
  });

  final List<Movie> _movies = <Movie>[];

  List<Movie> get movies => _movies;

  final StreamController<List<Movie>> _streamController =
      StreamController<List<Movie>>.broadcast();

  Stream<List<Movie>> get moviesStream => _streamController.stream;

  Future<void> _fetchMoviesDebounced(int page) async {
    final results = await moviesByGenreUsecase(
      MovieApiParams(
        page: page,
        genre: targetGenre,
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

  void fetchMoviesByGenre(int? genre) {
    targetGenre = genre;
    debouncer.run(() => _fetchMoviesDebounced(_currentPage));
  }

  @override
  void dispose() {
    _streamController.close();
    debouncer.dispose();
  }

  Future<DataState<List<Genre>>> fetchValidGenres() {
    return validGenresUseCase();
  }

  @override
  Future<void> initialize() async {}
}
