import 'package:flutter/material.dart';
import 'package:flutter_practice/components/demo_card.dart';
import 'package:flutter_practice/demos/play-sound-demo.dart';
import 'package:flutter_practice/demos/test-widgets-demo.dart';
import 'package:flutter_practice/shared/demo-widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DemoWidget> _demos = [const PlaySoundDemo(), TestWidgetsDemo()];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
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
