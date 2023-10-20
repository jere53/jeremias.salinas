import 'constants.dart' as constants;

enum MovieEndpoint {
  topRated(constants.endpointTopRated),
  upcoming(constants.endpointUpcoming),
  nowPlaying(constants.endpointNowPlaying),
  popular(constants.endpointPopular),
  byGenre('');

  const MovieEndpoint(this.url);

  final String url;
}
