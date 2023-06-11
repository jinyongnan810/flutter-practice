import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlutterPortalDemo extends StatefulWidget implements DemoWidget {
  const FlutterPortalDemo({Key? key}) : super(key: key);
  static const String _title = 'Flutter Portal Demo';
  static const String _description = 'https://pub.dev/packages/flutter_portal';

  @override
  State<FlutterPortalDemo> createState() => _WebSocketDemoState();
  @override
  String get title => FlutterPortalDemo._title;

  @override
  String get description => FlutterPortalDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.message);
}

class _WebSocketDemoState extends State<FlutterPortalDemo> {
  bool _showPopup = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: () {}, child: const Text('hello')),
        _ModalEntry(
          visible: _showPopup,
          onClose: () => setState(() => _showPopup = false),
          popup: _Popup(
            children: [
              for (var i = 0; i < 12; i++)
                ListTile(
                  onTap: () => setState(() => _showPopup = false),
                  title: Text('$i'),
                ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => setState(() => _showPopup = true),
            child: const Text('show popup'),
          ),
        ),
      ],
    );
  }
}

class DeclarativeDatePicker extends StatelessWidget {
  const DeclarativeDatePicker({
    Key? key,
    required this.visible,
    required this.onDismissed,
    required this.onClose,
    required this.child,
  }) : super(key: key);

  final bool visible;
  final Widget child;
  final VoidCallback onDismissed;
  final void Function(DateTime date) onClose;

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: visible,
      portalFollower: Stack(
        children: [
          const Positioned.fill(
            child: IgnorePointer(
              child: ModalBarrier(color: Colors.black38),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onDismissed,
            child: Center(
              child: Card(
                elevation: 16,
                child: ElevatedButton(
                  onPressed: () => onClose(DateTime.now()),
                  child: const Text('today'),
                ),
              ),
            ),
          )
        ],
      ),
      child: child,
    );
  }
}

class _Popup extends StatelessWidget {
  const _Popup({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: IntrinsicWidth(
          child: ListView(
            shrinkWrap: true,
            children: children,
          ),
        ),
      ),
    );
  }
}

class _ModalEntry extends StatelessWidget {
  const _ModalEntry({
    Key? key,
    required this.onClose,
    required this.visible,
    required this.popup,
    required this.child,
  }) : super(key: key);

  final VoidCallback onClose;
  final bool visible;
  final Widget popup;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: visible ? onClose : null,
      child: PortalTarget(
        visible: visible,
        portalFollower: popup,
        // todo: implement anchor that sizes the follower based on the available space within the portal at the calculated offset.
        anchor: const Aligned(
          follower: Alignment.topLeft,
          target: Alignment.bottomLeft,
          widthFactor: 1,
        ),
        child: IgnorePointer(
          ignoring: visible,
          child: child,
        ),
      ),
    );
  }
}
