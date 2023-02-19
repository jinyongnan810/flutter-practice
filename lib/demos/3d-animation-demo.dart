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
  late final AnimationController _xController;
  late final AnimationController _yController;
  late final AnimationController _zController;
  late Tween<double> _animation;
  static const double size = 200;
  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );
    _animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();
    return Center(
        child: AnimatedBuilder(
      animation: Listenable.merge([_xController, _yController, _zController]),
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          // bind one tween to multiple controllers
          transform: Matrix4.identity()
            ..rotateX(_animation.evaluate(_xController))
            ..rotateY(_animation.evaluate(_yController))
            ..rotateZ(_animation.evaluate(_zController)),
          child: Stack(children: [
            Container(
              color: Colors.amber,
              width: size,
              height: size,
            )
          ]),
        );
      },
    ));
  }
}
