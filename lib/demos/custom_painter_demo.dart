import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPainterDemo extends StatefulWidget implements DemoWidget {
  const CustomPainterDemo({Key? key}) : super(key: key);
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

class _CustomPainterDemoState extends State<CustomPainterDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final maxSize = min(constraint.maxWidth, constraint.maxHeight);
        return Center(
          child: CustomPaint(
            painter: Polygon(sides: 3),
            child: SizedBox(
              width: maxSize,
              height: maxSize,
            ),
          ),
        );
      },
    );
  }
}
