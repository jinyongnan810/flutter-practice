import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo-widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThreeDAnimationDemo extends StatefulWidget implements DemoWidget {
  const ThreeDAnimationDemo({Key? key}) : super(key: key);
  static const String _title = '3d Animation Demo';
  static const String _description = '3d cube rotating';

  @override
  State<ThreeDAnimationDemo> createState() => _ThreeDAnimationDemoState();
  @override
  String get title => ThreeDAnimationDemo._title;

  @override
  String get description => ThreeDAnimationDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.cube);
}

class _ThreeDAnimationDemoState extends State<ThreeDAnimationDemo>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: -pi / 2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          // rotate with z axis also rotates the canvas, so the y axis also rotates
          transform: Matrix4.identity()..rotateZ(_animation.value),
        );
      },
    ));
  }
}
