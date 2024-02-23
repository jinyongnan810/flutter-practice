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
  static final isLoading = StateProvider.autoDispose<bool>((ref) => false);
  static final result = StateProvider<String?>((ref) => null);
  static final actions = Provider.autoDispose((ref) => _Actions(ref.read));
}

class _Actions {
  final Reader read;
  _Actions(this.read);
  Future<void> generate(String input, GenerativeModel model) async {
    read(GeminiDemoProviders.isLoading.notifier).state = true;
    read(GeminiDemoProviders.result.notifier).state = null;

    final content = [Content.text(input)];
    final result = await model.generateContent(content);

    read(GeminiDemoProviders.result.notifier).state = result.text;
    read(GeminiDemoProviders.isLoading.notifier).state = false;
  }
}
