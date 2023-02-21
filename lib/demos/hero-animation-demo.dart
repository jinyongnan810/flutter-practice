import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo-widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroAnimationDemo extends StatefulWidget implements DemoWidget {
  const HeroAnimationDemo({Key? key}) : super(key: key);
  static const String _title = 'Hero Animation Demo';
  static const String _description = 'Hero effect between pages';

  @override
  State<HeroAnimationDemo> createState() => _HeroAnimationDemoState();
  @override
  String get title => HeroAnimationDemo._title;

  @override
  String get description => HeroAnimationDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.peopleGroup);
}

class Person {
  final String name;
  final int age;
  final String emoji;

  Person(this.name, this.age, this.emoji);
}

final people = [
  Person('John', 21, '👨‍⚕️'),
  Person('Jane', 19, '👩‍🔧'),
  Person('Jack', 44, '👨‍🍳'),
];

class _HeroAnimationDemoState extends State<HeroAnimationDemo>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Tween<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final person = people[index];
          return ListTile(
            leading: Hero(
              tag: person.name,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            title: Text(person.name),
            subtitle: Text('${person.age} years old'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => _PersonDetailPage(person: person))),
          );
        },
        itemCount: people.length,
      ),
    );
  }
}

class _PersonDetailPage extends StatelessWidget {
  final Person person;
  const _PersonDetailPage({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Hero(
        flightShuttleBuilder: (flightContext, animation, flightDirection,
            fromHeroContext, toHeroContext) {
          return const Text('🔥');
        },
        tag: person.name,
        child: Material(
          color: Colors.transparent,
          child: Text(
            person.emoji,
            style: const TextStyle(fontSize: 40),
          ),
        ),
      )),
      body: Center(
          child: Column(
        children: [Text(person.name), Text('${person.age} years old')],
      )),
    );
  }
}
