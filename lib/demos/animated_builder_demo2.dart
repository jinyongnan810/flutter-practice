import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';

class AnimatedBuilderDemo2 extends StatefulWidget implements DemoWidget {
  const AnimatedBuilderDemo2({super.key});
  static const String _title = 'Animation Demo2';
  static const String _description = 'Flipping rectangle animation';

  @override
  State<AnimatedBuilderDemo2> createState() => _AnimatedBuilderDemo2State();
  @override
  String get title => AnimatedBuilderDemo2._title;

  @override
  String get description => AnimatedBuilderDemo2._description;

  @override
  Widget get icon => const Icon(Icons.rectangle_outlined);
}

class _AnimatedBuilderDemo2State extends State<AnimatedBuilderDemo2>
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
    final content = Center(
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
                    offset: const Offset(0, 0),
                  ),
                ],
                color: Colors.blue,
              ),
              width: 100,
              height: 100,
            ),
          );
        },
      ),
    );

    return SafeArea(
      child: Scaffold(appBar: AppBar(title: Text(widget.title)), body: content),
    );
  }
}
