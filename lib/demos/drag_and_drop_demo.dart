import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

enum Panel { upper, lower }

typedef PanelLocation = (int, Panel);

extension CopyablePanelLocation on PanelLocation {
  PanelLocation copyWith({int? index, Panel? panel}) {
    return (index ?? this.$1, panel ?? this.$2);
  }
}

class DragAndDropDemo extends StatefulWidget implements DemoWidget {
  const DragAndDropDemo({super.key});
  static const String _title = 'Drag&Drop Demo';
  static const String _description =
      'https://youtu.be/c6BPtrU0M7I?si=0WW_Fm0YqbIOnik_';

  @override
  State<DragAndDropDemo> createState() => _DragAndDropDemoState();
  @override
  String get title => DragAndDropDemo._title;

  @override
  String get description => DragAndDropDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.handDots);
}

class _DragAndDropDemoState extends State<DragAndDropDemo> {
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
    return const _SplitPanels();
  }
}

class _SplitPanels extends StatefulWidget {
  const _SplitPanels({super.key});

  @override
  State<_SplitPanels> createState() => __SplitPanelsState();
}

class __SplitPanelsState extends State<_SplitPanels> {
  final _columns = 5;
  final _spacing = 4.0;
  final List<String> upper = [];
  final List<String> lower = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];

  PanelLocation? dragStart;
  PanelLocation? dropPreview;
  String? hoveringData;

  void onDragStart(PanelLocation start) {
    final data = switch (start.$2) {
      Panel.lower => lower[start.$1],
      Panel.upper => upper[start.$1],
    };
    setState(() {
      dragStart = start;
      hoveringData = data;
    });
  }

  void updateDrapPreview(PanelLocation update) {
    setState(() {
      dropPreview = update;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final gutters = _columns + 1;
        final spaceForColumns = constraints.maxWidth - _spacing * gutters;
        final columnWidth = spaceForColumns / _columns;
        final itemSize = Size(columnWidth, columnWidth);
        return Stack(
          children: [
            Positioned(
              height: constraints.maxHeight / 2,
              width: constraints.maxWidth,
              top: 0,
              child: _ItemsPanel(
                crossAxisCount: _columns,
                items: upper,
                spacing: _spacing,
                onDragStart: onDragStart,
                panel: Panel.upper,
              ),
            ),
            Positioned(
              height: 2,
              width: constraints.maxWidth,
              top: constraints.maxHeight / 2,
              child: const ColoredBox(color: Colors.purple),
            ),
            Positioned(
              height: constraints.maxHeight / 2,
              width: constraints.maxWidth,
              top: constraints.maxHeight / 2 + 2,
              child: _ItemsPanel(
                crossAxisCount: _columns,
                items: lower,
                spacing: _spacing,
                onDragStart: onDragStart,
                panel: Panel.lower,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ItemsPanel extends StatelessWidget {
  const _ItemsPanel({
    required this.crossAxisCount,
    required this.items,
    required this.spacing,
    required this.onDragStart,
    required this.panel,
  });
  final int crossAxisCount;
  final List<String> items;
  final double spacing;
  final void Function(PanelLocation) onDragStart;
  final Panel panel;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: items.asMap().entries.map((entry) {
        final child = Center(
          child: Text(
            entry.value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
        final decoratedContainer = Container(
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: child,
        );
        return Draggable(
          feedback: child,
          child: _DraggableWidget(
            data: entry.value,
            child: decoratedContainer,
            onDragStart: () {
              onDragStart((entry.key, panel));
            },
          ),
        );
      }).toList(),
    );
  }
}

class _DraggableWidget extends StatelessWidget {
  const _DraggableWidget({
    super.key,
    required this.data,
    required this.child,
    required this.onDragStart,
  });
  final String data;
  final Widget child;
  final VoidCallback onDragStart;

  @override
  Widget build(BuildContext context) {
    return DragItemWidget(
      child: DraggableWidget(
        child: child,
      ),
      dragItemProvider: (request) {
        onDragStart();
        final item = DragItem(localData: data);
        return item;
      },
      allowedOperations: () => [DropOperation.copy],
      dragBuilder: (context, child) => Opacity(
        opacity: 0.8,
        child: child,
      ),
    );
  }
}
