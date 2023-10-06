import 'constants.dart' as constants;

enum MovieEndpoint {
  topRated(constants.endpointTopRated),
  upcoming(constants.endpointUpcoming),
  nowPlaying(constants.endpointNowPlaying),
  popular(constants.endpointPopular);

  const MovieEndpoint(this.url);

  final String url;
}
