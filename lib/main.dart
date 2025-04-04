import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_practice/color_schemes.g.dart';
import 'package:flutter_practice/demos/adaptive_scaffold_demo.dart';
import 'package:flutter_practice/demos/animations_demo.dart';
import 'package:flutter_practice/demos/blur_when_scroll_demo.dart';
import 'package:flutter_practice/demos/dart_test_demo.dart';
import 'package:flutter_practice/demos/flutter_portal_demo.dart';
import 'package:flutter_practice/demos/flutter_portal_demo2.dart';
import 'package:flutter_practice/demos/flutter_quill_demo.dart';
import 'package:flutter_practice/demos/gemini_demo.dart';
import 'package:flutter_practice/demos/gradient_demo.dart';
import 'package:flutter_practice/demos/hero_animation_demo.dart';
import 'package:flutter_practice/demos/image_filter_demo.dart';
import 'package:flutter_practice/demos/inherited_widget_demo.dart';
import 'package:flutter_practice/demos/mix_demo.dart';
import 'package:flutter_practice/demos/nested_nav_demo.dart';
import 'package:flutter_practice/demos/pigeon_demo.dart';
import 'package:flutter_practice/demos/play_sound_demo.dart';
import 'package:flutter_practice/demos/reorder_list_demo.dart';
import 'package:flutter_practice/demos/ripple_effect_demo.dart';
import 'package:flutter_practice/demos/shader_mask_demo.dart';
import 'package:flutter_practice/demos/shorebird_demo.dart';
import 'package:flutter_practice/demos/snackbar_demo.dart';
import 'package:flutter_practice/demos/theme_color_demo.dart';
import 'package:flutter_practice/demos/threed_drawer_demo.dart';
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
  await dotenv.load(fileName: "env");
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
          path: 'dart-test',
          builder: (context, state) => const DartTestDemo(),
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
          path: '3d-drawer',
          builder: (context, state) => const ThreedDrawerDemo(),
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
        GoRoute(path: 'mix', builder: (context, state) => const MixDemo()),
        GoRoute(
          path: 'animations',
          builder: (context, state) => const AnimationsDemo(),
        ),
        GoRoute(
          path: 'shader-mask',
          builder: (context, state) => const ShaderMaskDemo(),
        ),
        GoRoute(
          path: 'image-filter',
          builder: (context, state) => const ImageFilterDemo(),
        ),
        GoRoute(
          path: 'blur-when-scroll',
          builder: (context, state) => const BlurWhenScrollDemo(),
        ),
        GoRoute(
          path: 'ripple-effect',
          builder: (context, state) => const RippleEffectDemo(),
        ),
        if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)
          GoRoute(
            path: 'shorebird',
            builder: (context, state) => const ShoreBirdDemo(),
          ),
        GoRoute(
          path: 'nested-nav',
          builder: (context, state) => const NestedNavDemo(),
        ),
        GoRoute(
          path: 'adaptive-scaffold',
          builder: (context, state) => const AdaptiveScaffoldDemo(),
        ),
        GoRoute(
          path: 'reorder-list',
          builder: (context, state) => ReOrderListDemo(),
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
