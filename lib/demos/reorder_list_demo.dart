import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// https://api.flutter.dev/flutter/material/ReorderableListView-class.html

class ReOrderListDemo extends StatefulWidget implements DemoWidget {
  const ReOrderListDemo({super.key});
  static const String _title = 'Re-Order List';
  static const String _description = '';

  @override
  State<ReOrderListDemo> createState() => _ReOrderListDemoState();
  @override
  String get title => ReOrderListDemo._title;

  @override
  String get description => ReOrderListDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

class _ReOrderListDemoState extends State<ReOrderListDemo> {
  List<String> items = List<String>.generate(30, (index) => 'Item $index');
  // int? draggingIndex;

  @override
  Widget build(BuildContext context) {
    final content = ReorderableListView.builder(
      proxyDecorator: (child, index, animation) {
        final item = items[index];
        final text = '$item (Dragging)';
        return Material(
          child: ListTile(
            key: Key(text),
            title: Text(text),
          ),
        );
      },
      itemBuilder: (context, index) {
        final item = items[index];
        final text = item;
        // final text = item + (draggingIndex == index ? ' (Dragging)' : '');
        // print("draggingIndex: $draggingIndex, index: $index, text: $text");
        return ListTile(
          key: Key(text),
          title: Text(text),
        );
      },
      itemCount: items.length,
      onReorderStart: (index) {
        print('Reorder Start: $index');
        // setState(() {
        //   draggingIndex = index;
        // });
      },
      onReorderEnd: (newIndex) {
        print('Reorder End: $newIndex');
        // setState(() {
        //   draggingIndex = null;
        // });
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
        });
      },
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: content,
    );
  }
}
