import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShaderMaskDemo extends StatefulWidget implements DemoWidget {
  const ShaderMaskDemo({super.key});
  static const String _title = 'ShaderMask Demo';
  static const String _description = '';

  @override
  State<ShaderMaskDemo> createState() => _ShaderMaskDemoState();
  @override
  String get title => ShaderMaskDemo._title;

  @override
  String get description => ShaderMaskDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.image);
}

class _ShaderMaskDemoState extends State<ShaderMaskDemo> {
  bool expanded = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static const clipHeight = 300.0;

  @override
  Widget build(BuildContext context) {
    const text1 = Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    );
    final image = Image.asset('assets/images/working-out.jpg', width: 400);
    const text2 = Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    );
    // TODO(kin): check content is overflowed or not then decide whether to show the button
    // TODO(kin): add animation when expanding
    final content = Column(
      children: [
        text1,
        const SizedBox(height: 12),
        image,
        const SizedBox(height: 12),
        text2,
      ],
    );
    final Widget finalContent;
    if (expanded) {
      finalContent = content;
    } else {
      final clipped = SizedBox(
        height: clipHeight,
        child: OverflowBox(
          alignment: Alignment.topCenter,
          maxHeight: double.infinity,
          child: ClipRect(
            clipper: MaxHeightClipper(clipHeight),
            child: content,
          ),
        ),
      );
      final shaderApplied = ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.black, Colors.black, Colors.transparent],
            stops: <double>[0.0, 0.9, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: expanded ? content : clipped,
      );
      finalContent = shaderApplied;
    }

    final showMoreButton = ElevatedButton(
      onPressed: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: Text(expanded ? 'Show Less' : 'Show More'),
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              children: [
                finalContent,
                const SizedBox(height: 12),
                showMoreButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MaxHeightClipper extends CustomClipper<Rect> {
  MaxHeightClipper(this.maxHeight);
  final double maxHeight;
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, maxHeight);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
