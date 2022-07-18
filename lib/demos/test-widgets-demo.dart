import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo-widget.dart';

class TestWidgetsDemo extends StatelessWidget implements DemoWidget {
  TestWidgetsDemo({Key? key})
      : msgs = [],
        super(key: key);
  static const String _title = 'Test Widgets Demo';
  static const String _description = 'Test some of the widgets.';
  @override
  String get title => TestWidgetsDemo._title;

  @override
  String get description => TestWidgetsDemo._description;

  @override
  Icon get icon => const Icon(Icons.ramen_dining);

  final List<String> msgs;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              final newMsg = 'hello ${DateTime.now()}';
              Timer timer = Timer(const Duration(seconds: 5), () {
                if (msgs.contains(newMsg)) {
                  msgs.remove(newMsg);
                }
              });
              msgs.add(newMsg);
              msgs.length > 3 ? msgs.removeAt(0) : null;
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                // these two make transparent background
                backgroundColor: Colors.transparent,
                elevation: 0,

                behavior: SnackBarBehavior.floating,

                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: msgs
                      .map((e) => Text(
                            e,
                            style: const TextStyle(color: Colors.black),
                          ))
                      .toList(),
                ),
                dismissDirection: DismissDirection.startToEnd,
                duration: const Duration(seconds: 5),
              ));
            },
            child: const Text('show snackbar')),
        const SizedBox(
          height: 20,
        ),
      ],
    ));
  }
}
