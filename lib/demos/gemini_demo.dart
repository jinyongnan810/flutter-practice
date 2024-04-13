import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_practice/demos/gemini_demo_providers.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    final qas = ref.watch(_Providers.qas);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children:
                    qas.map((qa) => _QAItem(qa: qa)).toList(growable: false),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: TextField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Ask me anything',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    ref
                        .read(_Providers.actions)
                        .generate(controller.text, model);
                    controller.clear();
                  },
                ),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                ref.read(_Providers.actions).generate(value, model);
                controller.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _QAItem extends ConsumerWidget {
  const _QAItem({required this.qa});
  final QA qa;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          qa.question,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        qa.answer.isEmpty
            ? const Text('Thinking...')
            : MarkdownBody(
                data: qa.answer,
                selectable: true,
                onTapLink: (text, href, title) {
                  if (href != null) {
                    launchUrlString(href);
                  }
                },
              ),
        const Divider(),
      ],
    );
  }
}
