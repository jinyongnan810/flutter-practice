import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DummyDemo extends StatefulWidget implements DemoWidget {
  const DummyDemo({super.key});
  static const String _title = 'Dummy demo';
  static const String _description = '';

  @override
  State<DummyDemo> createState() => _DummyDemoState();
  @override
  String get title => DummyDemo._title;

  @override
  String get description => DummyDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

class _DummyDemoState extends State<DummyDemo> {
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
    const content = Center(
      child: Text('This is a dummy demo.'),
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: content,
    );
  }
}
