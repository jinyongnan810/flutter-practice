import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo-widget.dart';

class ChainedAnimationDemo extends StatefulWidget implements DemoWidget {
  const ChainedAnimationDemo({Key? key}) : super(key: key);
  static const String _title = 'Chained Animation Demo';
  static const String _description = '2 step animation';

  @override
  State<ChainedAnimationDemo> createState() => _ChainedAnimationDemoState();
  @override
  String get title => ChainedAnimationDemo._title;

  @override
  String get description => ChainedAnimationDemo._description;

  @override
  Icon get icon => const Icon(Icons.circle_outlined);
}

enum CircleSide { left, right }

extension CirclePath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;
    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        path.moveTo(0, 0);
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );
    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;
  HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) {
    return side.toPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _ChainedAnimationDemoState extends State<ChainedAnimationDemo>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: pi * 2).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipPath(
          clipper: HalfCircleClipper(side: CircleSide.left),
          child: Container(
            color: Colors.blue,
            width: 200,
            height: 200,
          ),
        ),
        ClipPath(
          clipper: HalfCircleClipper(side: CircleSide.right),
          child: Container(
            color: Colors.amber,
            width: 200,
            height: 200,
          ),
        ),
      ],
    ));
  }
}
