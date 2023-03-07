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
    // TODO: implement paint
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
