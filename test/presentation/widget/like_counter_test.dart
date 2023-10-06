import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/like_counter.dart';

void main() {
  testWidgets('Like counter instantiates inkwell with proper text',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: LikeCounter(),
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);

    expect(find.text(LikeCounter.buttonText), findsOneWidget);
  });

  testWidgets('tapping inkwell increases like count', (widgetTester) async {
    await widgetTester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: LikeCounter(),
      ),
    );

    final LikeCounterState counterState =
        widgetTester.state(find.byType(LikeCounter));

    final int likeCount = counterState.likeCount;

    await widgetTester.tap(find.byType(InkWell));

    expect(counterState.likeCount, likeCount + 1);
  });
}
