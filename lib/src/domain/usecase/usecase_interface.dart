import '../../core/util/data_state.dart';

abstract interface class IUseCase<T, Y> {
  Future<DataState<T>> call(Y params);
}
