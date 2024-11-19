import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _navigationKey = GlobalKey<NavigatorState>();

class NestedNavDemo extends StatefulWidget implements DemoWidget {
  const NestedNavDemo({super.key});
  static const String _title = 'Nested Navigation demo';
  static const String _description = '';

  @override
  State<NestedNavDemo> createState() => _NestedNavDemoState();
  @override
  String get title => NestedNavDemo._title;

  @override
  String get description => NestedNavDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

class _NestedNavDemoState extends State<NestedNavDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop || !mounted) {
          return;
        }

        if (_navigationKey.currentState!.canPop()) {
          _navigationKey.currentState!.pop();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Navigator(
          key: _navigationKey,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            final page = switch (settings.name) {
              '/' => _HomePage(),
              '/child' => _ChildPage(data: settings.arguments as String),
              _ => throw StateError('Unexpected route name: ${settings.name}!')
            };
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => page,
              settings: settings,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final tween = Tween(begin: Offset(0, 1), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.ease));
                final offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Home'),
          TextButton(
            onPressed: () {
              Navigator.of(context) // equals _navigationKey.currentState
                  .pushNamed('/child', arguments: '**data from home page**');
            },
            child: Text('Go to child page'),
          ),
        ],
      ),
    );
  }
}

class _ChildPage extends StatelessWidget {
  const _ChildPage({required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Child Page: data received: $data'),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Return to home page'),
          ),
        ],
      ),
    );
  }
}
