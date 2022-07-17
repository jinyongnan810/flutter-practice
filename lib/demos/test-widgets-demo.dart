import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo-widget.dart';

class TestWidgetsDemo extends StatelessWidget implements DemoWidget {
  const TestWidgetsDemo({Key? key}) : super(key: key);
  static const String _title = 'Test Widgets Demo';
  static const String _description = 'Test some of the widgets.';
  @override
  String get title => TestWidgetsDemo._title;

  @override
  String get description => TestWidgetsDemo._description;

  @override
  Icon get icon => const Icon(Icons.ramen_dining);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('hello ${DateTime.now()}')));
            },
            child: const Text('show snackbar')),
        const SizedBox(
          height: 20,
        ),
      ],
    ));
  }
}
