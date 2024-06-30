import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/markdown_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markdown_quill/markdown_quill.dart' as mq;

// to run at ios, rust must be updated to the latest version: https://github.com/singerdmx/flutter-quill/issues/1749#issuecomment-1969313369
class FlutterQuillDemo extends StatefulWidget implements DemoWidget {
  const FlutterQuillDemo({super.key});
  static const String _title = 'Flutter Quill Demo';
  static const String _description = 'https://pub.dev/packages/flutter_quill';

  @override
  State<FlutterQuillDemo> createState() => _FlutterQuillDemoState();
  @override
  String get title => FlutterQuillDemo._title;

  @override
  String get description => FlutterQuillDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.pen);
}

class _FlutterQuillDemoState extends State<FlutterQuillDemo> {
  late final QuillController controller = QuillController.basic();
  late final FocusNode focusNode = FocusNode();
  String markdown = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            showFontFamily: false,
            showBackgroundColorButton: false,
            showColorButton: false,
            showFontSize: false,
            showSearchButton: false,
            showUnderLineButton: false,
            showSubscript: false,
            showSuperscript: false,
            showIndent: false,
            controller: controller,
            buttonOptions: QuillSimpleToolbarButtonOptions(
              base: QuillToolbarBaseButtonOptions(
                afterButtonPressed: () => focusNode.requestFocus(),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: QuillEditor.basic(
              focusNode: focusNode,
              configurations: QuillEditorConfigurations(
                controller: controller,
              ),
            ),
          ),
        ),
        const Divider(),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Markdown'),
                Text(markdown),
              ],
            ),
          ),
        ),
      ],
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: content,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final delta = controller.document.toDelta();
            setState(() {
              markdown = mq.DeltaToMarkdown(
                customEmbedHandlers: {
                  // cspell: disable-next-line
                  EmbeddableTable.tableType: EmbeddableTable.toMdSyntax,
                },
              ).convert(delta);
            });

            // setState(() {
            // });
          },
          child: const FaIcon(FontAwesomeIcons.pen),
        ),
      ),
    );
  }
}
