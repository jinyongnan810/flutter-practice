import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InheritedWidgetDemo extends StatefulWidget implements DemoWidget {
  const InheritedWidgetDemo({super.key});
  static const String _title = 'Inherited Widget Demo';
  static const String _description =
      'https://docs.flutter.dev/cookbook/networking/web-sockets';

  @override
  State<InheritedWidgetDemo> createState() => _InheritedWidgetDemoState();
  @override
  String get title => InheritedWidgetDemo._title;

  @override
  String get description => InheritedWidgetDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.internetExplorer);
}

class _InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  late final TextEditingController controller;
  String data = "";
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Tester(
      data: data,
      child: Column(
        children: [
          TextField(
            controller: controller,
            onChanged: (value) => setState(() => data = value),
          ),
          const _LayerOne(),
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: content,
      ),
    );
  }
}

class Tester extends InheritedWidget {
  const Tester({
    super.key,
    required super.child,
    required this.data,
  });

  final String data;

  static Tester? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Tester>();
  }

  @override
  bool updateShouldNotify(Tester oldWidget) {
    return data != oldWidget.data;
  }
}

class _LayerOne extends StatelessWidget {
  const _LayerOne();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _LayerTwo(),
        _LayerTwo2(),
      ],
    );
  }
}

class _LayerTwo extends StatelessWidget {
  const _LayerTwo();

  @override
  Widget build(BuildContext context) {
    return Text(Tester.of(context)!.data);
  }
}

class _LayerTwo2 extends StatefulWidget {
  const _LayerTwo2();

  @override
  State<_LayerTwo2> createState() => __LayerTwo2State();
}

class __LayerTwo2State extends State<_LayerTwo2> {
  String data = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = Tester.of(context)!.data;
  }

  @override
  Widget build(BuildContext context) {
    return Text(data);
  }
}
