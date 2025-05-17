import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../ai_config.dart';

abstract class AIGenerator {
  final String model;
  final Uri ollamaUrl;
  final int maxTokens;

  AIGenerator({
    required this.model,
    required this.ollamaUrl,
    this.maxTokens = AIConfig.defaultMaxTokens,
  });

  Future<String> generate(Map<String, dynamic> context);

  Future<String> sendPrompt(String prompt) async {
    final response = await http.post(
      ollamaUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'model': model,
        'prompt': prompt,
        'stream': false,
        'options': {
          'num_predict': maxTokens,
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response']?.trim() ?? '...';
    } else {
      throw Exception('Помилка генерації: ${response.body}');
    }
  }
}
