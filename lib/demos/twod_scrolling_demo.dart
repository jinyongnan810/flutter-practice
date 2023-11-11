import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TwoDScrollingDemo extends StatefulWidget implements DemoWidget {
  const TwoDScrollingDemo({super.key});
  static const String _title = '2D scrolling Demo';
  static const String _description =
      'https://www.youtube.com/watch?v=ppEdTo-VGcg';

  @override
  State<TwoDScrollingDemo> createState() => _TwoDScrollingDemoState();
  @override
  String get title => TwoDScrollingDemo._title;

  @override
  String get description => TwoDScrollingDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.scroll);
}

class _TwoDScrollingDemoState extends State<TwoDScrollingDemo> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('2D scrolling demo'),
    );
  }
}


// class TwoDimensionalGridView extends TwoDimensionalScrollView {

// }