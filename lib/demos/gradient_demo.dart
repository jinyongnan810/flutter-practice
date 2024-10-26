import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

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

final _initialMeshGradientPoints = [
  MeshGradientPoint(
    position: const Offset(
      0.2,
      0.6,
    ),
    color: Colors.red,
  ),
  MeshGradientPoint(
    position: const Offset(
      0.4,
      0.5,
    ),
    color: Colors.purple,
  ),
  MeshGradientPoint(
    position: const Offset(
      0.7,
      0.4,
    ),
    color: Colors.green,
  ),
  MeshGradientPoint(
    position: const Offset(
      0.4,
      0.9,
    ),
    color: Colors.yellow,
  ),
];

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
    final meshGradient = ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: MeshGradient(
        points: _initialMeshGradientPoints,
        options: MeshGradientOptions(),
        child: const Center(
          child: Text('MeshGradient', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
    const meshGradientWithAnimation = _MeshGradientWithAnimation();
    const meshGradientWithRepeatedAnimation =
        _MeshGradientWithRepeatedAnimation();

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
          meshGradient,
          meshGradientWithAnimation,
          meshGradientWithRepeatedAnimation,
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

class _MeshGradientWithAnimation extends StatefulWidget {
  const _MeshGradientWithAnimation();

  @override
  State<_MeshGradientWithAnimation> createState() =>
      __MeshGradientWithAnimationState();
}

class __MeshGradientWithAnimationState extends State<_MeshGradientWithAnimation>
    with TickerProviderStateMixin {
  late final _meshGradientController =
      MeshGradientController(points: _initialMeshGradientPoints, vsync: this);
  late final Timer _repeatTimer;
  Future<void> _animate() async {
    await _meshGradientController.animateSequence(
      duration: const Duration(seconds: 4),
      sequences: [
        AnimationSequence(
          pointIndex: 0,
          newPoint: MeshGradientPoint(
            position: const Offset(0.9, 0.9),
            color: _initialMeshGradientPoints.first.color,
          ),
          interval: const Interval(
            0,
            0.7,
            curve: Curves.easeInOut,
          ),
        ),
        AnimationSequence(
          pointIndex: 1,
          newPoint: MeshGradientPoint(
            position: const Offset(0.1, 0.1),
            color: _initialMeshGradientPoints[1].color,
          ),
          interval: const Interval(
            0,
            0.4,
            curve: Curves.ease,
          ),
        ),
        AnimationSequence(
          pointIndex: 2,
          newPoint: MeshGradientPoint(
            position: const Offset(0.1, 0.9),
            color: _initialMeshGradientPoints[2].color,
          ),
          interval: const Interval(
            0,
            0.8,
            curve: Curves.ease,
          ),
        ),
        AnimationSequence(
          pointIndex: 3,
          newPoint: MeshGradientPoint(
            position: const Offset(0.8, 0.2),
            color: _initialMeshGradientPoints[3].color,
          ),
          interval: const Interval(
            0,
            0.8,
            curve: Curves.ease,
          ),
        ),
      ],
    );
    await Future.delayed(const Duration(seconds: 1));
    await _meshGradientController.animateSequence(
      duration: const Duration(seconds: 4),
      sequences: [
        AnimationSequence(
          pointIndex: 0,
          newPoint: MeshGradientPoint(
            position: _initialMeshGradientPoints.first.position,
            color: _initialMeshGradientPoints.first.color,
          ),
          interval: const Interval(
            0,
            0.2,
            curve: Curves.easeInOut,
          ),
        ),
        AnimationSequence(
          pointIndex: 1,
          newPoint: MeshGradientPoint(
            position: _initialMeshGradientPoints[1].position,
            color: _initialMeshGradientPoints[1].color,
          ),
          interval: const Interval(
            0,
            0.4,
            curve: Curves.ease,
          ),
        ),
        AnimationSequence(
          pointIndex: 2,
          newPoint: MeshGradientPoint(
            position: _initialMeshGradientPoints[2].position,
            color: _initialMeshGradientPoints[2].color,
          ),
          interval: const Interval(
            0,
            0.8,
            curve: Curves.ease,
          ),
        ),
        AnimationSequence(
          pointIndex: 3,
          newPoint: MeshGradientPoint(
            position: _initialMeshGradientPoints[3].position,
            color: _initialMeshGradientPoints[3].color,
          ),
          interval: const Interval(
            0,
            0.9,
            curve: Curves.ease,
          ),
        ),
      ],
    );
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    _animate();
    _repeatTimer = Timer.periodic(const Duration(seconds: 11), (timer) {
      _animate();
    });
    super.initState();
  }

  @override
  void dispose() {
    _repeatTimer.cancel();
    // not sure why this throw error.
    _meshGradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: MeshGradient(
        options: MeshGradientOptions(),
        controller: _meshGradientController,
        child: const Center(
          child: Text(
            'MeshGradientController',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _MeshGradientWithRepeatedAnimation extends StatefulWidget {
  const _MeshGradientWithRepeatedAnimation();

  @override
  State<_MeshGradientWithRepeatedAnimation> createState() =>
      _MeshGradientWithRepeatedAnimationState();
}

class _MeshGradientWithRepeatedAnimationState
    extends State<_MeshGradientWithRepeatedAnimation> {
  late final AnimatedMeshGradientController _controller =
      AnimatedMeshGradientController();
  @override
  void initState() {
    super.initState();
    _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: AnimatedMeshGradient(
        colors: const [
          Colors.red,
          Colors.purple,
          Colors.green,
          Colors.yellow,
        ],
        options: AnimatedMeshGradientOptions(),
        controller: _controller,
        child: const Center(
          child: Text(
            'AnimatedMeshGradient',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
