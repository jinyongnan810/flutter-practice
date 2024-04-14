import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

typedef Reader = T Function<T>(ProviderListenable<T>);

class GeminiDemoProviders {
  static final geminiModelProvider = Provider.autoDispose(
    (ref) => GenerativeModel(
      model: 'gemini-pro',
      apiKey: dotenv.env['GOOGLE_AI_STUDIO_KEY'] ?? '',
    ),
  );
  static final qas = StateProvider<List<QA>>((ref) {
    ref.listenSelf((previous, next) {});
    return [];
  });
  static final actions = Provider.autoDispose((ref) => _Actions(ref.read));
}

class _Actions {
  final Reader read;
  _Actions(this.read);
  Future<void> generate(String input, GenerativeModel model) async {
    final QA qa = (timestamp: DateTime.now(), question: input, answer: '');
    read(GeminiDemoProviders.qas.notifier).update((state) => [...state, qa]);

    final content = [Content.text(input)];
    final result = await model.generateContent(content);

    read(GeminiDemoProviders.qas.notifier).update((state) {
      return state.map((e) {
        if (e.timestamp == qa.timestamp) {
          return (
            timestamp: e.timestamp,
            question: e.question,
            answer: result.text ?? 'no answer',
          );
        }
        return e;
      }).toList();
    });
  }
}

typedef QA = ({DateTime timestamp, String question, String answer});
