import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// cspell: disable
// original code by Raouf Rahiche  form: https://github.com/Rahiche/image_filters/blob/main/lib/live_coding/selective_focus.dart

class ImageFilterDemo extends StatefulWidget implements DemoWidget {
  const ImageFilterDemo({super.key});
  static const String _title = 'Image Filter Demo';
  static const String _description = '';

  @override
  State<ImageFilterDemo> createState() => _ImageFilterDemoState();
  @override
  String get title => ImageFilterDemo._title;

  @override
  String get description => ImageFilterDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

class _ImageFilterDemoState extends State<ImageFilterDemo> {
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: InteractiveImagePage(),
    );
  }
}

class InteractiveImagePage extends StatefulWidget {
  const InteractiveImagePage({super.key});

  @override
  State<InteractiveImagePage> createState() => _InteractiveImagePageState();
}

class _InteractiveImagePageState extends State<InteractiveImagePage> {
  Offset? _position;

  @override
  void initState() {
    super.initState();
  }

  void _updateInteraction(Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;
    final localPos = box.globalToLocal(globalPosition);

    setState(() {
      _position = Offset(
        (localPos.dx / box.size.width).clamp(0.0, 1.0),
        (localPos.dy / box.size.height).clamp(0.0, 1.0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/working-out.jpg',
            fit: BoxFit.fitHeight,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text('Some Text'),
        ),
      ],
    );
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          constraints: BoxConstraints(maxWidth: 400),
          clipBehavior: Clip.antiAlias,
          child: GestureDetector(
            // onPanStart: (d) => _updateInteraction(d.globalPosition),
            onPanUpdate: (d) => _updateInteraction(d.globalPosition),
            // onTapDown: (d) => _updateInteraction(d.globalPosition),
            child: Stack(
              children: [
                content,
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.compose(
                      outer: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      inner: ui.ColorFilter.matrix([
                        0.2126, 0.7152, 0.0722, 0, 0, //
                        0.2126, 0.7152, 0.0722, 0, 0, //
                        0.2126, 0.7152, 0.0722, 0, 0, //
                        0, 0, 0, 1, 0, //
                      ]),
                    ),
                    child: CustomPaint(
                      painter: InteractiveImagePainter(position: _position),
                      // ColoredBox(color: Colors.black.withOpacity(0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InteractiveImagePainter extends CustomPainter {
  final Offset? position;
  static const radius = 120.0;

  const InteractiveImagePainter({required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    if (position != null) {
      canvas.drawCircle(
        Offset(position!.dx * size.width, position!.dy * size.height),
        radius,
        Paint()
          ..shader = ui.Gradient.radial(
            Offset(
              position!.dx * size.width,
              position!.dy * size.height,
            ),
            radius,
            [Colors.transparent, Colors.blue],
            // [0.8, 1],
          )
          ..blendMode = BlendMode.dstIn,
      );
    }
  }

  @override
  bool shouldRepaint(InteractiveImagePainter oldDelegate) =>
      position != oldDelegate.position;
}
