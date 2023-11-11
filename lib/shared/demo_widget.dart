import 'package:flutter/widgets.dart';

abstract class DemoWidget extends Widget {
  const DemoWidget({super.key});
  String get title;
  String get description;
  Widget get icon;
}
