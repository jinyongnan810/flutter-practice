import 'package:flutter/material.dart';
import 'package:flutter_practice/audio/audio_controller.dart';
import 'package:flutter_practice/screen/demo_screen.dart';
import 'package:flutter_practice/screen/home_screen.dart';
import 'package:flutter_practice/shared/demo-widget.dart';
import 'package:provider/provider.dart';

void main() {
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
