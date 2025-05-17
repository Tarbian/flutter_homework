import 'base/ai_generator.dart';
import '../ai_config.dart';


class NewsGenerator extends AIGenerator {
  NewsGenerator({
    String model = AIConfig.defaultmodel,
    Uri? ollamaUrl,
    int maxTokens = AIConfig.newsMaxTokens,
  }) : super(
          model: model,
          ollamaUrl: ollamaUrl ??
              Uri.http('${AIConfig.defaultOllamaIP}:${AIConfig.defaultOllamaPort}', '/api/generate'),
          maxTokens: maxTokens,
        );

  @override
  Future<String> generate(Map<String, dynamic> context) {
    final List<String> events = List<String>.from(context['events'] ?? []);
    final city = context['city'] ?? 'city';
    final day = context['day'] ?? 'this day';

    final prompt = AIConfig.genNewsPromt(city, day, events);

    return sendPrompt(prompt);
  }
}
