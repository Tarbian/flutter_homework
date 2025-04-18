import 'ai_generator.dart';
import '../config.dart';

class NewsGenerator extends AIGenerator {
  NewsGenerator({
    String model = Config.defaultmodel,
    Uri? ollamaUrl,
    int maxTokens = Config.newsMaxTokens,
  }) : super(
          model: model,
          ollamaUrl: ollamaUrl ??
              Uri.http('${Config.defaultOllamaIP}:${Config.defaultOllamaPort}', '/api/generate'),
          maxTokens: maxTokens,
        );

  @override
  Future<String> generate(Map<String, dynamic> context) {
    final List<String> events = List<String>.from(context['events'] ?? []);
    final city = context['city'] ?? 'city';
    final day = context['day'] ?? 'this day';

    final prompt = Config.genNewsPromt(city, day, events);

    return sendPrompt(prompt);
  }
}
