import '../../../src/domain/entity/movie.dart';

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

  factory ResponseModel.fromJson(Map<String, dynamic> parsedJson) {
    final parsedResults = List<Movie>.from(
      parsedJson['results']?.map(
            (movie) => Movie.fromJson(movie),
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
