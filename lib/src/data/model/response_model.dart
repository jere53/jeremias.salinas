import '../../../src/domain/entity/movie.dart';
import '../../core/util/enums.dart';

class ResponseModel {
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results = <Movie>[];

  ResponseModel({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.results,
  });

  factory ResponseModel.fromJson(
    Map<String, dynamic> parsedJson, [
    int page = 0,
    MovieEndpoint endpoint = MovieEndpoint.popular,
  ]) {
    final parsedResults = List<Movie>.from(
      parsedJson['results']?.map(
            (movie) => Movie.fromJson(movie, page, endpoint),
          ) ??
          [],
    );
    return ResponseModel(
      page: parsedJson['page'] ?? 0,
      totalResults: parsedJson['total_results'] ?? 0,
      totalPages: parsedJson['total_pages'] ?? 0,
      results: parsedResults,
    );
  }
}
