import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';

class TestWidgetsDemo extends StatefulWidget implements DemoWidget {
  TestWidgetsDemo({super.key}) : msgs = [];
  static const String _title = 'Test Widgets Demo';
  static const String _description = 'Test some of the widgets.';
  final List<String> msgs;
  @override
  String get title => TestWidgetsDemo._title;

  @override
  String get description => TestWidgetsDemo._description;

  @override
  Widget get icon => const Icon(Icons.ramen_dining);

  @override
  State<TestWidgetsDemo> createState() => _TestWidgetsDemoState();
}

class _TestWidgetsDemoState extends State<TestWidgetsDemo>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              final newMsg = 'hello ${DateTime.now()}';
              Timer(const Duration(seconds: 5), () {
                if (widget.msgs.contains(newMsg)) {
                  widget.msgs.remove(newMsg);
                }
              });
              widget.msgs.add(newMsg);
              widget.msgs.length > 3 ? widget.msgs.removeAt(0) : null;
              // ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  // these two make transparent background
                  backgroundColor: Colors.transparent,
                  elevation: 0,

                  behavior: SnackBarBehavior.floating,

                  // width: 280.0,
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),

                  animation: CurvedAnimation(
                    parent: animationController,
                    curve: Curves.easeIn,
                    reverseCurve: Curves.easeOut,
                  ),

                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.msgs
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              e,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  dismissDirection: DismissDirection.startToEnd,
                  duration: const Duration(seconds: 5),
                ),
              );
            },
            child: const Text('show snackbar'),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
