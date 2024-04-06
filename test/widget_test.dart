import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alive_2/main.dart';

void main() {
  testWidgets('Verify quiz app UI', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that quiz app UI elements are present.
    expect(find.text('Quiz App'), findsOneWidget);
    expect(find.text('Correct Answers: 0 out of 10'), findsOneWidget);
    expect(find.text('Start Over'), findsOneWidget);

    // Tap the 'Start Over' button and trigger a frame.
    await tester.tap(find.text('Start Over'));
    await tester.pump();

    // Verify that quiz app UI resets to initial state.
    expect(find.text('Correct Answers: 0 out of 10'), findsOneWidget);
    expect(find.text('Start Over'), findsOneWidget);
  });
}
