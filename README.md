[Ref Repo](https://github.com/jinyongnan810/flutter-samples-study)
[Practice Repo](https://github.com/jinyongnan810/flutter-practice)

# Purpose

- Learn the basics
- Learn how to build ui
- Learn how other peaple code

# Practices

## Text Overflow

![image](https://firebasestorage.googleapis.com/v0/b/mymemo-98f76.appspot.com/o/uploads%2FSIvHI3wJfEPSACxfj6WH1l53vZx1%2F566043fc-89db-4208-9ae5-179585b0b315.png?alt=media&token=c0be7047-cc9c-40e5-8c97-a0dd6b302197)

```dart
// show ... when run out space
Text(title, overflow: TextOverflow.ellipsis,);
```

## DataTable

![image](https://firebasestorage.googleapis.com/v0/b/mymemo-98f76.appspot.com/o/uploads%2FSIvHI3wJfEPSACxfj6WH1l53vZx1%2Fc4619a76-7d36-4866-bbef-470f89d34a8a.gif?alt=media&token=a51c9651-f52b-4707-809c-0f78f5bba9f2)

```dart
    // controll selected status
    final seletectedSong = ref.watch(selectedSongProvider);
    return DataTable(
        // not to show the checkbox
        showCheckboxColumn: false,
        // set columns
        columns: const [
          DataColumn(label: Text('Title')),
          DataColumn(label: Text('Artist')),
          DataColumn(label: Text('Album')),
          DataColumn(label: Icon(Icons.access_time)),
        ],
        // set data rows
        rows: tracks.map((e) {
          final selected = seletectedSong?.id == e.id;
          final textStyle = TextStyle(
              color: selected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).iconTheme.color);
          return DataRow(
              key: ValueKey(e.id),
              // a row is only selectable when these two are set
              selected: selected,
              onSelectChanged: (selected) {
                if (selected == true) {
                  final notifier = ref.read(selectedSongProvider.notifier);
                  notifier.state = e;
                }
              },
              cells: [
                DataCell(Text(
                  e.title,
                  style: textStyle,
                )),
                DataCell(Text(
                  e.artist,
                  style: textStyle,
                )),
                DataCell(Text(
                  e.album,
                  style: textStyle,
                )),
                DataCell(Text(
                  e.duration,
                  style: textStyle,
                )),
              ]);
        }).toList());
```

## MiniPlayer

- https://pub.dev/packages/miniplayer

![image](https://firebasestorage.googleapis.com/v0/b/mymemo-98f76.appspot.com/o/uploads%2FSIvHI3wJfEPSACxfj6WH1l53vZx1%2Fd30c8626-3388-456d-a53d-6eb6e724d9c1.gif?alt=media&token=0e54b6bb-8b72-4231-b0c3-3bada85f5ad2)

```dart
// 1. attach Miniplayer (wrapped with OffStage) to the stack
Miniplayer(
      controller: miniplayerController,
      minHeight: _playerMinHeight, // about 60
      maxHeight: MediaQuery.of(context).size.height,
      builder: (height, percentage) {
         if (selectedVideo == null) {
             return const SizedBox.shrink(); // disappears
         }
         if (height > _playerMinHeight + 50) { // display full screen
              return const VideoScreen();
         }

         return const SmallVideoScreen(); // display mini screen
      }
)
// 2. add close button to the mini screen
// 3. add downward arrow button to the full screen
IconButton(
      onPressed: () {
          miniplayerController.animateToHeight(
               state: PanelState.MIN);
      },
      icon: const Icon(Icons.keyboard_arrow_down)
)
// 4. wrap the full screen with GestureDetector to prevent minify on tap

```

## Offstage

- Change Tabs without re-rendering

```dart
Stack(children: _screens.asMap()
     .map((index, screen) => MapEntry(
         index,
         Offstage(
            offstage: index != _currentIndex,
            child: screen,
         )))
         .values
         .toList()
```

## Riverpod

### [Riverpod](https://pub.dev/packages/flutter_riverpod)

```dart
// 1. wrap root app with ProviderScope
runApp(const ProviderScope(child: MyApp()));
// 2. create a provider
final audioControllerProvider = StateProvider.autoDispose<AudioController>(
  (ref) => AudioController()..initialize(),
);
// 3. convert Widget to ConsumerWidget
class PlaySoundDemo extends ConsumerStatefulWidget implements DemoWidget {
  ...
  @override
  ConsumerState<PlaySoundDemo> createState() => _PlaySoundDemoState();
  ...
}
class _PlaySoundDemoState extends ConsumerState<PlaySoundDemo> {
  ...
}
// 4. get the state
Widget build(BuildContext context) {
   final audioController = ref.watch(audioControllerProvider);
   ...
}
```

## Using l10n

### [Official Doc](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)

### [Basic Installment](https://github.com/jinyongnan810/mymemo-with-flutterfire/compare/d8b7e15285e4e251f39441307761153dbf6ef1aa...bd8c0e37ce5aec54c5105fa61ee2266837a38696)

### Using locale

```dart
// 1. define in each arbs
"loggedInHint": "{email}でログインしています。",
"@loggedInHint": {
        "placeholders": {
            "email": {
                "type": "String"
            }
        }
    }
// 2. generate code
flutter gen-l10n
// 3. use
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
K.of(context)!.loggedInHint(auth.myProfile.email)

```

## Using Freezed

### [freezed](https://pub.dev/packages/freezed)

- install

```bash
flutter pub add freezed_annotation
flutter pub add --dev build_runner
flutter pub add --dev freezed
flutter pub add json_annotation
flutter pub add --dev json_serializable
```

- create model

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    required String phone,
  }) = _User;
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
```

- generate code

```bash
flutter pub run build_runner build
# or
flutter pub run build_runner watch
```

- basic usages

```dart
const user = User(
      id: 'abc', name: 'name123', email: 'email@email.com', phone: '123-4456');
  print(user);
  print(user.toJson());
  print(user.copyWith(name: 'new name', email: 'new email'));
```

- sample of parsing nested json
  - [sample](https://github.com/jinyongnan810/flutter-practice/commit/4a91a303a48230dd6db4ae5eff347c5d07b84bee)

## Creating a search bar

```dart
// 1. create a search button(in app bar)
IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: MemoListSearchDelegate());
                  },
                  icon: const Icon(Icons.search))
// 2. create a search delegate
class MemoListSearchDelegate extends SearchDelegate {
  // create action button(like in app bar)
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.close))
    ];
  }
  // create a leading(like in app bar)
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }
  // do search when return pressed
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: Memos.queryItems(query),
        builder: (ctx, AsyncSnapshot<List<Memo>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('error:${snapshot.error}'),
              );
            }
            List<Memo> data = snapshot.data!;
            if (data.isEmpty) {
              return const Center(
                child: Text('No memo found'),
              );
            }

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].title),
                    onTap: () {
                      GoRouter.of(context).go('/memos/${data[index].id}');
                      close(context, null);
                    },
                  );
                });
          }
        });
  }
  // build some suggestions
  @override
  Widget buildSuggestions(BuildContext context) {
    // not necessary
    // bu we can build a ListView that contains some options
    // when option is clicked, run showResults() to go to result
    return Container();
  }
}
```

## Using go-router

```dart
// 1. create a nested router
static final _router = GoRouter(routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const MemoListPage(),
        routes: [
          GoRoute(
              path: 'memos/:id',
              builder: (context, state) {
                final id = state.params['id']!;
                return MemoDetailPage(id: id);
              })
        ])
  ]);
// 2. create MeterialApp with .router, and set the routes
MaterialApp.router(
          title: "Kin's Page",
          scaffoldMessengerKey: scaffoldMessengerKey,
          theme: ThemeData.dark(),
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          debugShowCheckedModeBanner: false,
          // after changing to .router, need change navigatorKey to scaffoldMessengerKey
          // navigatorKey: NavigationService.navigatorKey,
        ));
// 3.go to pages
 GoRouter.of(context).go('/memos/${memo.id}')
```

## Display snackbar anywhere

```dart
// 1st method: using NavigatorKey (works with normal MaterialApp)
static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
ScaffoldMessenger.of(
                      NavigationService.navigatorKey.currentContext!)
                  .showSnackBar(const SnackBar(
                content: Text('Code copied.'),
                duration: Duration(seconds: 5),
              ));
// in the main.dart
navigatorKey: NavigationService.navigatorKey


// 2nd method: using ScaffoldMessengerKey (works with MaterialApp.router)
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey(debugLabel: 'scaffoldMessengerKey');
void showSnackBar(String message) {
  final messenger = scaffoldMessengerKey.currentState;
  messenger?.showSnackBar(
    SnackBar(content: Text(message)),
  );
}
// in the main.dart
scaffoldMessengerKey: scaffoldMessengerKey
```

## Simple loading widget

```dart
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(
          color: Colors.white,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Loading',
          style: TextStyle(fontSize: 26),
        )
      ],
    ));
  }
}

```

## Logging

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

## Play audio

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

## 2 ways of building routes

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

## Restrict widgets to has certain fields

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

## SafeArea

- Wrap widgets with SafeArea will automatically add paddings to avoid platform-specific ui clash
