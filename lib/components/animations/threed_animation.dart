import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ThreedAnimation extends HookWidget {
  const ThreedAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final Tween<double> animation = Tween<double>(begin: 0, end: pi * 2);
    final AnimationController xController =
        useAnimationController(duration: const Duration(seconds: 20));
    final AnimationController yController =
        useAnimationController(duration: const Duration(seconds: 30));
    final AnimationController zController =
        useAnimationController(duration: const Duration(seconds: 40));
    useEffect(
      () {
        xController.repeat();
        yController.repeat();
        zController.repeat();
        return null;
      },
      [],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth * 0.5;
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
        return Center(
          child: AnimatedBuilder(
            animation:
                Listenable.merge([xController, yController, zController]),
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                // bind one tween to multiple controllers
                transform: Matrix4.identity()
                  ..rotateX(animation.evaluate(xController))
                  ..rotateY(animation.evaluate(yController))
                  ..rotateZ(animation.evaluate(zController)),
                child: cubic,
              );
            },
          ),
        );
      },
    );
  }
}
