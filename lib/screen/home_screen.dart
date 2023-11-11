import 'package:flutter/material.dart';
import 'package:flutter_practice/demos/animated_prompt_demo.dart';
import 'package:flutter_practice/demos/custom_painter_demo.dart';
import 'package:flutter_practice/demos/dart_test_demo.dart';
import 'package:flutter_practice/demos/flutter_portal_demo.dart';
import 'package:flutter_practice/demos/flutter_portal_hints_demo.dart';
import 'package:flutter_practice/demos/interactive_view_demo.dart';
import 'package:flutter_practice/demos/super_text_demo.dart';
import 'package:flutter_practice/demos/threed_animation_demo.dart';
import 'package:flutter_practice/demos/animation_demo2.dart';
import 'package:flutter_practice/demos/chained_animation_demo.dart';
import 'package:flutter_practice/demos/hero_animation_demo.dart';
import 'package:flutter_practice/demos/implicit_animation_demo.dart';
import 'package:flutter_practice/demos/play_sound_demo.dart';
import 'package:flutter_practice/demos/test_widgets_demo.dart';
import 'package:flutter_practice/demos/animation_demo.dart';
import 'package:flutter_practice/demos/threed_drawer_demo.dart';
import 'package:flutter_practice/demos/tween_animation_demo.dart';
import 'package:flutter_practice/demos/twod_scrolling_demo.dart';
import 'package:flutter_practice/demos/websocket_demo.dart';
import 'package:flutter_practice/shared/demo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DemoWidget> _demos = [
    const InteractiveViewDemo(),
    const TwoDScrollingDemo(),
    const PlaySoundDemo(),
    TestWidgetsDemo(),
    const AnimationDemo(),
    const AnimationDemo2(),
    const ChainedAnimationDemo(),
    const ThreeDAnimationDemo(),
    const HeroAnimationDemo(),
    const ImplicitAnimationDemo(),
    const TweenAnimationDemo(),
    const CustomPainterDemo(),
    const ThreedDrawerDemo(),
    const DartTestDemo(),
    const SuperTextDemo(),
    const AnimatedPromptDemo(),
    const WebSocketDemo(),
    const FlutterPortalDemo(),
    const FlutterPortalHintsDemo(),
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
            LayoutBuilder(
              builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: NavigationRail(
                        key: const ValueKey('tabs'),
                        labelType: NavigationRailLabelType.selected,
                        destinations: [
                          for (final demo in _demos)
                            NavigationRailDestination(
                              icon: demo.icon,
                              label: Text(
                                demo.title,
                                key: Key(demo.title),
                              ),
                            )
                        ],
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                );
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
