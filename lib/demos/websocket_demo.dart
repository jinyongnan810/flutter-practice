import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TweenAnimationDemo extends StatefulWidget implements DemoWidget {
  const TweenAnimationDemo({Key? key}) : super(key: key);
  static const String _title = 'WebSocket Demo';
  static const String _description =
      'https://docs.flutter.dev/cookbook/networking/web-sockets';

  @override
  State<TweenAnimationDemo> createState() => _TweenAnimationDemoState();
  @override
  String get title => TweenAnimationDemo._title;

  @override
  String get description => TweenAnimationDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.internetExplorer);
}

class _TweenAnimationDemoState extends State<TweenAnimationDemo> {
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
    return const Text('hello');
  }
}
