import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TweenAnimationDemo extends StatefulWidget implements DemoWidget {
  const TweenAnimationDemo({super.key});
  static const String _title = 'Tween Animation Demo';
  static const String _description = 'Changing color';

  @override
  State<TweenAnimationDemo> createState() => _TweenAnimationDemoState();
  @override
  String get title => TweenAnimationDemo._title;

  @override
  String get description => TweenAnimationDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.circle);
}

Color getRandomColor() => Color(0xff000000 + Random().nextInt(0x00ffffff));

class _TweenAnimationDemoState extends State<TweenAnimationDemo> {
  Color color = getRandomColor();

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
    final content = Center(
      // child: Container(
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(100), color: Colors.amber),
      //   width: 200,
      //   height: 200,
      // ),
      child: ClipPath(
        clipper: const CircleClipper(),
        child: TweenAnimationBuilder(
          tween: ColorTween(begin: getRandomColor(), end: color),
          duration: const Duration(seconds: 1),
          onEnd: () {
            setState(() {
              color = getRandomColor();
            });
          },
          builder: (context, Color? color, child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
              child: child,
            );
          },
          child: Container(
            width: 200,
            height: 200,
            color: Colors.amber,
          ),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: content,
      ),
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
