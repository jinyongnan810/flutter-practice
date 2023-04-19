import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedPromptDemo extends StatefulWidget implements DemoWidget {
  const AnimatedPromptDemo({Key? key}) : super(key: key);
  static const String _title = 'Animated Prompt';
  static const String _description = 'Dynamic Prompt';

  @override
  State<AnimatedPromptDemo> createState() => _AnimatedPromptDemoState();
  @override
  String get title => AnimatedPromptDemo._title;

  @override
  String get description => AnimatedPromptDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.check);
}

class _AnimatedPromptDemoState extends State<AnimatedPromptDemo>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _Prompt(
            icon: FaIcon(FontAwesomeIcons.check),
            background: Colors.green,
            title: "Thank you for your order!",
            details: "Your order was successful. \nSee you again!",
          ),
          _Prompt(
            icon: FaIcon(FontAwesomeIcons.x),
            background: Colors.redAccent,
            title: "Something went wrong!",
            details:
                "The order was unsuccessful. \nPlease check all information.",
          )
        ],
      ),
    );
  }
}

class _Prompt extends StatefulWidget {
  const _Prompt({
    required this.icon,
    required this.background,
    required this.title,
    required this.details,
  });
  final Widget icon;
  final Color background;
  final String title;
  final String details;

  @override
  State<_Prompt> createState() => __PromptState();
}

class __PromptState extends State<_Prompt> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (ctx, _) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateY(_animation.value),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                )
              ],
              color: Colors.blue,
            ),
            width: 100,
            height: 100,
          ),
        );
      },
    );
  }
}
