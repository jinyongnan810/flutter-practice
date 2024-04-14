import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ThreeDAnimationDemo extends StatefulWidget implements DemoWidget {
  const ThreeDAnimationDemo({super.key});
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
    final cubic = Stack(
      children: [
        // back
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..translate(Vector3(0, 0, -size)),
          child: Container(
            color: Colors.green,
            width: size,
            height: size,
          ),
        ),
        // left
        Transform(
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()..rotateY(pi / 2),
          child: Container(
            color: Colors.blue,
            width: size,
            height: size,
          ),
        ),
        // right
        Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()..rotateY(-pi / 2),
          child: Container(
            color: Colors.purple,
            width: size,
            height: size,
          ),
        ),
        // top
        Transform(
          alignment: Alignment.topCenter,
          transform: Matrix4.identity()..rotateX(-pi / 2),
          child: Container(
            color: Colors.red,
            width: size,
            height: size,
          ),
        ),
        // bottom
        Transform(
          alignment: Alignment.bottomCenter,
          transform: Matrix4.identity()..rotateX(pi / 2),
          child: Container(
            color: Colors.brown,
            width: size,
            height: size,
          ),
        ),
        // front
        Container(
          color: Colors.amber,
          width: size,
          height: size,
        ),
      ],
    );
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();
    final content = Center(
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
            child: cubic,
          );
        },
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: content,
      ),
    );
  }
}
