import 'package:flutter/material.dart';
import 'package:flutter_practice/pigeon.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PigeonDemo extends StatefulWidget implements DemoWidget {
  const PigeonDemo({super.key});
  static const String _title = 'Dummy Demo';
  static const String _description = '';

  @override
  State<PigeonDemo> createState() => _PigeonDemoState();
  @override
  String get title => PigeonDemo._title;

  @override
  String get description => PigeonDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

class _PigeonDemoState extends State<PigeonDemo> {
  String message = 'Tap button below to call native method.';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Text(message),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: content,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await TestNativeApi().sendMessage(
              ToNativeParams(message: "hello from flutter", times: 3),
            );
            setState(() {
              message =
                  '${result.message}, battery level is: ${result.batteryLevel * 100}%.';
            });
          },
          child: const Icon(Icons.battery_0_bar),
        ),
      ),
    );
  }
}

class FlutterApi implements TestFlutterApi {
  @override
  void onGotBatteryLevel(double batteryLevel) {}
}
