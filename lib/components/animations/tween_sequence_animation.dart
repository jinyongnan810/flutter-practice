import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TweenSequenceAnimationExample extends HookWidget {
  TweenSequenceAnimationExample({super.key});

  final _scaleTweenSequence = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 3),
    TweenSequenceItem(tween: Tween(begin: 1.5, end: 0.6), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 0.6, end: 1.0), weight: 1),
  ]);

  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(seconds: 1));
    final scaleAnimatioin =
        useAnimation(_scaleTweenSequence.animate(controller));

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            controller.reset();
            controller.forward();
          },
          child: Center(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: scaleAnimatioin,
                  child: child,
                );
              },
              child: Container(
                width: constraints.maxWidth * 0.5,
                height: constraints.maxWidth * 0.5,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text("Tap me"),
              ),
            ),
          ),
        );
      },
    );
  }
}
