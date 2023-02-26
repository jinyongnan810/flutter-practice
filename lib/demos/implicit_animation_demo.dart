import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImplicitAnimationDemo extends StatefulWidget implements DemoWidget {
  const ImplicitAnimationDemo({Key? key}) : super(key: key);
  static const String _title = 'Implicit Animation Demo';
  static const String _description = 'Scaling image';

  @override
  State<ImplicitAnimationDemo> createState() => _ImplicitAnimationDemoState();
  @override
  String get title => ImplicitAnimationDemo._title;

  @override
  String get description => ImplicitAnimationDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.image);
}

class _ImplicitAnimationDemoState extends State<ImplicitAnimationDemo> {
  bool isScaledDown = true;
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                isScaledDown = !isScaledDown;
              });
            },
            child: Text(isScaledDown ? 'Zoom out' : 'Zoom in'),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 370),
            width: isScaledDown ? 400 : MediaQuery.of(context).size.width,
            curve: Curves.easeInOut,
            child: Image.asset('assets/images/working-out.jpg'),
          ),
        ],
      ),
    );
  }
}
