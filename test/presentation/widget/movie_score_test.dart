import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/movie_score.dart';

void main() {
  testWidgets('widgets are rendered correctly', (widgetTester) async {
    const score = '30';
    const voteCount = 2040;
    const movieScore = MovieScore(movieScore: score, voteCount: voteCount);
    await widgetTester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: movieScore,
      ),
    );

    expect(find.text(score), findsOneWidget);
    expect(find.text(movieScore.getFormattedVoteCount()), findsOneWidget);
  });
}
