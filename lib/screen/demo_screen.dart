import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/shared/demo-widget.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({Key? key, required this.child}) : super(key: key);
  static const String routeName = '/demoScreen';

  final DemoWidget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(child.title)),
      body: Container(child: child),
    );
  }
}
