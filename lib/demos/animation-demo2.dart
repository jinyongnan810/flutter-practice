import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo-widget.dart';

class AnimationDemo2 extends StatefulWidget implements DemoWidget {
  const AnimationDemo2({Key? key}) : super(key: key);
  static const String _title = 'Animation Demo2';
  static const String _description = 'Flipping rectangle animation';

  @override
  State<AnimationDemo2> createState() => _AnimationDemo2State();
  @override
  String get title => AnimationDemo2._title;

  @override
  String get description => AnimationDemo2._description;

  @override
  Icon get icon => const Icon(Icons.rectangle_outlined);
}

class _AnimationDemo2State extends State<AnimationDemo2>
    with TickerProviderStateMixin {
  late final AnimationController _flippingAnimationController;
  late final Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _flippingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: pi * 2)
        .animate(_flippingAnimationController);
    _flippingAnimationController.repeat();
  }

  @override
  void dispose() {
    _flippingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _flippingAnimationController,
        builder: (ctx, _) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateY(_animation.value),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 0))
                  ],
                  color: Colors.blue),
              width: 100,
              height: 100,
            ),
          );
        },
      ),
    );
  }
}
