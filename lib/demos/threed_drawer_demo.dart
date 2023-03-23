import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_practice/shared/demo_widget.dart';

class ThreedDrawerDemo extends StatefulWidget implements DemoWidget {
  const ThreedDrawerDemo({Key? key}) : super(key: key);
  static const String _title = '3d drawer demo';
  static const String _description = '3d effect drawer';

  @override
  State<ThreedDrawerDemo> createState() => _ThreedDrawerDemoState();
  @override
  String get title => ThreedDrawerDemo._title;

  @override
  String get description => ThreedDrawerDemo._description;

  @override
  Widget get icon => const Icon(Icons.draw);
}

class _ThreedDrawerDemoState extends State<ThreedDrawerDemo>
    with TickerProviderStateMixin {
  late final AnimationController _contentController;
  late final Animation<double> _contentAnimation;
  late final AnimationController _drawerController;
  late final Animation<double> _drawerAnimation;
  late double widgetWidth = 0;
  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _contentAnimation =
        Tween<double>(begin: 0, end: -pi / 2).animate(_contentController);
    _drawerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _drawerAnimation =
        Tween<double>(begin: pi / 2.7, end: 0).animate(_drawerController);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      widgetWidth = (context.findRenderObject() as RenderBox).size.width;
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxDrag = widgetWidth * 0.8;
    final drawer = Material(
      child: Container(
        color: Colors.amber,
        child: ListView.builder(
          itemBuilder: (ctx, index) => ListTile(
            title: Text('Item $index'),
          ),
          itemCount: 20,
          padding: const EdgeInsets.only(left: 80, top: 100),
        ),
      ),
    );
    final content = Scaffold(
      appBar: AppBar(
        title: const Text('Content'),
      ),
      body: const Center(
        child: Text('content'),
      ),
    );
    final background = Container(
      color: Colors.black38,
    );
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.delta.dx / maxDrag;
        _contentController.value += delta;
        _drawerController.value += delta;
      },
      onHorizontalDragEnd: (details) {
        if (_contentController.value < 0.5) {
          _contentController.reverse();
          _drawerController.reverse();
        } else {
          _contentController.forward();
          _drawerController.forward();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_contentController, _drawerController]),
        builder: (context, child) {
          return Stack(
            children: [
              background,
              Transform(
                transform: Matrix4.identity()
                  // to make perspective transformations
                  ..setEntry(3, 2, 0.001)
                  ..translate(_contentAnimation.value * maxDrag)
                  ..rotateY(_contentAnimation.value),
                alignment: Alignment.centerLeft,
                child: content,
              ),
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                    -widgetWidth + _drawerAnimation.value * maxDrag,
                  )
                  ..rotateY(_drawerAnimation.value),
                alignment: Alignment.centerRight,
                child: drawer,
              )
            ],
          );
        },
      ),
    );
  }
}
