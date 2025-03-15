import 'dart:math';

import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:flutter_svg/svg.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.5),
        elevation: 0,
        title: Text(widget.title),
      ),
      body: const _InteractiveViewTab(),
    );
    return Stack(
      children: [
        IgnorePointer(
          ignoring: _isLoading,
          child: content,
        ),
        if (_isLoading)
          Positioned.fill(
            child: _LoadingScreen(
              onFinished: () {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
      ],
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
    with TickerProviderStateMixin {
  late final TransformationController _transformationController;
  late final AnimationController _lottieAnimationController;

  final _initialScale = 0.4;
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
        if (!mounted) {
          return;
        }
        final size = MediaQuery.of(context).size;
        // print('size: $size, canvasSize: $canvasSize');
        // center and scale to 0.3
        final result = Matrix4.identity()
          ..translate(
            size.width / 2 - canvasSize.width * _initialScale / 2,
            size.height / 2 - canvasSize.height * _initialScale / 2,
          )
          ..scale(_initialScale);
        // print('result $result');
        _transformationController.value = result;
        // _transformationController.addListener(() {
        //   print('value: ${_transformationController.value}');
        // });
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
                title: 'Animations',
                link: '/animations',
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
            Positioned(
              top: 2800,
              left: 2700,
              child: _DemoLink(
                title: 'Gradients and Shaders',
                link: '/gradient',
              ),
            ),
            Positioned(
              top: 2900,
              left: 2600,
              child: _DemoLink(
                title: 'Theme Color',
                link: '/theme-color',
              ),
            ),
            Positioned(
              top: 2800,
              left: 2500,
              child: _DemoLink(
                title: 'Mix',
                link: '/mix',
              ),
            ),
            if (defaultTargetPlatform == TargetPlatform.android ||
                defaultTargetPlatform == TargetPlatform.iOS)
              Positioned(
                top: 2750,
                left: 2300,
                child: _DemoLink(
                  title: 'ShoreBird',
                  link: '/shorebird',
                ),
              ),
            Positioned(
              top: 2900,
              left: 2900,
              child: _DemoLink(
                title: 'Shader Mask',
                link: '/shader-mask',
              ),
            ),

            Positioned(
              top: 2620,
              left: 1850,
              child: _DemoLink(
                title: 'Blur When Scroll',
                link: '/blur-when-scroll',
              ),
            ),
            Positioned(
              top: 2780,
              left: 2000,
              child: _DemoLink(
                title: 'Ripple Effect',
                link: '/ripple-effect',
              ),
            ),
            Positioned(
              top: 2700,
              left: 1950,
              child: _DemoLink(
                title: 'Image Filter',
                link: '/image-filter',
              ),
            ),

            Positioned(
              top: 3000,
              left: 2200,
              child: _DemoLink(
                title: 'Nested Navigation',
                link: '/nested-nav',
              ),
            ),
            Positioned(
              top: 3100,
              left: 2400,
              child: _DemoLink(
                title: 'Adaptive Scaffold',
                link: '/adaptive-scaffold',
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

class _LoadingScreen extends StatefulWidget {
  const _LoadingScreen({required this.onFinished});
  final VoidCallback onFinished;

  @override
  State<_LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<_LoadingScreen>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  );

  late final _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Interval(0, 0.3, curve: Curves.easeInOut),
    ),
  );

  late final _clipAnimation = Tween<double>(begin: 0, end: 5000).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1, curve: Curves.easeInOut),
    ),
  );
  @override
  void initState() {
    super.initState();
    _controller.forward().whenComplete(() {
      widget.onFinished();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned.fill(
              child: ClipPath(
                clipper: _LoadingClipper(_clipAnimation.value),
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: SvgPicture.asset("assets/images/loading.svg"),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LoadingClipper extends CustomClipper<Path> {
  _LoadingClipper(this.width);
  final double width;

  @override
  Path getClip(Size size) {
    return Path()
      // ..addOval(
      //   Rect.fromCircle(
      //     center: size.center(Offset.zero),
      //     radius: width,
      //   ),
      // )
      ..addRect(
        Rect.fromCenter(
          center: size.center(Offset.zero),
          width: width,
          height: width,
        ),
      )
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
