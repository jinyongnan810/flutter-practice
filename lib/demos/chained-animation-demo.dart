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
  late final AnimationController _counterClockWiseController;
  late final Animation<double> _counterClockWiseAnimation;
  late final AnimationController _flipController;
  late final Animation<double> _flipAnimation;
  @override
  void initState() {
    super.initState();
    _counterClockWiseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _counterClockWiseAnimation =
        Tween<double>(begin: 0, end: -pi / 2).animate(CurvedAnimation(
      parent: _counterClockWiseController,
      curve: Curves.bounceOut,
    ));
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(CurvedAnimation(
      parent: _flipController,
      curve: Curves.bounceOut,
    ));
    _counterClockWiseAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value, end: _flipAnimation.value + pi)
            .animate(CurvedAnimation(
          parent: _flipController,
          curve: Curves.bounceOut,
        ));
        _flipController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    _counterClockWiseController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final circle = Row(
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
    );
    return Center(
        child: AnimatedBuilder(
      animation: _counterClockWiseController,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(_counterClockWiseAnimation.value),
          child: circle,
        );
      },
    ));
  }
}
