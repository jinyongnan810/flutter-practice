[Ref Repo](https://github.com/jinyongnan810/flutter-samples-study)
[Practice Repo](https://github.com/jinyongnan810/flutter-practice)

# Purpose

- Learn the basics
- Learn how to build ui
- Learn how other peaple code

# Daily Practice

## Day 1

### 2 ways of building routes

```dart
// 1. using onGenerateRoute
onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          builder: (_) => DemoScreen(
            child: settings.arguments as DemoWidget,
          ),
        );
      },
// each screen should have static const routeName
static const String routeName = '/demoScreen';
// 2.  using routes
routes: {
            '/': (ctx) => const MemoListPage(),
            '/detail': (ctx) => const MemoDetailPage()
          },
```

### Restrict widgets to has certain fields

```dart
// first create an abstract class
abstract class DemoWidget extends Widget {
  const DemoWidget({Key? key}) : super(key: key);
  String get title;
  String get description;
}
// then implements the abstract class
class PlaySoundDemo extends StatelessWidget implements DemoWidget {
  const PlaySoundDemo({Key? key}) : super(key: key);
  static const String _title = 'Play Sound Demo';
  static const String _description =
      'Practice Caching and Playing Sound and all';
  @override
  String get title => PlaySoundDemo._title;
  @override
  String get description => PlaySoundDemo._description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Play sound demo'),
    );
  }
}
```

### SafeArea

- Wrap widgets with SafeArea will automatically add paddings to avoid platform-specific ui clash

## Day 3

### Play audio

Uses [audioplayers](https://pub.dev/packages/audioplayers)

- To play local assets, we need to use the AudioCache

```dart
// create a player to monitor playing status
final _sfxPlayer = AudioPlayer(playerId: 'sfxPlayer',mode: PlayerMode.LOW_LATENCY))
// create a cache to load and play assets
final _sfxCache = AudioCache(
      fixedPlayer: _sfxPlayer,
      prefix: 'assets/sfx/',
    );
// preload the assets to play immediately
await _sfxCache.loadAll(filenames)
```

## Day 4

### Logging

Uses [logging package](https://pub.dev/packages/logging)

- Decide the root logging level & the logging format in main

```dart
// in main.dart
if (kReleaseMode) {
    // Don't log anything below warnings in production.
    Logger.root.level = Level.WARNING;
  }
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}');
  });
// then create an instance in the class
final _logger = Logger('AudioController');
// then do the logging
_logger.info('playing sfx:$filename');
// gets INFO: 2022-06-10 07:21:58.949: AudioController: playing sfx:p2.mp3
```
