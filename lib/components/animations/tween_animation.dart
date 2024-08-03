import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TweenAnimation extends HookWidget {
  const TweenAnimation({super.key});
  Color getRandomColor() => Color(0xff000000 + Random().nextInt(0x00ffffff));

  @override
  Widget build(BuildContext context) {
    final color = useState(getRandomColor());
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ClipPath(
            clipper: const CircleClipper(),
            child: TweenAnimationBuilder(
              tween: ColorTween(begin: getRandomColor(), end: color.value),
              duration: const Duration(seconds: 1),
              onEnd: () {
                color.value = getRandomColor();
              },
              builder: (context, Color? color, child) {
                return ColorFiltered(
                  colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                  child: child,
                );
              },
              child: Container(
                width: constraints.maxWidth * 0.8,
                height: constraints.maxWidth * 0.8,
                color: Colors.amber,
              ),
            ),
          ),
        );
      },
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
