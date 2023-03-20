import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:super_editor/super_editor.dart';
import 'package:super_editor/super_editor_test.dart';

// from super_test https://github.com/superlistapp/super_editor/blob/7999ca47704f47f92f668adb17d187d927937e10/super_editor/test/super_textfield/super_textfield_robot.dart
import 'package:flutter/gestures.dart';
// ignore: depend_on_referenced_packages
import 'package:super_text_layout/super_text_layout.dart';

void main() {
  group("SuperText Demo test cursor", () {
    // somehow not working...

    setUp(() async {});
    testWidgets('Test tap in field', (WidgetTester tester) async {
      final controller =
          AttributedTextEditingController(text: AttributedText(text: '--><--'));
      await _pumpSuperTextField(tester, controller);
      await tester.placeCaretInSuperTextField(3);
      await tester.typeImeText('hello');
      expect(SuperTextFieldInspector.findText().text, '-->hello<--');
      expect(
        SuperTextFieldInspector.findSelection(),
        const TextSelection.collapsed(offset: 8),
      );
    });
  });
}

Future<void> _pumpSuperTextField(
  WidgetTester tester,
  AttributedTextEditingController controller,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: SuperTextField(
                textController: controller,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// Extensions on [WidgetTester] for interacting with a [SuperTextField] the way
/// a user would.
extension SuperTextFieldRobot on WidgetTester {
  /// Taps to place a caret at the given [offset].
  ///
  /// {@template supertextfield_finder}
  /// By default, this method expects a single [SuperTextField] in the widget tree and
  /// finds it `byType`. To specify one [SuperTextField] among many, pass a [superTextFieldFinder].
  /// {@endtemplate}
  Future<void> placeCaretInSuperTextField(
    int offset, [
    Finder? superTextFieldFinder,
    TextAffinity affinity = TextAffinity.downstream,
  ]) async {
    final fieldFinder = _findInnerPlatformTextField(
      superTextFieldFinder ?? find.byType(SuperTextField),
    );
    final match = fieldFinder.evaluate().single.widget;
    bool found = false;

    if (match is SuperDesktopTextField) {
      final didTap = await _tapAtTextPositionOnDesktop(
        state<SuperDesktopTextFieldState>(fieldFinder),
        offset,
        affinity,
      );
      if (!didTap) {
        throw Exception(
          "The desired text offset wasn't tappable in SuperTextField: $offset",
        );
      }
      found = true;
    } else if (match is SuperAndroidTextField) {
      final didTap = await _tapAtTextPositionOnAndroid(
        state<SuperAndroidTextFieldState>(fieldFinder),
        offset,
        affinity,
      );
      if (!didTap) {
        throw Exception(
          "The desired text offset wasn't tappable in SuperTextField: $offset",
        );
      }
      found = true;
    } else if (match is SuperIOSTextField) {
      final didTap = await _tapAtTextPositionOnIOS(
        state<SuperIOSTextFieldState>(fieldFinder),
        offset,
        affinity,
      );
      if (!didTap) {
        throw Exception(
          "The desired text offset wasn't tappable in SuperTextField: $offset",
        );
      }
      found = true;
    }

    if (found) {
      // await pumpAndSettle();
    } else {
      throw Exception(
        "Couldn't find a SuperTextField with the given Finder: $fieldFinder",
      );
    }
  }

  /// Double taps in a [SuperTextField] at the given [offset]
  ///
  /// {@macro supertextfield_finder}
  Future<void> doubleTapAtSuperTextField(
    int offset, [
    Finder? superTextFieldFinder,
    TextAffinity affinity = TextAffinity.downstream,
  ]) async {
    final fieldFinder = _findInnerPlatformTextField(
      superTextFieldFinder ?? find.byType(SuperTextField),
    );
    final match = fieldFinder.evaluate().single.widget;

    if (match is SuperDesktopTextField) {
      final superDesktopTextField =
          state<SuperDesktopTextFieldState>(fieldFinder);

      bool didTap = await _tapAtTextPositionOnDesktop(
        superDesktopTextField,
        offset,
        affinity,
      );
      if (!didTap) {
        throw Exception(
          "The desired text offset wasn't tappable in SuperTextField: $offset",
        );
      }
      await pump(kDoubleTapMinTime);

      didTap = await _tapAtTextPositionOnDesktop(
        superDesktopTextField,
        offset,
        affinity,
      );
      if (!didTap) {
        throw Exception(
          "The desired text offset wasn't tappable in SuperTextField: $offset",
        );
      }

      await pumpAndSettle();

      return;
    }

    if (match is SuperAndroidTextField) {
      throw Exception(
        "Entering text on an Android SuperTextField is not yet supported",
      );
    }

    if (match is SuperIOSTextField) {
      throw Exception(
        "Entering text on an iOS SuperTextField is not yet supported",
      );
    }

    throw Exception(
      "Couldn't find a SuperTextField with the given Finder: $fieldFinder",
    );
  }

  Future<bool> _tapAtTextPositionOnDesktop(
    SuperDesktopTextFieldState textField,
    int offset, [
    TextAffinity textAffinity = TextAffinity.downstream,
  ]) async {
    final textFieldBox = textField.context.findRenderObject() as RenderBox;
    return await _tapAtTextPositionInTextLayout(
      textField.textLayout,
      textFieldBox,
      offset,
      textAffinity,
    );
  }

  Future<bool> _tapAtTextPositionOnAndroid(
    SuperAndroidTextFieldState textField,
    int offset, [
    TextAffinity textAffinity = TextAffinity.downstream,
  ]) async {
    final textFieldBox = textField.context.findRenderObject() as RenderBox;
    return await _tapAtTextPositionInTextLayout(
      textField.textLayout,
      textFieldBox,
      offset,
      textAffinity,
    );
  }

  Future<bool> _tapAtTextPositionOnIOS(
    SuperIOSTextFieldState textField,
    int offset, [
    TextAffinity textAffinity = TextAffinity.downstream,
  ]) async {
    final textFieldBox = textField.context.findRenderObject() as RenderBox;
    return await _tapAtTextPositionInTextLayout(
      textField.textLayout,
      textFieldBox,
      offset,
      textAffinity,
    );
  }

  Future<bool> _tapAtTextPositionInTextLayout(
    TextLayout textLayout,
    RenderBox textFieldBox,
    int offset, [
    TextAffinity textAffinity = TextAffinity.downstream,
  ]) async {
    final textPositionOffset = textLayout.getOffsetForCaret(
      TextPosition(offset: offset, affinity: textAffinity),
    );

    // When upgrading Superlist to Flutter 3, some tests showed a caret offset
    // dy of -0.2. This didn't happen everywhere, but it did happen some places.
    // Until we get to the bottom of this issue, we'll add a constant offset to
    // make up for this.
    Offset adjustedOffset = textPositionOffset + const Offset(0, 0.2);

    // There's a problem on Windows and Linux where we get -0.0 instead of 0.0.
    // We adjust the offset to get rid of the -0.0, because a -0.0 fails the
    // Rect bounds check. (https://github.com/flutter/flutter/issues/100033)
    adjustedOffset = Offset(
      adjustedOffset.dx,
      // I tried checking "== -0.0" but it didn't catch the problem. This
      // approach looks for an arbitrarily small epsilon and then interprets
      // any such bounds as zero.
      adjustedOffset.dy.abs() < 1e-6 ? 0.0 : adjustedOffset.dy,
    );

    if (adjustedOffset.dx == textFieldBox.size.width) {
      adjustedOffset += const Offset(-10, 0);
    }

    if (!textFieldBox.size.contains(adjustedOffset)) {
      // ignore: avoid_print
      print(
        "Couldn't tap at $adjustedOffset in text field with size ${textFieldBox.size}",
      );
      return false;
    }

    final globalTapOffset =
        adjustedOffset + textFieldBox.localToGlobal(Offset.zero);
    await tapAt(globalTapOffset);
    return true;
  }

  Future<void> selectSuperTextFieldText(
    int start,
    int end, [
    Finder? superTextFieldFinder,
  ]) async {
    final fieldFinder = _findInnerPlatformTextField(
      superTextFieldFinder ?? find.byType(SuperTextField),
    );
    final match = fieldFinder.evaluate().single.widget;

    if (match is SuperDesktopTextField) {
      final didSelectText = await _selectTextOnDesktop(
        state<SuperDesktopTextFieldState>(fieldFinder),
        start,
        end,
      );
      if (!didSelectText) {
        throw Exception(
          "One or both of the desired text offsets weren't tappable in SuperTextField: $start -> $end",
        );
      }

      // Pump and settle so that the gesture recognizer doesn't retain pending timers.
      await pumpAndSettle();

      return;
    }

    if (match is SuperAndroidTextField) {
      throw Exception(
        "Selecting text on an Android SuperTextField is not yet supported",
      );
    }

    if (match is SuperIOSTextField) {
      throw Exception(
        "Selecting text on an iOS SuperTextField is not yet supported",
      );
    }

    throw Exception(
      "Couldn't find a SuperTextField with the given Finder: $fieldFinder",
    );
  }

  Future<bool> _selectTextOnDesktop(
    SuperDesktopTextFieldState textField,
    int start,
    int end,
  ) async {
    final startTextPositionOffset =
        textField.textLayout.getOffsetForCaret(TextPosition(offset: start));
    final endTextPositionOffset =
        textField.textLayout.getOffsetForCaret(TextPosition(offset: end));
    final textFieldBox = textField.context.findRenderObject() as RenderBox;

    // When upgrading Superlist to Flutter 3, some tests showed a caret offset
    // dy of -0.2. This didn't happen everywhere, but it did happen some places.
    // Until we get to the bottom of this issue, we'll add a constant offset to
    // make up for this.
    Offset adjustedStartOffset = startTextPositionOffset + const Offset(0, 0.2);
    Offset adjustedEndOffset = endTextPositionOffset + const Offset(0, 0.2);

    // There's a problem on Windows and Linux where we get -0.0 instead of 0.0.
    // We adjust the offset to get rid of the -0.0, because a -0.0 fails the
    // Rect bounds check. (https://github.com/flutter/flutter/issues/100033)
    adjustedStartOffset = Offset(
      adjustedStartOffset.dx,
      // I tried checking "== -0.0" but it didn't catch the problem. This
      // approach looks for an arbitrarily small epsilon and then interprets
      // any such bounds as zero.
      adjustedStartOffset.dy.abs() < 1e-6 ? 0.0 : adjustedStartOffset.dy,
    );
    adjustedEndOffset = Offset(
      adjustedEndOffset.dx,
      adjustedEndOffset.dy.abs() < 1e-6 ? 0.0 : adjustedEndOffset.dy,
    );

    if (!textFieldBox.size.contains(adjustedStartOffset)) {
      return false;
    }
    if (!textFieldBox.size.contains(adjustedEndOffset)) {
      return false;
    }

    final globalStartDragOffset =
        adjustedStartOffset + textFieldBox.localToGlobal(Offset.zero);
    final globalEndDragOffset =
        adjustedEndOffset + textFieldBox.localToGlobal(Offset.zero);

    await dragFrom(
      globalStartDragOffset,
      globalEndDragOffset - globalStartDragOffset,
      kind: PointerDeviceKind.mouse,
    );

    return true;
  }

  Finder _findInnerPlatformTextField(Finder rootFieldFinder) {
    final rootMatches = rootFieldFinder.evaluate();
    if (rootMatches.isEmpty) {
      throw Exception(
        "Couldn't find a super text field variant with the given finder: $rootFieldFinder",
      );
    }
    if (rootMatches.length > 1) {
      throw Exception(
        "Found more than 1 super text field match with finder: $rootFieldFinder",
      );
    }

    final rootMatch = rootMatches.single.widget;
    if (rootMatch is! SuperTextField) {
      // The match isn't a generic SuperTextField. Assume that it's a platform
      // specific super text field, which is what we're looking for. Return it.
      return rootFieldFinder;
    }

    final desktopFieldCandidates = find
        .descendant(
          of: rootFieldFinder,
          matching: find.byType(SuperDesktopTextField),
        )
        .evaluate();
    if (desktopFieldCandidates.isNotEmpty) {
      return find.descendant(
        of: rootFieldFinder,
        matching: find.byType(SuperDesktopTextField),
      );
    }

    final androidFieldCandidates = find
        .descendant(
          of: rootFieldFinder,
          matching: find.byType(SuperAndroidTextField),
        )
        .evaluate();
    if (androidFieldCandidates.isNotEmpty) {
      return find.descendant(
        of: rootFieldFinder,
        matching: find.byType(SuperAndroidTextField),
      );
    }

    final iosFieldCandidates = find
        .descendant(
          of: rootFieldFinder,
          matching: find.byType(SuperIOSTextField),
        )
        .evaluate();
    if (iosFieldCandidates.isNotEmpty) {
      return find.descendant(
        of: rootFieldFinder,
        matching: find.byType(SuperIOSTextField),
      );
    }

    throw Exception(
      "Couldn't find the platform-specific super text field within the root SuperTextField. Root finder: $rootFieldFinder",
    );
  }
}

/// Inspects that state of a [SuperTextField] in a test.
class SuperTextFieldInspector {
  /// Finds and returns the [ProseTextLayout] within a [SuperTextField].
  ///
  /// {@macro supertextfield_finder}
  static ProseTextLayout findProseTextLayout([Finder? superTextFieldFinder]) {
    final finder = superTextFieldFinder ?? find.byType(SuperTextField);
    final element = finder.evaluate().single as StatefulElement;
    return (element.state as SuperTextFieldState).textLayout;
  }

  /// Finds and returns the [AttributedText] within a [SuperTextField].
  ///
  /// {@macro supertextfield_finder}
  static AttributedText findText([Finder? superTextFieldFinder]) {
    final finder = superTextFieldFinder ?? find.byType(SuperTextField);
    final element = finder.evaluate().single as StatefulElement;
    final state = element.state as SuperTextFieldState;
    return state.controller.text;
  }

  /// Finds and returns the [TextSelection] within a [SuperTextField].
  ///
  /// {@macro supertextfield_finder}
  static TextSelection? findSelection([Finder? superTextFieldFinder]) {
    final finder = superTextFieldFinder ?? find.byType(SuperTextField);
    final element = finder.evaluate().single as StatefulElement;
    final state = element.state as SuperTextFieldState;
    return state.controller.selection;
  }

  SuperTextFieldInspector._();
}
