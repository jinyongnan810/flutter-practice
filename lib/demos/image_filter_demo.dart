import 'dart:async';
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
  ui.Image? _image;
  static const imageUrl = 'https://i.imgur.com/PVxynOu.png';

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final completer = Completer<ui.Image>();
      final imageStream =
          const NetworkImage(imageUrl).resolve(ImageConfiguration.empty);

      imageStream.addListener(
        ImageStreamListener(
          (info, _) => completer.complete(info.image),
          onError: (error, _) => completer.completeError(error),
        ),
      );

      _image = await completer.future;
      setState(() {});
    } catch (e) {
      debugPrint('Error loading image: $e');
    }
  }

  void _updateInteraction(Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;
    final localPos = box.globalToLocal(globalPosition);

    setState(() {
      _position = Offset(
        (localPos.dx / box.size.width).clamp(0.0, 1.0),
        ((localPos.dy - InteractiveImagePainter.radius) / box.size.height)
            .clamp(0.0, 1.0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        clipBehavior: Clip.antiAlias,
        child: _image == null
            ? const CircularProgressIndicator()
            : GestureDetector(
                onPanStart: (d) => _updateInteraction(d.globalPosition),
                onPanUpdate: (d) => _updateInteraction(d.globalPosition),
                onTapDown: (d) => _updateInteraction(d.globalPosition),
                child: CustomPaint(
                  size: Size(
                    _image!.width.toDouble(),
                    _image!.height.toDouble(),
                  ),
                  painter: InteractiveImagePainter(
                    image: _image!,
                    position: _position,
                  ),
                ),
              ),
      ),
    );
  }
}

class InteractiveImagePainter extends CustomPainter {
  final ui.Image image;
  final Offset? position;
  static const radius = 120.0;

  const InteractiveImagePainter({required this.image, required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw original image
    canvas.drawImage(image, Offset.zero, Paint());

    // Start a new layer
    final rect = Offset.zero & size;
    canvas.saveLayer(rect, Paint());
    canvas.drawImage(
      image,
      Offset.zero,
      Paint()
        // Apply blur and greyscale effect
        ..imageFilter = ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20)
        ..colorFilter = const ColorFilter.matrix([
          0.2126, 0.7152, 0.0722, 0, 0, //
          0.2126, 0.7152, 0.0722, 0, 0, //
          0.2126, 0.7152, 0.0722, 0, 0, //
          0, 0, 0, 1, 0, //
        ]),
    );
    // Draw clear circle at interaction point
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
          )
          ..blendMode = BlendMode.dstIn,
      );
    }
    // End layer
    canvas.restore();
  }

  @override
  bool shouldRepaint(InteractiveImagePainter oldDelegate) =>
      image != oldDelegate.image || position != oldDelegate.position;
}
