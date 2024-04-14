import 'dart:convert';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
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
    const content = _SplitPanels();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: content,
      ),
    );
  }
}

class _SplitPanels extends StatefulWidget {
  const _SplitPanels();

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

  void updateDropPreview(PanelLocation update) {
    setState(() {
      dropPreview = update;
    });
  }

  void setExternalData(String data) {
    setState(() {
      hoveringData = data;
    });
  }

  void drop() {
    assert(dropPreview != null, 'dropPreview is null');
    assert(hoveringData != null, 'hoveringData is null');
    setState(() {
      if (dragStart != null) {
        if (dragStart!.$2 == Panel.upper) {
          upper.removeAt(dragStart!.$1);
        } else {
          lower.removeAt(dragStart!.$1);
        }
      }
      if (dropPreview!.$2 == Panel.upper) {
        upper.insert(min(upper.length, dropPreview!.$1), hoveringData!);
      } else {
        lower.insert(min(lower.length, dropPreview!.$1), hoveringData!);
      }
      dragStart = null;
      dropPreview = null;
      hoveringData = null;
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
              child: _DropRegion(
                updateDropPreview: updateDropPreview,
                onDrop: drop,
                setExternalData: setExternalData,
                childSize: itemSize,
                panel: Panel.upper,
                columns: _columns,
                child: _ItemsPanel(
                  crossAxisCount: _columns,
                  items: upper,
                  spacing: _spacing,
                  onDragStart: onDragStart,
                  panel: Panel.upper,
                  dragStart: dragStart?.$2 == Panel.upper ? dragStart : null,
                  dropPreview:
                      dropPreview?.$2 == Panel.upper ? dropPreview : null,
                  hoveringData: hoveringData,
                ),
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
              child: _DropRegion(
                updateDropPreview: updateDropPreview,
                onDrop: drop,
                setExternalData: setExternalData,
                childSize: itemSize,
                panel: Panel.lower,
                columns: _columns,
                child: _ItemsPanel(
                  crossAxisCount: _columns,
                  items: lower,
                  spacing: _spacing,
                  onDragStart: onDragStart,
                  panel: Panel.lower,
                  dragStart: dragStart?.$2 == Panel.lower ? dragStart : null,
                  dropPreview:
                      dropPreview?.$2 == Panel.lower ? dropPreview : null,
                  hoveringData: hoveringData,
                ),
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
    required this.dragStart,
    required this.dropPreview,
    required this.hoveringData,
  });
  final int crossAxisCount;
  final List<String> items;
  final double spacing;
  final void Function(PanelLocation) onDragStart;
  final Panel panel;
  final PanelLocation? dragStart;
  final PanelLocation? dropPreview;
  final String? hoveringData;

  @override
  Widget build(BuildContext context) {
    final itemsCopy = List<String>.from(items);

    PanelLocation? dragStartCopy;
    PanelLocation? dropPreviewCopy;
    if (dragStart != null) {
      dragStartCopy = dragStart!.copyWith();
    }
    if (dropPreview != null && hoveringData != null) {
      dropPreviewCopy = dropPreview!.copyWith(
        index: min(items.length, dropPreview!.$1),
      );
      if (dragStartCopy?.$2 == dropPreviewCopy.$2) {
        itemsCopy.removeAt(dragStartCopy!.$1);
        dragStartCopy = null;
      }
      itemsCopy.insert(
        min(dropPreviewCopy.$1, itemsCopy.length),
        hoveringData!,
      );
    }
    return GridView.count(
      crossAxisCount: crossAxisCount,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: itemsCopy.asMap().entries.map((entry) {
        final isStartingDrag = entry.key == dragStartCopy?.$1;
        final child = Center(
          child: Text(
            entry.value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: isStartingDrag || entry.key == dropPreviewCopy?.$1
                  ? Colors.grey
                  : Colors.white,
            ),
          ),
        );
        final StatelessWidget decoratedContainer;
        if (entry.key == dragStartCopy?.$1) {
          decoratedContainer = Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: child,
          );
        } else if (entry.key == dropPreviewCopy?.$1) {
          decoratedContainer = DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(20),
            dashPattern: const [10, 10],
            color: Colors.grey,
            strokeWidth: 2,
            child: child,
          );
        } else {
          decoratedContainer = Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: child,
          );
        }
        Container(
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

class _DropRegion extends StatefulWidget {
  const _DropRegion({
    required this.childSize,
    required this.columns,
    required this.panel,
    required this.updateDropPreview,
    required this.onDrop,
    required this.setExternalData,
    required this.child,
  });
  final Size childSize;
  final int columns;
  final Panel panel;
  final void Function(PanelLocation) updateDropPreview;
  final VoidCallback onDrop;
  final void Function(String) setExternalData;
  final Widget child;

  @override
  State<_DropRegion> createState() => __DropRegionState();
}

class __DropRegionState extends State<_DropRegion> {
  int? dropIndex;
  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: Formats.standardFormats,
      onDropOver: (event) {
        _updatePreview(event.position.local);
        return DropOperation.copy;
      },
      onPerformDrop: (event) async {
        widget.onDrop();
      },
      onDropEnter: (event) {
        if (event.session.items.first.dataReader != null) {
          final dataReader = event.session.items.first.dataReader!;
          if (!dataReader.canProvide(Formats.plainTextFile)) {
            return;
          }
          dataReader.getFile(Formats.plainTextFile, (value) async {
            widget.setExternalData(utf8.decode(await value.readAll()));
          });
        }
      },
      child: widget.child,
    );
  }

  void _updatePreview(Offset hoverPosition) {
    final int row = hoverPosition.dy ~/ widget.childSize.height;
    final int column = (hoverPosition.dx - widget.childSize.width / 2) ~/
        widget.childSize.width;
    int newDropIndex = (row * widget.columns) + column;
    if (newDropIndex != dropIndex) {
      dropIndex = newDropIndex;
      widget.updateDropPreview((dropIndex!, widget.panel));
    }
  }
}
