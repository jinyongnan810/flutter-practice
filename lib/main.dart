import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_practice/color_schemes.g.dart';
import 'package:flutter_practice/screen/demo_screen.dart';
import 'package:flutter_practice/screen/home_screen.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  if (kReleaseMode) {
    // Don't log anything below warnings in production.
    Logger.root.level = Level.WARNING;
  }
  await dotenv.load(fileName: ".env");
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

  // print('env: ${AppFeatures.testEnv}');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp(
        title: 'Flutter Practices',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        home: const HomeScreen(),
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
