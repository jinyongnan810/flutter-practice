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

class _InteractiveViewDemoState extends State<InteractiveViewDemo> {
  late final TransformationController _transformationController;
  @override
  void initState() {
    _transformationController = TransformationController();
    super.initState();
    // Future.microtask(
    //   () {
    //     final result = Matrix4.identity()
    //       ..translate(
    //         2500,
    //         2500,
    //       );
    //     _transformationController.value = result;
    //   },
    // );
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 0.1,
      maxScale: 10,
      constrained: false,
      // TODO: center this
      transformationController: _transformationController,
      child: SizedBox(
        width: 5000,
        height: 5000,
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
            const Positioned(
              top: 2500,
              left: 2500,
              child: Text(
                'Interactive View',
                style: TextStyle(fontSize: 100),
              ),
            )
          ],
        ),
      ),
    );
  }
}
