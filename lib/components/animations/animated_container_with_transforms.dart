import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const ballSize = 100.0;

class AnimatedContainerWithTransforms extends HookWidget {
  const AnimatedContainerWithTransforms({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 4000),
      reverseDuration: const Duration(milliseconds: 4000),
    );
    useEffect(
      () {
        controller.repeat(reverse: true);
        return null;
      },
      [],
    );
    final ball = Container(
      width: ballSize,
      height: ballSize,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraint) {
          final width = constraint.maxWidth;
          final height = constraint.maxHeight;
          return _AnimatedWidget(
            controller: controller,
            from: Offset(-width / 2, -height / 2),
            to: Offset(width / 2 - ballSize / 2, height / 2 - ballSize / 2),
            forwardingCurve: Curves.easeInToLinear,
            reversingCurve: Curves.linearToEaseOut,
            child: ball,
          );
        },
      ),
    );
  }
}

class _AnimatedWidget extends StatelessWidget {
  const _AnimatedWidget({
    required this.controller,
    required this.from,
    required this.to,
    required this.forwardingCurve,
    required this.reversingCurve,
    required this.child,
  });

  final AnimationController controller;
  final Offset from;
  final Offset to;
  final Curve forwardingCurve;
  final Curve reversingCurve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      // https://api.flutter.dev/flutter/animation/Curves-class.html
      curve: forwardingCurve,
      reverseCurve: reversingCurve,
    );
    final flippingAnimation =
        Tween<double>(begin: 0, end: pi * 2 * 5).animate(controller);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            lerpDouble(
              from.dx,
              to.dx,
              animation.value,
            )!,
            lerpDouble(
              from.dy,
              to.dy,
              animation.value,
            )!,
          ),
          child: Transform.scale(
            scale: clampDouble(animation.value, 0, 1),
            child: Opacity(
              opacity: clampDouble(animation.value, 0, 1),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(flippingAnimation.value),
                child: child,
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}
