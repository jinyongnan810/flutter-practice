import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/models/user.dart';
import 'package:flutter_practice/screen/demo_screen.dart';
import 'package:flutter_practice/screen/home_screen.dart';
import 'package:flutter_practice/shared/demo-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

void main() {
  if (kReleaseMode) {
    // Don't log anything below warnings in production.
    Logger.root.level = Level.WARNING;
  }
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}');
  });
  // Dio().get('https://randomuser.me/api/').then((response) {
  //   print(response.data);
  //   final user = User.fromJson(response.data['results'][0]);
  //   print(user);
  // });
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Practices',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        home: HomeScreen(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute<void>(
            builder: (_) => DemoScreen(
              child: settings.arguments as DemoWidget,
            ),
          );
        });
  }
}
