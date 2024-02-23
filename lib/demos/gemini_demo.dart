import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_practice/demos/gemini_demo_providers.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef _Providers = GeminiDemoProviders;

class GeminiDemo extends ConsumerStatefulWidget implements DemoWidget {
  const GeminiDemo({super.key});
  static const String _title = 'Gemini Demo';
  static const String _description =
      'https://pub.dev/packages/google_generative_ai';

  @override
  ConsumerState<GeminiDemo> createState() => _GeminiDemoState();
  @override
  String get title => GeminiDemo._title;

  @override
  String get description => GeminiDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.robot);
}

class _GeminiDemoState extends ConsumerState<GeminiDemo> {
  late final TextEditingController controller;
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
    final model = ref.watch(_Providers.geminiModelProvider);
    final isLoading = ref.watch(_Providers.isLoading);
    final result = ref.watch(_Providers.result);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: TextField(
            minLines: 1,
            maxLines: 3,
            controller: controller,
            onSubmitted: (value) {
              ref.read(_Providers.actions).generate(value, model);
            },
          ),
        ),
        if (isLoading) const Text("Thinking..."),
        Expanded(child: Markdown(data: result ?? '')),
      ],
    );
  }
}
