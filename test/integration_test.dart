import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_practice/main.dart';

void main() {
  testWidgets('Test login success', (WidgetTester tester) async {
    // start app
    await tester.pumpWidget(
      const ProviderScope(
        // override providers if needed
        // overrides: [
        //   audioControllerProvider
        //       .overrideWith((_) => AudioController()..initialize())
        // ],
        child: MyApp(),
      ),
    );
    // wait for transition to finish
    await tester.pumpAndSettle();
    // scroll the list and find the DartTestDemo tab
    final listFinder = find.byKey(const ValueKey('tabs'));
    final itemFinder = find.byKey(const Key('Testing Demo'));
    await tester.dragUntilVisible(
      itemFinder,
      listFinder,
      const Offset(0.0, -50.0),
      maxIteration: 100,
    );
    await tester.pumpAndSettle();
    expect(itemFinder, findsOneWidget);
    // tap DartTestDemo tab
    await tester.tap(itemFinder);
    // wait for transition to finish
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('username')), findsOneWidget);
    expect(find.byKey(const ValueKey('password')), findsOneWidget);
    expect(find.byKey(const ValueKey('login')), findsOneWidget);
  });
}
