import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:scalytics_app/main.dart';

void main() {
  testWidgets('basic test', (WidgetTester tester) async {
    await tester.pumpWidget(const ScalpAIApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}