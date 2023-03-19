import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_editor/super_editor.dart';

class SuperTextDemo extends StatefulWidget implements DemoWidget {
  const SuperTextDemo({Key? key}) : super(key: key);
  static const String _title = 'SuperText Demo';
  static const String _description = 'Try out SuperText.';

  @override
  State<SuperTextDemo> createState() => _SuperTextDemoState();
  @override
  String get title => SuperTextDemo._title;

  @override
  String get description => SuperTextDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.textSlash);
}

class _SuperTextDemoState extends State<SuperTextDemo> {
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
    const bold = NamedAttribution("bold");
    final title = AttributedText(
      text: 'SuperText Demo',
      spans: AttributedSpans(
        attributions: [
          const SpanMarker(
            attribution: bold,
            offset: 5,
            markerType: SpanMarkerType.start,
          ),
          const SpanMarker(
            attribution: bold,
            offset: 8,
            markerType: SpanMarkerType.end,
          ),
        ],
      ),
    );
    final document = MutableDocument(
      nodes: [
        ParagraphNode(
          id: DocumentEditor.createNodeId(),
          text: title,
        ),
      ],
    );

    final docEditor = DocumentEditor(document: document);
    return SingleChildScrollView(
      child: SuperEditor(
        editor: docEditor,
      ),
    );
  }
}
