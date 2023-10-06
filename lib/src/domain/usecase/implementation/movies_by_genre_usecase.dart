import '../../../core/util/data_state.dart';
import '../../repository/i_movie_repository.dart';
import '../usecase_interface.dart';

class MoviesByGenreUsecase implements IUseCase {
  final IMovieRepository repository;

  MoviesByGenreUsecase({required this.repository});

  Future<DataState> _fetchMovies(
    int page,
    int genre,
  ) {
    return repository.getMoviesByGenre(
      genre,
      page,
    );
  }

  @override
  Future<DataState> call(dynamic params) {
    return _fetchMovies(
      params?.page ?? 0,
      params?.genre ?? 0,
    );
  }
}
