import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlutterPortalDemo2 extends StatefulWidget implements DemoWidget {
  const FlutterPortalDemo2({super.key});
  static const String _title = 'TextField Hints Demo';
  static const String _description = 'https://pub.dev/packages/flutter_portal';

  @override
  State<FlutterPortalDemo2> createState() => _FlutterPortalDemo2State();
  @override
  String get title => FlutterPortalDemo2._title;

  @override
  String get description => FlutterPortalDemo2._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.droplet);
}

class _FlutterPortalDemo2State extends State<FlutterPortalDemo2> {
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
    final content = Container(
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: content,
      ),
    );
  }
}

class _HintPortalTarget extends StatelessWidget {
  const _HintPortalTarget({
    required this.onClose,
    required this.child,
  });

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
            ),
        ],
      ),
      child: child,
    );
  }
}
