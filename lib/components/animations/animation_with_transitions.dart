import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimationWithTransitions extends HookWidget {
  const AnimationWithTransitions({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final width = constraint.maxWidth;
        final height = constraint.maxHeight;
        return _Prompt(
          icon: const FaIcon(
            FontAwesomeIcons.check,
            color: Colors.white,
          ),
          background: Colors.green,
          title: "Thank you for your order!",
          details: "Your order was successful. \nSee you again!",
          width: width,
          height: height,
        );
      },
    );
  }
}

class _Prompt extends HookWidget {
  const _Prompt({
    required this.icon,
    required this.background,
    required this.title,
    required this.details,
    required this.width,
    required this.height,
  });
  final Widget icon;
  final Color background;
  final String title;
  final String details;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    useEffect(
      () {
        controller.forward();
        return null;
      },
      [],
    );
    final iconSizeAnimation = useMemoized(
      () => Tween<double>(begin: 7, end: 6).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      ),
    );
    final bgSizeAnimation = useMemoized(
      () => Tween<double>(begin: 2, end: 0.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      ),
    );
    final positionAnimation = useMemoized(
      () => Tween<Offset>(
        begin: const Offset(0, 0),
        end: const Offset(0, -0.23),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
    );
    final content = SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          controller.reset();
          controller.forward();
        },
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                details,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
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
            ),
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 30,
            minHeight: 30,
            maxHeight: height,
            maxWidth: width,
          ),
          child: Stack(
            children: [
              content,
              Positioned.fill(
                child: SlideTransition(
                  position: positionAnimation,
                  child: ScaleTransition(
                    scale: bgSizeAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: background,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      // child: widget.icon,
                      child: ScaleTransition(
                        scale: iconSizeAnimation,
                        child: icon,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
