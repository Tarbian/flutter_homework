import 'ai_generator.dart';
import '../config.dart';

class DeathQuoteGenerator extends AIGenerator {
  DeathQuoteGenerator({
    String model = Config.defaultmodel,
    Uri? ollamaUrl,
    int maxTokens = Config.deathQuoteMaxTokens,
  }) : super(
          model: model,
          ollamaUrl: ollamaUrl ??
              Uri.http('${Config.defaultOllamaIP}:${Config.defaultOllamaPort}', '/api/generate'),
          maxTokens: maxTokens,
        );

  @override
  Future<String> generate(Map<String, dynamic> context) {
    final name = context['characterName'] ?? 'Unknown';
    final role = context['role'] ?? 'Unknown';
    final cause = context['causeOfDeath'];

    final prompt = Config.genDethPromt(name, role, cause);

    return sendPrompt(prompt);
  }
}
