import 'package:flutter/material.dart';
import 'package:flutter_practice/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO: fix tests

void main() {
  group("test login", () {
    setUp(() async {});
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
      // check page loaded
      expect(find.byKey(const ValueKey('username')), findsOneWidget);
      expect(find.byKey(const ValueKey('password')), findsOneWidget);
      expect(find.byKey(const ValueKey('login')), findsOneWidget);

      // enter strings
      await tester.enterText(find.byKey(const ValueKey('username')), 'user');
      await tester.enterText(
        find.byKey(const ValueKey('password')),
        'password',
      );
      await tester.tap(find.byKey(const ValueKey('login')));
      await tester.pumpAndSettle();

      // check login success
      expect(find.byKey(const Key('Hello')), findsOneWidget);
    });

    testWidgets('Test login failure(username)', (WidgetTester tester) async {
      // start app
      await tester.pumpWidget(
        const ProviderScope(
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
      // check page loaded
      expect(find.byKey(const ValueKey('username')), findsOneWidget);
      expect(find.byKey(const ValueKey('password')), findsOneWidget);
      expect(find.byKey(const ValueKey('login')), findsOneWidget);

      // enter strings
      await tester.enterText(
        find.byKey(const ValueKey('username')),
        'user-not-exists',
      );
      await tester.enterText(
        find.byKey(const ValueKey('password')),
        'password',
      );
      await tester.tap(find.byKey(const ValueKey('login')));
      await tester.pumpAndSettle();

      // check login failure
      expect(find.byKey(const Key('Hello')), findsNothing);
      expect(find.byKey(const Key('error')), findsOneWidget);
    });

    testWidgets('Test login failure(password)', (WidgetTester tester) async {
      // start app
      await tester.pumpWidget(
        const ProviderScope(
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
      // check page loaded
      expect(find.byKey(const ValueKey('username')), findsOneWidget);
      expect(find.byKey(const ValueKey('password')), findsOneWidget);
      expect(find.byKey(const ValueKey('login')), findsOneWidget);

      // enter strings
      await tester.enterText(
        find.byKey(const ValueKey('username')),
        'user',
      );
      await tester.enterText(
        find.byKey(const ValueKey('password')),
        'incorrect-password',
      );
      await tester.tap(find.byKey(const ValueKey('login')));
      await tester.pumpAndSettle();

      // check login failure
      expect(find.byKey(const Key('Hello')), findsNothing);
      expect(find.byKey(const Key('error')), findsOneWidget);
    });
  });
}
