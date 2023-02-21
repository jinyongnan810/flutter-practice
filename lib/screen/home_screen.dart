import 'package:flutter/material.dart';
import 'package:flutter_practice/demos/3d-animation-demo.dart';
import 'package:flutter_practice/demos/animation-demo2.dart';
import 'package:flutter_practice/demos/chained-animation-demo.dart';
import 'package:flutter_practice/demos/hero-animation-demo.dart';
import 'package:flutter_practice/demos/play-sound-demo.dart';
import 'package:flutter_practice/demos/test-widgets-demo.dart';
import 'package:flutter_practice/demos/animation-demo.dart';
import 'package:flutter_practice/shared/demo-widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DemoWidget> _demos = [
    const PlaySoundDemo(),
    TestWidgetsDemo(),
    const AnimationDemo(),
    const AnimationDemo2(),
    const ChainedAnimationDemo(),
    const ThreeDAnimationDemo(),
    const HeroAnimationDemo(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Practice'),
        ),
        body: SafeArea(
          child: Row(children: [
            NavigationRail(
                labelType: NavigationRailLabelType.selected,
                destinations: [
                  for (final demo in _demos)
                    NavigationRailDestination(
                      icon: demo.icon,
                      label: Text(demo.title),
                    )
                ],
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
            const VerticalDivider(width: 1),
            Expanded(
              child: _demos[_selectedIndex],
            )
          ]),
        ));
  }
}
