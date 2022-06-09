import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/audio/audio_controller.dart';
import 'package:flutter_practice/screen/demo_screen.dart';
import 'package:flutter_practice/screen/home_screen.dart';
import 'package:flutter_practice/shared/demo-widget.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AudioController>(
            create: ((context) => AudioController()..initialize()))
      ],
      child: MaterialApp(
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
        },
      ),
    );
  }
}
