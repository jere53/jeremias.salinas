import '../../../core/util/data_state.dart';
import '../../entity/genre.dart';
import '../../repository/i_movie_repository.dart';
import '../usecase_interface.dart';

class ValidGenresUseCase implements IUseCase {
  final IMovieRepository repository;

  ValidGenresUseCase({required this.repository});

  @override
  Future<DataState<List<Genre>>> call([dynamic params]) {
    return repository.getValidGenres();
  }
}
