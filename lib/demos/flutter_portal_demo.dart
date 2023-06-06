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
  late final TextEditingController controller;
  DateTime? pickedDate;
  bool showDatePicker = false;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DeclarativeDatePicker(
        visible: showDatePicker,
        onClose: (date) => setState(() {
          showDatePicker = false;
          pickedDate = date;
        }),
        onDismissed: () => setState(() => showDatePicker = false),
        child: pickedDate == null
            ? ElevatedButton(
                onPressed: () => setState(() => showDatePicker = true),
                child: const Text('pick a date'),
              )
            : Text('The date picked: $pickedDate'),
      ),
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
