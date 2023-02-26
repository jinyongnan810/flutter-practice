import 'package:flutter/material.dart';
import 'package:flutter_practice/demos/threed_animation_demo.dart';
import 'package:flutter_practice/demos/animation_demo2.dart';
import 'package:flutter_practice/demos/chained_animation_demo.dart';
import 'package:flutter_practice/demos/hero_animation_demo.dart';
import 'package:flutter_practice/demos/implicit_animation_demo.dart';
import 'package:flutter_practice/demos/play_sound_demo.dart';
import 'package:flutter_practice/demos/test_widgets_demo.dart';
import 'package:flutter_practice/demos/animation_demo.dart';
import 'package:flutter_practice/demos/tween_animation_demo.dart';
import 'package:flutter_practice/shared/demo_widget.dart';

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
    const ImplicitAnimationDemo(),
    const TweenAnimationDemo(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Practice'),
      ),
      body: SafeArea(
        child: Row(
          children: [
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
              },
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _demos[_selectedIndex],
            )
          ],
        ),
      ),
    );
  }
}
