import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlutterPortalHintsDemo extends StatefulWidget implements DemoWidget {
  const FlutterPortalHintsDemo({Key? key}) : super(key: key);
  static const String _title = 'TextField Hints Demo';
  static const String _description = 'https://pub.dev/packages/flutter_portal';

  @override
  State<FlutterPortalHintsDemo> createState() => _FlutterPortalHintsDemoState();
  @override
  String get title => FlutterPortalHintsDemo._title;

  @override
  String get description => FlutterPortalHintsDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.droplet);
}

class _FlutterPortalHintsDemoState extends State<FlutterPortalHintsDemo> {
  bool _showHint = false;
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final main = TextField(
      decoration: const InputDecoration(hintText: 'Tap to show hints'),
      controller: _textEditingController,
      onTap: () {
        setState(() {
          _showHint = true;
        });
      },
      onTapOutside: (_) {
        setState(() {
          _showHint = false;
        });
      },
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 10),
      width: 300,
      alignment: Alignment.center,
      child: _showHint
          ? _HintPortalTarget(
              onClose: () {
                debugPrint('selected');
                setState(() {
                  _showHint = false;
                });
              },
              // visible: _showHint,
              child: main,
            )
          : main,
    );
  }
}

class _HintPortalTarget extends StatelessWidget {
  const _HintPortalTarget({
    Key? key,
    // required this.visible,
    required this.onClose,
    required this.child,
  }) : super(key: key);

  // final bool visible;
  final VoidCallback onClose;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      // visible: visible,
      anchor: const Aligned(
        follower: Alignment.topCenter,
        target: Alignment.bottomCenter,
        widthFactor: 1,
      ),
      portalFollower: ListView(
        children: [
          for (int i = 0; i < 5; i++)
            ListTile(
              tileColor: Colors.black,
              textColor: Colors.white,
              title: Text('$i'),
              onTap: () {
                onClose();
              },
            )
        ],
      ),
      child: child,
    );
  }
}
