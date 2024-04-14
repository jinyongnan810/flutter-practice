import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroAnimationDemo extends StatefulWidget implements DemoWidget {
  const HeroAnimationDemo({super.key});
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            onTap: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (ctx) => _PersonDetailPage(person: person),
              ),
            ),
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
    // const scaleRatio = 1.5;
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            // return const Text('🔥');
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  // child: ScaleTransition(
                  //   scale: animation.drive(
                  //     Tween<double>(begin: 1 / scaleRatio, end: 1).chain(
                  //       CurveTween(curve: Curves.fastOutSlowIn),
                  //     ),
                  //   ),
                  child: toHeroContext.widget,
                  // ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  // child: ScaleTransition(
                  //   scale: animation.drive(
                  //     Tween<double>(begin: 1 / scaleRatio, end: 1).chain(
                  //       CurveTween(curve: Curves.fastOutSlowIn),
                  //     ),
                  //   ),
                  child: fromHeroContext.widget,
                  // ),
                );
            }
          },
          tag: person.name,
          child: Text(
            person.emoji,
            style: const TextStyle(fontSize: 60),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [Text(person.name), Text('${person.age} years old')],
        ),
      ),
    );
  }
}
