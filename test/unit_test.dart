import 'package:attributed_text/attributed_text.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('find bold test', () {
    const bold = NamedAttribution("bold");
    final attributedString = AttributedText(
      'Attributed Text',
      AttributedSpans(
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
    final boldRange =
        attributedString.getAttributedRange({ExpectedSpans.bold}, 5);
    expect(boldRange, const SpanRange(5, 8));
  });
}
