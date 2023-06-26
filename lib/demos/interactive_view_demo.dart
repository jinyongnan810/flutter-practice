import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InteractiveViewDemo extends StatefulWidget implements DemoWidget {
  const InteractiveViewDemo({Key? key}) : super(key: key);
  static const String _title = 'Interactive View Demo';
  static const String _description =
      'Zoom in, zoom out, positioning stuff, etc.';

  @override
  State<InteractiveViewDemo> createState() => _InteractiveViewDemoState();
  @override
  String get title => InteractiveViewDemo._title;

  @override
  String get description => InteractiveViewDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.expand);
}

const canvasSize = Size(5000, 5000);

class _InteractiveViewDemoState extends State<InteractiveViewDemo>
    with TickerProviderStateMixin {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Interactive View Demo'),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            _InteractiveViewTab(),
            Center(child: Text('page2')),
            Center(child: Text('page3'))
          ],
        ),
      ),
    );
  }
}

class _InteractiveViewTab extends StatefulWidget {
  const _InteractiveViewTab();

  @override
  State<_InteractiveViewTab> createState() => __InteractiveViewTabState();
}

class __InteractiveViewTabState extends State<_InteractiveViewTab>
    with AutomaticKeepAliveClientMixin {
  late final TransformationController _transformationController;
  // seems not working with NavigationRail but works with TabBar
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    _transformationController = TransformationController();
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
    debugPrint('InteractiveViewDemo disposed');
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
              child: Container(
                width: 500,
                height: 500,
                decoration: const BoxDecoration(color: Colors.white),
                alignment: Alignment.center,
                child: const Text(
                  'Interactive View',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
            Positioned(
              top: 1000,
              left: 1000,
              child: Image.asset(
                'assets/images/working-out.jpg',
                width: 1000,
              ),
            )
          ],
        ),
      ),
    );
  }
}
