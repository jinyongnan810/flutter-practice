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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _Prompt(
          icon: FaIcon(
            FontAwesomeIcons.check,
            color: Colors.white,
            size: 32,
          ),
          background: Colors.green,
          title: "Thank you for your order!",
          details: "Your order was successful. \nSee you again!",
        ),
        _Prompt(
          icon: FaIcon(
            FontAwesomeIcons.xmark,
            color: Colors.white,
            size: 32,
          ),
          background: Colors.redAccent,
          title: "Something went wrong!",
          details:
              "The order was unsuccessful. \nPlease check all information.",
        )
      ],
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
  late final Animation<double> _iconSizeAnimation;
  late final Animation<double> _bgSizeAnimation;
  late final Animation<double> _positionAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _iconSizeAnimation = Tween<double>(begin: 2, end: 1).animate(_controller);
    _bgSizeAnimation = Tween<double>(begin: 3, end: 1).animate(_controller);
    _positionAnimation = Tween<double>(begin: 3, end: 1).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 350,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.details,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Positioned.fill(
            top: 20,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: widget.background,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
                alignment: Alignment.center,
                child: widget.icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
