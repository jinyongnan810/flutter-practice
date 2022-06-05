import 'package:flutter/material.dart';
import 'package:flutter_practice/components/demo_card.dart';
import 'package:flutter_practice/demos/play-sound-demo.dart';
import 'package:flutter_practice/shared/demo-widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<DemoWidget> demos = [const PlaySoundDemo()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              ...demos.map((demo) => DemoCard(
                    widget: demo,
                  ))
            ],
          ),
        ));
  }
}
