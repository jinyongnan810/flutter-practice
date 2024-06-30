import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShoreBirdDemo extends StatefulWidget implements DemoWidget {
  const ShoreBirdDemo({super.key});
  static const String _title = 'ShoreBird Demo';
  static const String _description = 'https://console.shorebird.dev/';

  @override
  State<ShoreBirdDemo> createState() => _ShoreBirdDemoState();
  @override
  String get title => ShoreBirdDemo._title;

  @override
  String get description => ShoreBirdDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

enum VersionStatus {
  initial,
  hasNewVersion,
  noNewVersion,
}

class _ShoreBirdDemoState extends State<ShoreBirdDemo> {
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
    // TODO: continue shorebird demo after apple developer account is ready
    // use https://pub.dev/packages/shorebird_code_push
    final content = Expanded(
      child: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('Check has new version'),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: content,
    );
  }
}
