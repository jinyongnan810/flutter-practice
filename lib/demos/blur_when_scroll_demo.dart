import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BlurWhenScrollDemo extends StatefulWidget implements DemoWidget {
  const BlurWhenScrollDemo({super.key});
  static const String _title = 'Blur when scroll demo';
  static const String _description =
      'original code from: https://github.com/Rahiche/image_filters/tree/main';

  @override
  State<BlurWhenScrollDemo> createState() => _BlurWhenScrollDemoState();
  @override
  String get title => BlurWhenScrollDemo._title;

  @override
  String get description => BlurWhenScrollDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

class _BlurWhenScrollDemoState extends State<BlurWhenScrollDemo>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  late final _animation =
      Tween<double>(begin: 0, end: 20).animate(_animationController);
  DateTime _lastScrollTime = DateTime.now();
  double _lastScrollPos = 0;
  final _maxScrollSpeed = 10;
  Timer? _scrollEndTimer;

  void _onScroll() {
    final now = DateTime.now();
    final timeElapsed = now.difference(_lastScrollTime).inMilliseconds;
    _lastScrollTime = now;
    final currentPos = _scrollController.position.pixels;
    final delta = currentPos - _lastScrollPos;
    final speed = delta.abs() / timeElapsed;
    final blurAmount = (speed / _maxScrollSpeed).clamp(0.0, 1.0);
    _animationController.animateTo(
      blurAmount,
      duration: const Duration(milliseconds: 50),
    );
    _lastScrollPos = currentPos;
    _scrollEndTimer?.cancel();
    _scrollEndTimer = Timer(const Duration(milliseconds: 100), () {
      _animationController.animateTo(
        0,
        duration: const Duration(milliseconds: 100),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        itemCount: 500,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(8),
          child: Image.network(
            'https://picsum.photos/id/${index + 1}/600/400',
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    final content = Stack(
      children: [
        list,
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: _animation.value,
            ),
            child: ColoredBox(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: content,
    );
  }
}
