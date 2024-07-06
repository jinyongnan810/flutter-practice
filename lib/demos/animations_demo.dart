import 'package:flutter/material.dart';
import 'package:flutter_practice/components/animations/animated_container_with_transforms.dart';
import 'package:flutter_practice/components/animations/animation_with_transitions.dart';
import 'package:flutter_practice/components/animations/chained_animations.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimationsDemo extends StatefulWidget implements DemoWidget {
  const AnimationsDemo({super.key});
  static const String _title = 'Animations Demo';
  static const String _description = '';

  @override
  State<AnimationsDemo> createState() => _AnimationsDemoState();
  @override
  String get title => AnimationsDemo._title;

  @override
  String get description => AnimationsDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

class _AnimationsDemoState extends State<AnimationsDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final crossCount = MediaQuery.sizeOf(context).width > 600 ? 4 : 2;
    final content = Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: crossCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: const [
          _Item(
            title: 'AnimatedContainer with transforms',
            content: AnimatedContainerWithTransforms(),
          ),
          _Item(
            title: 'Animation with transitions',
            content: AnimationWithTransitions(),
          ),
          _Item(
            title: 'Chained animations',
            content: ChainedAnimations(),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: content,
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.title, required this.content});
  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: content),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
