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

class _AnimatedPromptDemoState extends State<AnimatedPromptDemo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _Prompt(
          icon: FaIcon(
            FontAwesomeIcons.check,
            color: Colors.white,
          ),
          background: Colors.green,
          title: "Thank you for your order!",
          details: "Your order was successful. \nSee you again!",
        ),
        _Prompt(
          icon: FaIcon(
            FontAwesomeIcons.xmark,
            color: Colors.white,
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

class __PromptState extends State<_Prompt> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _iconSizeAnimation;
  late final Animation<double> _bgSizeAnimation;
  late final Animation<Offset> _positionAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _iconSizeAnimation = Tween<double>(begin: 7, end: 6)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _bgSizeAnimation = Tween<double>(begin: 2, end: 0.4)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _positionAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.23),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 150,
          ),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.details,
            style: const TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 100,
            minHeight: 100,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Stack(
            children: [
              content,
              Positioned.fill(
                child: SlideTransition(
                  position: _positionAnimation,
                  child: ScaleTransition(
                    scale: _bgSizeAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.background,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      // child: widget.icon,
                      child: ScaleTransition(
                        scale: _iconSizeAnimation,
                        child: widget.icon,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
