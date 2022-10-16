import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo-widget.dart';

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
  Icon get icon => const Icon(Icons.animation);
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
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 400),
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
    return LayoutBuilder(builder: (context, constraint) {
      return Stack(
        children: [
          _showEdgeBall
              ?
              // Positioned(left: 0, top: 0, child: edgeBall)
              _AnimatedWidget(
                  controller: _edgeBallAnimationController,
                  origin: Offset.zero,
                  position: Offset.zero.translate(
                      constraint.maxWidth - ballSize,
                      constraint.maxHeight - ballSize),
                  size: ballSize,
                  child: edgeBall)
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
                    child: const Text('start animate')),
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
                    child: const Text('reverse animation')),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class _AnimatedWidget extends StatelessWidget {
  const _AnimatedWidget({
    required this.controller,
    required this.origin,
    required this.position,
    required this.size,
    required this.child,
  });

  final AnimationController controller;
  final Offset origin;
  final Offset position;
  final double size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
      reverseCurve: Curves.easeIn,
    );
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          top: lerpDouble(
            origin.dy - size / 2,
            position.dy,
            animation.value,
          ),
          left: lerpDouble(
            origin.dx - size / 2,
            position.dx,
            animation.value,
          ),
          child: Transform.scale(
            scale: animation.value,
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
