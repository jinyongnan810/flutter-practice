import 'package:flutter_test/flutter_test.dart';
import 'package:super_editor/super_editor.dart';

import 'package:mockito/mockito.dart';

class FakeDocumentLayout with Mock implements DocumentLayout {}

void main() {
  test("from text node (inclusive) to text node (partial)", () {
    // test multiple class working together
    final document = MutableDocument(
      nodes: [
        ParagraphNode(
          id: "1",
          text: AttributedText(
            text: 'This is a blockquote!',
          ),
        ),
        ParagraphNode(
          id: "2",
          text: AttributedText(
            text:
                'Cras vitae sodales nisi. Vivamus dignissim vel purus vel aliquet. Sed viverra diam vel nisi rhoncus pharetra. Donec gravida ut ligula euismod pharetra. Etiam sed urna scelerisque, efficitur mauris vel, semper arcu. Nullam sed vehicula sapien. Donec id tellus volutpat, eleifend nulla eget, rutrum mauris.',
          ),
        ),
      ],
    );
    final editor = DocumentEditor(document: document);
    final composer = DocumentComposer(
      initialSelection: const DocumentSelection(
        base: DocumentPosition(
          nodeId: "1",
          nodePosition: TextNodePosition(offset: 0),
        ),
        extent: DocumentPosition(
          nodeId: "2",
          nodePosition: TextNodePosition(offset: 50),
        ),
      ),
    );
    final commonOps = CommonEditorOperations(
      editor: editor,
      composer: composer,
      documentLayoutResolver: () => FakeDocumentLayout(),
    );

    commonOps.deleteSelection();

    final doc = editor.document;
    expect(doc.nodes.length, 1);
    expect(doc.nodes.first.id, "2");
    expect(composer.selection!.extent.nodeId, "2");
    expect(
      composer.selection!.extent.nodePosition,
      const TextNodePosition(offset: 0),
    );
  });
}
