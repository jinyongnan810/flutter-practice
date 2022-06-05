import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo-widget.dart';

class PlaySoundDemo extends StatelessWidget implements DemoWidget {
  const PlaySoundDemo({Key? key}) : super(key: key);
  static const String _title = 'Play Sound Demo';
  static const String _description =
      'Practice Caching and Playing Sound and all';
  @override
  String get title => PlaySoundDemo._title;
  @override
  String get description => PlaySoundDemo._description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Play sound demo'),
    );
  }
}
