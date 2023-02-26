import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';

class AnimationDemo extends StatefulWidget implements DemoWidget {
  const AnimationDemo({Key? key}) : super(key: key);
  static const String _title = 'Animation Demo';
  static const String _description = 'Practice Animation related';

  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
  @override
  String get title => AnimationDemo._title;

  @override
  String get description => AnimationDemo._description;

  @override
  Widget get icon => const Icon(Icons.animation);
}

class _AnimationDemoState extends State<AnimationDemo>
    with TickerProviderStateMixin {
  late final AnimationController _edgeBallAnimationController;
  bool _showEdgeBall = false;
  @override
  void initState() {
    super.initState();
    _edgeBallAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _edgeBallAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const ballSize = 100.0;
    final edgeBall = Container(
      width: ballSize,
      height: ballSize,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
    );
    return LayoutBuilder(
      builder: (context, constraint) {
        return Stack(
          children: [
            _showEdgeBall
                ?
                // Positioned(left: 0, top: 0, child: edgeBall)
                _AnimatedWidget(
                    controller: _edgeBallAnimationController,
                    from: Offset.zero,
                    to: Offset.zero.translate(
                      constraint.maxWidth - ballSize,
                      constraint.maxHeight - ballSize,
                    ),
                    forwardingCurve: Curves.easeInToLinear,
                    reversingCurve: Curves.linearToEaseOut,
                    child: edgeBall,
                  )
                : Container(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showEdgeBall = true;
                      });
                      _edgeBallAnimationController.forward();
                    },
                    child: const Text('start animate'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _edgeBallAnimationController.reverse(from: 1).then((_) {
                        setState(() {
                          _showEdgeBall = false;
                        });
                      });
                    },
                    child: const Text('reverse animation'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AnimatedWidget extends StatelessWidget {
  const _AnimatedWidget({
    required this.controller,
    required this.from,
    required this.to,
    required this.forwardingCurve,
    required this.reversingCurve,
    required this.child,
  });

  final AnimationController controller;
  final Offset from;
  final Offset to;
  final Curve forwardingCurve;
  final Curve reversingCurve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      // https://api.flutter.dev/flutter/animation/Curves-class.html
      curve: forwardingCurve,
      reverseCurve: reversingCurve,
    );
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            lerpDouble(
              from.dx,
              to.dx,
              animation.value,
            )!,
            lerpDouble(
              from.dy,
              to.dy,
              animation.value,
            )!,
          ),
          child: Transform.scale(
            scale: 1,
            child: Opacity(
              opacity: clampDouble(animation.value, 0, 1),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
