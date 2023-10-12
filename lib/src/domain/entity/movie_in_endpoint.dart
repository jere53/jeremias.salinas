import 'package:floor/floor.dart';

import '../../core/util/enums.dart';
import 'movie.dart';

@Entity(
  primaryKeys: ['movie_id', 'endpoint'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['movie_id'],
      parentColumns: ['id'],
      entity: Movie,
      onDelete: ForeignKeyAction.cascade,
      onUpdate: ForeignKeyAction.cascade,
    ),
  ],
)
class MovieInEndpoint {
  @ColumnInfo(name: 'movie_id')
  final int movieID;

  final MovieEndpoint endpoint;

  final int page;

  const MovieInEndpoint(
    this.movieID,
    this.endpoint,
    this.page,
  );
}
