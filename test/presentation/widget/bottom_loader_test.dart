import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/bottom_loader.dart';

void main() {
  testWidgets('bottom loader renders loading circle', (tester) async {
    await tester.pumpWidget(const BottomLoader());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
