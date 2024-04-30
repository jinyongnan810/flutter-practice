import 'dart:math';

import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget implements DemoWidget {
  const HomeScreen({super.key});
  static const String _title = 'Flutter Practices';
  static const String _description =
      'Zoom in, zoom out, positioning stuff, etc.';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  @override
  String get title => HomeScreen._title;

  @override
  String get description => HomeScreen._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.expand);
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.5),
          elevation: 0,
          title: Text(widget.title),
        ),
        body: const _InteractiveViewTab(),
      ),
    );
  }
}

const canvasSize = Size(5000, 5000);

class _InteractiveViewTab extends StatefulWidget {
  const _InteractiveViewTab();

  @override
  State<_InteractiveViewTab> createState() => __InteractiveViewTabState();
}

class __InteractiveViewTabState extends State<_InteractiveViewTab>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late final TransformationController _transformationController;
  late final AnimationController _lottieAnimationController;
  // seems not working with NavigationRail but works with TabBar
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    _transformationController = TransformationController();
    _lottieAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    super.initState();
    Future.microtask(
      () {
        final size = MediaQuery.of(context).size;
        final result = Matrix4.identity()
          ..translate(
            size.width / 2 - canvasSize.width / 2,
            size.height / 2 - canvasSize.height / 2,
          );
        _transformationController.value = result;
      },
    );
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _lottieAnimationController.dispose();
    debugPrint('HomeScreen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InteractiveViewer(
      minScale: 0.1,
      maxScale: 10,
      constrained: false,
      transformationController: _transformationController,
      child: SizedBox(
        width: canvasSize.width,
        height: canvasSize.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset('assets/images/bg.jpeg').image,
                    alignment: Alignment.center,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
            ),
            Positioned(
              top: canvasSize.height / 2 - 250,
              left: canvasSize.width / 2 - 250,
              child: AnimatedLoadingBorder(
                borderColor: Colors.black,
                borderWidth: 12,
                child: Container(
                  width: 500,
                  height: 500,
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.8)),
                  alignment: Alignment.center,
                  child: const Text(
                    'Flutter Practices',
                    style: TextStyle(fontSize: 70),
                  ),
                ),
              ),
            ),
            // got emoji's lottie file from https://googlefonts.github.io/noto-emoji-animation/
            Positioned(
              top: 2100,
              left: 2100,
              child: Lottie.asset(
                'assets/lotties/smile.json',
                width: 300,
                height: 300,
              ),
            ),
            Positioned(
              top: 2100,
              left: 2600,
              child: InkWell(
                onTap: () {
                  if (_lottieAnimationController.isAnimating) {
                    _lottieAnimationController.stop();
                  } else {
                    _lottieAnimationController.reset();
                    _lottieAnimationController.forward();
                  }
                },
                child: Lottie.network(
                  'https://fonts.gstatic.com/s/e/notoemoji/latest/1f917/lottie.json',
                  width: 300,
                  height: 300,
                  controller: _lottieAnimationController,
                ),
              ),
            ),
            Positioned(
              top: 2500,
              left: 1900,
              child: _DemoLink(
                title: 'Gemini Chat',
                link: '/gemini-chat',
              ),
            ),
            Positioned(
              top: 2300,
              left: 1700,
              child: _DemoLink(
                title: 'Animated Prompt',
                link: '/animated-prompt',
              ),
            ),
            Positioned(
              top: 2400,
              left: 1750,
              child: _DemoLink(
                title: 'Implicit Animation',
                link: '/implicit-animation',
              ),
            ),
            Positioned(
              top: 2350,
              left: 1400,
              child: _DemoLink(
                title: 'Tween Animation',
                link: '/tween-animation',
              ),
            ),
            Positioned(
              top: 2100,
              left: 1700,
              child: _DemoLink(
                title: 'AnimatedBuilder',
                link: '/animated-builder',
              ),
            ),
            Positioned(
              top: 2170,
              left: 1750,
              child: _DemoLink(
                title: 'AnimatedBuilder2',
                link: '/animated-builder2',
              ),
            ),
            Positioned(
              top: 2175,
              left: 1550,
              child: _DemoLink(
                title: '3D drawer',
                link: '/3d-drawer',
              ),
            ),
            Positioned(
              top: 2000,
              left: 1800,
              child: _DemoLink(
                title: 'Chained Animation',
                link: '/chained-animation',
              ),
            ),
            Positioned(
              top: 1925,
              left: 1650,
              child: _DemoLink(
                title: '3D Animation',
                link: '/3d',
              ),
            ),
            Positioned(
              top: 2600,
              left: 1700,
              child: _DemoLink(
                title: 'Custom Painter',
                link: '/custom-painter',
              ),
            ),
            Positioned(
              top: 1900,
              left: 2000,
              child: _DemoLink(
                title: 'Dart Test',
                link: '/dart-test',
              ),
            ),
            Positioned(
              top: 1850,
              left: 2200,
              child: _DemoLink(
                title: 'Drag and Drop',
                link: '/drag-and-drop',
              ),
            ),
            Positioned(
              top: 1870,
              left: 2500,
              child: _DemoLink(
                title: 'Portal1',
                link: '/portal1',
              ),
            ),
            Positioned(
              top: 1900,
              left: 2650,
              child: _DemoLink(
                title: 'Portal2',
                link: '/portal2',
              ),
            ),
            Positioned(
              top: 2000,
              left: 2800,
              child: _DemoLink(
                title: 'Hero',
                link: '/hero',
              ),
            ),
            Positioned(
              top: 2100,
              left: 2900,
              child: _DemoLink(
                title: 'Inherited Widget',
                link: '/inherited-widget',
              ),
            ),
            Positioned(
              top: 2200,
              left: 2920,
              child: _DemoLink(
                title: 'Play Sound',
                link: '/sound',
              ),
            ),
            Positioned(
              top: 2300,
              left: 2900,
              child: _DemoLink(
                title: 'Snackbar',
                link: '/snackbar',
              ),
            ),
            Positioned(
              top: 2400,
              left: 2800,
              child: _DemoLink(
                title: '2D Scrolling',
                link: '/2d-scrolling',
              ),
            ),
            Positioned(
              top: 2500,
              left: 2850,
              child: _DemoLink(
                title: 'WebSocket',
                link: '/websocket',
              ),
            ),
            Positioned(
              top: 2600,
              left: 2800,
              child: _DemoLink(
                title: 'Quill',
                link: '/flutter-quill',
              ),
            ),
            Positioned(
              top: 2700,
              left: 2750,
              child: _DemoLink(
                title: 'Pigeon',
                link: '/pigeon',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoLink extends StatelessWidget {
  _DemoLink({required this.title, required this.link});
  final String title;
  final String link;
  final Color borderStartColor =
      Color((Random().nextDouble() * 0xFFFFFF + 0xFF000000).toInt());
  final Color borderEndColor =
      Color((Random().nextDouble() * 0xFFFFFF + 0xFF000000).toInt());

  @override
  Widget build(BuildContext context) {
    return AnimatedLoadingBorder(
      borderColor: borderStartColor,
      borderWidth: 6,
      child: GestureDetector(
        onTap: () => context.go(link),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
