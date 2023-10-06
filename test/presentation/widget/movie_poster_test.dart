import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_poster.dart';

import '../../test_cache_manager.dart';

void main() {
  testWidgets('movie poster renders image', (widgetTester) async {
    final moviePoster = MoviePoster(
      pathToPosterImg: '',
      width: 200,
      height: 400,
      cacheManager: TestCacheManager(),
    );

    await widgetTester.pumpWidget(moviePoster);

    expect(find.byType(Image), findsOneWidget);
  });
}
