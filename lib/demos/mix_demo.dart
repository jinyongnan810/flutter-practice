import 'package:flutter/material.dart';
import 'package:flutter_practice/demos/mix_demo.styles.dart';
import 'package:flutter_practice/demos/mix_demo.variants.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mix/mix.dart';

class MixDemo extends StatefulWidget implements DemoWidget {
  const MixDemo({super.key});
  static const String _title = 'Mix Demo';
  static const String _description = '';

  @override
  State<MixDemo> createState() => _MixDemoState();
  @override
  String get title => MixDemo._title;

  @override
  String get description => MixDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

class _MixDemoState extends State<MixDemo> {
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
    final content = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: VBox(
        style: containerStyle,
        children: [
          const _HoverBox(),
          HBox(
            style: lineStyle,
            children: const [
              _PrimaryButton(
                text: 'Primary Large',
                icon: FontAwesomeIcons.hand,
                size: ButtonSize.large,
              ),
              _PrimaryButton(
                text: 'Primary Medium',
                icon: FontAwesomeIcons.hand,
              ),
              _PrimaryButton(
                text: 'Primary Small',
                icon: FontAwesomeIcons.hand,
                size: ButtonSize.small,
              ),
            ],
          ),
          HBox(
            style: lineStyle,
            children: const [
              _SecondaryButton(
                text: 'Secondary Large',
                icon: FontAwesomeIcons.hand,
                size: ButtonSize.large,
              ),
              _SecondaryButton(
                text: 'Secondary Medium',
                icon: FontAwesomeIcons.hand,
              ),
              _SecondaryButton(
                text: 'Secondary Small',
                icon: FontAwesomeIcons.hand,
                size: ButtonSize.small,
              ),
            ],
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

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.text,
    required this.icon,
    this.size = ButtonSize.medium,
  });
  final String text;
  final IconData icon;
  final ButtonSize size;

  @override
  Widget build(BuildContext context) {
    return _ButtonBase(
      text: text,
      icon: icon,
      size: size,
      type: ButtonType.primary,
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.text,
    required this.icon,
    this.size = ButtonSize.medium,
  });
  final String text;
  final IconData icon;
  final ButtonSize size;

  @override
  Widget build(BuildContext context) {
    return _ButtonBase(
      text: text,
      icon: icon,
      size: size,
      type: ButtonType.secondary,
    );
  }
}

class _ButtonBase extends StatelessWidget {
  const _ButtonBase({
    required this.text,
    required this.icon,
    required this.size,
    required this.type,
  });
  final String text;
  final IconData icon;
  final ButtonSize size;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: () {},
      child: HBox(
        style: buttonBaseStyle
            .applyVariant(size, type)
            .animate(duration: const Duration(milliseconds: 200)),
        children: [
          StyledIcon(
            icon,
            style: iconStyle.applyVariant(size, type),
          ),
          StyledText(text),
        ],
      ),
    );
  }
}

class _HoverBox extends StatelessWidget {
  const _HoverBox();

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      child: VBox(
        style: hoverBoxStyle,
        children: [
          const StyledText('Mix'),
          StyledText(
            'Hover me!',
            style: const Style.empty().add($text.style.fontSize(12)),
          ),
        ],
      ),
    );
  }
}
