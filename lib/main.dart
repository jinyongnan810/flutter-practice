import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_practice/color_schemes.g.dart';
import 'package:flutter_practice/demos/animated_builder_demo.dart';
import 'package:flutter_practice/demos/animated_builder_demo2.dart';
import 'package:flutter_practice/demos/animated_prompt_demo.dart';
import 'package:flutter_practice/demos/chained_animation_demo.dart';
import 'package:flutter_practice/demos/custom_painter_demo.dart';
import 'package:flutter_practice/demos/dart_test_demo.dart';
import 'package:flutter_practice/demos/drag_and_drop_demo.dart';
import 'package:flutter_practice/demos/flutter_portal_demo.dart';
import 'package:flutter_practice/demos/flutter_portal_demo2.dart';
import 'package:flutter_practice/demos/flutter_quill_demo.dart';
import 'package:flutter_practice/demos/gemini_demo.dart';
import 'package:flutter_practice/demos/gradient_demo.dart';
import 'package:flutter_practice/demos/hero_animation_demo.dart';
import 'package:flutter_practice/demos/implicit_animation_demo.dart';
import 'package:flutter_practice/demos/inherited_widget_demo.dart';
import 'package:flutter_practice/demos/pigeon_demo.dart';
import 'package:flutter_practice/demos/play_sound_demo.dart';
import 'package:flutter_practice/demos/snackbar_demo.dart';
import 'package:flutter_practice/demos/theme_color_demo.dart';
import 'package:flutter_practice/demos/threed_animation_demo.dart';
import 'package:flutter_practice/demos/threed_drawer_demo.dart';
import 'package:flutter_practice/demos/tween_animation_demo.dart';
import 'package:flutter_practice/demos/twod_scrolling_demo.dart';
import 'package:flutter_practice/demos/websocket_demo.dart';
import 'package:flutter_practice/pigeon.dart';
import 'package:flutter_practice/screen/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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

  TestFlutterApi.setUp(FlutterApi());
  runApp(const ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'gemini-chat',
          builder: (context, state) => const GeminiDemo(),
        ),
        GoRoute(
          path: 'animated-prompt',
          builder: (context, state) => const AnimatedPromptDemo(),
        ),
        GoRoute(
          path: 'animated-builder',
          builder: (context, state) => const AnimatedBuilderDemo(),
        ),
        GoRoute(
          path: 'animated-builder2',
          builder: (context, state) => const AnimatedBuilderDemo2(),
        ),
        GoRoute(
          path: 'chained-animation',
          builder: (context, state) => const ChainedAnimationDemo(),
        ),
        GoRoute(
          path: 'custom-painter',
          builder: (context, state) => const CustomPainterDemo(),
        ),
        GoRoute(
          path: 'dart-test',
          builder: (context, state) => const DartTestDemo(),
        ),
        GoRoute(
          path: 'drag-and-drop',
          builder: (context, state) => const DragAndDropDemo(),
        ),
        GoRoute(
          path: 'portal1',
          builder: (context, state) => const FlutterPortalDemo(),
        ),
        GoRoute(
          path: 'portal2',
          builder: (context, state) => const FlutterPortalDemo2(),
        ),
        GoRoute(
          path: 'hero',
          builder: (context, state) => const HeroAnimationDemo(),
        ),
        GoRoute(
          path: 'implicit-animation',
          builder: (context, state) => const ImplicitAnimationDemo(),
        ),
        GoRoute(
          path: 'inherited-widget',
          builder: (context, state) => const InheritedWidgetDemo(),
        ),
        GoRoute(
          path: 'sound',
          builder: (context, state) => const PlaySoundDemo(),
        ),
        GoRoute(
          path: 'snackbar',
          builder: (context, state) => SnackbarDemo(),
        ),
        GoRoute(
          path: '3d',
          builder: (context, state) => const ThreeDAnimationDemo(),
        ),
        GoRoute(
          path: '3d-drawer',
          builder: (context, state) => const ThreedDrawerDemo(),
        ),
        GoRoute(
          path: 'tween-animation',
          builder: (context, state) => const TweenAnimationDemo(),
        ),
        GoRoute(
          path: '2d-scrolling',
          builder: (context, state) => const TwoDScrollingDemo(),
        ),
        GoRoute(
          path: 'websocket',
          builder: (context, state) => const WebSocketDemo(),
        ),
        GoRoute(
          path: 'flutter-quill',
          builder: (context, state) => const FlutterQuillDemo(),
        ),
        GoRoute(
          path: 'pigeon',
          builder: (context, state) => const PigeonDemo(),
        ),
        GoRoute(
          path: 'gradient',
          builder: (context, state) => const GradientDemo(),
        ),
        GoRoute(
          path: 'theme-color',
          builder: (context, state) => const ThemeColorDemo(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp.router(
        title: 'Flutter Practices',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: GoogleFonts.caveatTextTheme(),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: GoogleFonts.caveatTextTheme(),
        ),
        themeMode: ThemeMode.light,
        routerConfig: _router,
      ),
    );
  }
}
