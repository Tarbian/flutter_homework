import 'package:Tests/data/dao/ai/ai_config.dart';
import 'base/ai_generator.dart';

class DeathQuoteGenerator extends AIGenerator {
  DeathQuoteGenerator({
    String model = AIConfig.defaultmodel,
    Uri? ollamaUrl,
    int maxTokens = AIConfig.deathQuoteMaxTokens,
  }) : super(
          model: model,
          ollamaUrl: ollamaUrl ??
              Uri.http(
                  '${AIConfig.defaultOllamaIP}:${AIConfig.defaultOllamaPort}',
                  '/api/generate'),
          maxTokens: maxTokens,
        );

  @override
  Future<String> generate(Map<String, dynamic> context) {
    final name = context['characterName'] ?? 'Unknown';
    final role = context['role'] ?? 'Unknown';
    final cause = context['causeOfDeath'];

    final prompt = AIConfig.genDethPromt(name, role, cause);

    return sendPrompt(prompt);
  }
}
