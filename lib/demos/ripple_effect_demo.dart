import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RippleEffectDemo extends StatefulWidget implements DemoWidget {
  const RippleEffectDemo({super.key});
  static const String _title = 'Ripple event demo';
  static const String _description =
      'original code by Mr.Raouf Rahiche from: https://github.com/Rahiche/image_filters';

  @override
  State<RippleEffectDemo> createState() => _RippleEffectDemoState();
  @override
  String get title => RippleEffectDemo._title;

  @override
  String get description => RippleEffectDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

class _RippleEffectDemoState extends State<RippleEffectDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  );
  Offset _pointer = Offset.zero;

  void _updatePointer(Offset pos) {
    if (!_controller.isAnimating) {
      _controller.reset();
      _controller.forward();
    }
    setState(() {
      _pointer = pos;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: GestureDetector(
          onTapDown: (details) {
            _controller.reset();
            _controller.forward();

            setState(() {
              _pointer = details.localPosition;
            });
          },
          onPanStart: (details) {
            _updatePointer(details.localPosition);
          },
          onPanUpdate: (details) {
            _updatePointer(details.localPosition);
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderBuilder(
                (context, shader, _) {
                  return AnimatedSampler(
                    (image, size, canvas) {
                      ShaderHelper.configureShader(
                        shader,
                        size,
                        image,
                        time: _controller.value * 5.0,
                        pointer: _pointer,
                      );
                      ShaderHelper.drawShaderRect(shader, size, canvas);
                    },
                    child: child!,
                  );
                },
                assetKey: "shaders/ripple.frag",
              );
            },
            child: Image.asset('assets/images/working-out.jpg'),
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: content,
    );
  }
}

class ShaderHelper {
  static void configureShader(
    ui.FragmentShader shader,
    ui.Size size,
    ui.Image image, {
    required double time,
    required Offset pointer,
  }) {
    shader
      ..setFloat(0, size.width) // iResolution
      ..setFloat(1, size.height) // iResolution
      ..setFloat(2, pointer.dx) // iMouse
      ..setFloat(3, pointer.dy) // iMouse
      ..setFloat(4, time) // iTime
      ..setImageSampler(0, image); // image
  }

  static void drawShaderRect(
    ui.FragmentShader shader,
    ui.Size size,
    ui.Canvas canvas,
  ) {
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height,
      ),
      Paint()..shader = shader,
    );
  }
}
