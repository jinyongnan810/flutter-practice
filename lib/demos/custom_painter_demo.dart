import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPainterDemo extends StatefulWidget implements DemoWidget {
  const CustomPainterDemo({super.key});
  static const String _title = 'CustomPainter Animation Demo';
  static const String _description =
      'Using CustomPainter to create dynamic polygon animations';

  @override
  State<CustomPainterDemo> createState() => _CustomPainterDemoState();
  @override
  String get title => CustomPainterDemo._title;

  @override
  String get description => CustomPainterDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.drawPolygon);
}

class Polygon extends CustomPainter {
  final int sides;
  Polygon({required this.sides});
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
    if (oldDelegate is Polygon && oldDelegate.sides != sides) {
      return true;
    }
    return false;
  }
}

class _CustomPainterDemoState extends State<CustomPainterDemo>
    with TickerProviderStateMixin {
  late AnimationController _sidesController;
  late Animation<int> _sidesAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _rotateController;
  late Animation<double> _rotateAnimation;
  @override
  void initState() {
    _sidesController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _sidesAnimation = IntTween(begin: 3, end: 15).animate(
      CurvedAnimation(
        parent: _sidesController,
        curve: Curves.linear,
      ),
    );
    _scaleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _scaleAnimation = Tween<double>(begin: 0.1, end: 1).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.bounceInOut,
      ),
    );
    _rotateController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _rotateAnimation = Tween<double>(begin: 0, end: pi * 2).animate(
      CurvedAnimation(
        parent: _rotateController,
        curve: Curves.easeInOut,
      ),
    );
    _sidesController.repeat(reverse: true);
    _scaleController.repeat(reverse: true);
    _rotateController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _sidesController.dispose();
    _scaleController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final maxSize = min(constraint.maxWidth, constraint.maxHeight);
        return Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([_sidesAnimation]),
            builder: (context, child) {
              return
                  // Transform.scale(
                  //   scale: _scaleAnimation.value,
                  //   child:
                  Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(_rotateAnimation.value)
                  ..rotateY(_rotateAnimation.value)
                  ..rotateX(_rotateAnimation.value),
                child: CustomPaint(
                  painter: Polygon(sides: _sidesAnimation.value),
                  child: SizedBox(
                    width: maxSize * _scaleAnimation.value,
                    height: maxSize * _scaleAnimation.value,
                  ),
                  // ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
