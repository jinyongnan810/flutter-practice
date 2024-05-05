import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const _borderRadius = 8.0;

class GradientDemo extends StatefulWidget implements DemoWidget {
  const GradientDemo({super.key});
  static const String _title = 'Gradient Demo';
  static const String _description =
      'Play with Linear, Radial and Sweep Gradients.';

  @override
  State<GradientDemo> createState() => _GradientDemoState();
  @override
  String get title => GradientDemo._title;

  @override
  String get description => GradientDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.paintbrush);
}

class _GradientDemoState extends State<GradientDemo>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );
  @override
  void initState() {
    super.initState();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const linearGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.red, Colors.blue],
    );
    final linearGradientBox = CustomPaint(
      painter: DynamicBoxPainter(
        gradient: linearGradient,
        animation: _controller,
      ),
      child: const Center(
        child: Text(
          'Linear Box',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
    // Container(
    //   decoration: const BoxDecoration(
    //     gradient: linearGradient,
    //     borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
    //   ),
    //   child: const Center(
    //     child: Text(
    //       'Linear Box',
    //       style: TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // );
    final linearGradientDynamicBorder = CustomPaint(
      painter: DynamicBorderPainter(
        gradient: linearGradient,
        animation: _controller,
      ),
      child: const Center(
        child: Text(
          'Linear Dynamic Border',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
    final linearGradientShootingStarBorder = CustomPaint(
      painter: DynamicShootingStarBorderPainter(
        gradient: linearGradient,
        animation: _controller,
      ),
      child: const Center(
        child: Text(
          'Linear Shooting Star Border',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );

    const radialGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.4,
      colors: [Colors.red, Colors.blue],
    );
    final radialGradientBox = CustomPaint(
      painter: DynamicBoxPainter(
        gradient: radialGradient,
        animation: _controller,
      ),
      child: const Center(
        child: Text(
          'Radial Box',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
    final radialGradientDynamicBorder = CustomPaint(
      painter: DynamicBorderPainter(
        gradient: radialGradient,
        animation: _controller,
      ),
      child: const Center(
        child: Text(
          'Radial Dynamic Border',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
    final radialGradientShootingStarBorder = CustomPaint(
      painter: DynamicShootingStarBorderPainter(
        gradient: radialGradient,
        animation: _controller,
      ),
      child: const Center(
        child: Text(
          'Radial Shooting Star Border',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );

    const sweepGradient = SweepGradient(
      colors: [Colors.red, Colors.blue],
    );

    final sweepGradientBox = CustomPaint(
      painter: DynamicBoxPainter(
        gradient: sweepGradient,
        animation: _controller,
      ),
      child: const Center(
        child: Text(
          'Sweep Box',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
    final sweepGradientDynamicBorder = CustomPaint(
      painter: DynamicBorderPainter(
        gradient: sweepGradient,
        animation: _controller,
      ),
      child: const Center(
        child: Text(
          'Sweep Dynamic Border',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
    final sweepGradientShootingStarBorder = CustomPaint(
      painter: DynamicShootingStarBorderPainter(
        gradient: sweepGradient,
        animation: _controller,
      ),
      child: const Center(
        child: Text(
          'Sweep Shooting Star Border',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );

    final content = Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.count(
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        crossAxisCount: 3,
        children: [
          linearGradientBox,
          linearGradientDynamicBorder,
          linearGradientShootingStarBorder,
          radialGradientBox,
          radialGradientDynamicBorder,
          radialGradientShootingStarBorder,
          sweepGradientBox,
          sweepGradientDynamicBorder,
          sweepGradientShootingStarBorder,
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: content,
    );
  }
}

class DynamicBoxPainter extends CustomPainter {
  final Gradient gradient;
  final Animation<double> animation;
  DynamicBoxPainter({required this.gradient, required this.animation})
      : super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()..color = Colors.black;

    paint.shader = switch (gradient) {
      LinearGradient g => LinearGradient(
          begin: g.begin,
          end: g.end,
          colors: g.colors,
          transform: GradientRotation(
            (pi * 2 * animation.value),
          ),
        ).createShader(rect),
      RadialGradient g => RadialGradient(
          center: g.center,
          radius: g.radius + 0.5 * animation.value,
          colors: g.colors,
        ).createShader(rect),
      SweepGradient g => SweepGradient(
          colors: g.colors,
          transform: GradientRotation(
            (pi * 2 * animation.value),
          ),
        ).createShader(rect),
      _ => throw UnimplementedError(),
    };

    var rRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(_borderRadius),
    );

    canvas.drawRRect(
      rRect,
      paint
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BorderPainter extends CustomPainter {
  final strokeWidth = 4.0;
  final Gradient gradient;
  BorderPainter({super.repaint, required this.gradient});
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(strokeWidth / 2, strokeWidth / 2) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    final paint = Paint()..color = Colors.black;
    paint.shader = gradient.createShader(rect);

    var rRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(_borderRadius),
    );

    canvas.drawRRect(
      rRect,
      paint
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DynamicBorderPainter extends CustomPainter {
  final strokeWidth = 4.0;
  final Gradient gradient;
  final Animation<double> animation;
  DynamicBorderPainter({required this.gradient, required this.animation})
      : super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(strokeWidth / 2, strokeWidth / 2) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    final paint = Paint()..color = Colors.black;

    paint.shader = switch (gradient) {
      LinearGradient g => LinearGradient(
          begin: g.begin,
          end: g.end,
          colors: g.colors,
          transform: GradientRotation(
            (pi * 2 * animation.value),
          ),
        ).createShader(rect),
      RadialGradient g => RadialGradient(
          center: g.center,
          radius: g.radius + 0.5 * animation.value,
          colors: g.colors,
        ).createShader(rect),
      SweepGradient g => SweepGradient(
          colors: g.colors,
          transform: GradientRotation(
            (pi * 2 * animation.value),
          ),
        ).createShader(rect),
      _ => throw UnimplementedError(),
    };

    var rRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(_borderRadius),
    );

    canvas.drawRRect(
      rRect,
      paint
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DynamicShootingStarBorderPainter extends CustomPainter {
  final strokeWidth = 4.0;
  final Gradient gradient;
  final Animation<double> animation;
  DynamicShootingStarBorderPainter({
    required this.gradient,
    required this.animation,
  }) : super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(strokeWidth / 2, strokeWidth / 2) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    final paint = Paint()..color = Colors.transparent;
    paint.color = Colors.black;
    paint.shader = switch (gradient) {
      LinearGradient g => LinearGradient(
          begin: g.begin,
          end: g.end,
          // TODO: support more than 2 colors
          colors: [Colors.transparent, ...g.colors, Colors.transparent],
          transform: GradientRotation(
            (pi * 2 * animation.value),
          ),
          stops: const [0.0, 0.5, 1, 1.0],
        ).createShader(rect),
      RadialGradient g => RadialGradient(
          center: g.center,
          radius: g.radius + 0.5 * animation.value,
          colors: [Colors.transparent, ...g.colors, Colors.transparent],
          stops: const [0.0, 0.5, 1, 1.0],
        ).createShader(rect),
      SweepGradient g => SweepGradient(
          colors: [Colors.transparent, ...g.colors, Colors.transparent],
          transform: GradientRotation(
            (pi * 2 * animation.value),
          ),
          stops: const [0.0, 0.5, 1, 1.0],
        ).createShader(rect),
      _ => throw UnimplementedError(),
    };

    var rRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(_borderRadius),
    );

    canvas.drawRRect(
      rRect,
      paint
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
    final path = Path()..addRRect(rRect);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
