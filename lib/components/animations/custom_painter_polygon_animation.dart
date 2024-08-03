import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomPainterPolygonAnimation extends HookWidget {
  const CustomPainterPolygonAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimationController sidesController = useAnimationController(
      duration: const Duration(seconds: 3),
    );
    final int sidesAnimation = useAnimation(
      IntTween(begin: 3, end: 15).animate(
        CurvedAnimation(
          parent: sidesController,
          curve: Curves.linear,
        ),
      ),
    );
    final AnimationController scaleController = useAnimationController(
      duration: const Duration(seconds: 3),
    );
    final double scaleAnimation = useAnimation(
      Tween<double>(begin: 0.1, end: 1).animate(
        CurvedAnimation(
          parent: scaleController,
          curve: Curves.bounceInOut,
        ),
      ),
    );
    final AnimationController rotateController = useAnimationController(
      duration: const Duration(seconds: 3),
    );
    final double rotateAnimation = useAnimation(
      Tween<double>(begin: 0, end: pi * 2).animate(
        CurvedAnimation(
          parent: rotateController,
          curve: Curves.easeInOut,
        ),
      ),
    );
    useEffect(
      () {
        sidesController.repeat(reverse: true);
        scaleController.repeat(reverse: true);
        rotateController.repeat(reverse: true);
        return null;
      },
      [],
    );
    return LayoutBuilder(
      builder: (context, constraint) {
        final maxSize = min(constraint.maxWidth, constraint.maxHeight);
        return Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([sidesController]),
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(rotateAnimation)
                  ..rotateY(rotateAnimation)
                  ..rotateX(rotateAnimation),
                child: CustomPaint(
                  painter: _Polygon(sides: sidesAnimation),
                  child: SizedBox(
                    width: maxSize * scaleAnimation,
                    height: maxSize * scaleAnimation,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _Polygon extends CustomPainter {
  final int sides;
  _Polygon({required this.sides});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final angle = 2 * pi / sides;
    final angles = List.generate(sides, (index) => index * angle);
    final radius = size.width / 2;

    path.moveTo(center.dx + radius * cos(0), center.dy + radius * sin(0));
    for (final angle in angles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _Polygon && oldDelegate.sides != sides) {
      return true;
    }
    return false;
  }
}
