import 'dart:convert';

import 'package:floor/floor.dart';

class ListOfIntConverter extends TypeConverter<List<int>, String> {
  @override
  List<int> decode(String databaseValue) {
    final json = jsonDecode(databaseValue) as List<dynamic>;
    return List<int>.from(
        json.map((genreID) => genreID),
    );
  }

  @override
  String encode(List<int> value) {
    return jsonEncode(value.map((genreID) => genreID).toList());
  }
}
