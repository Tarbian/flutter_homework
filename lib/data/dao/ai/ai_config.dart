class AIConfig {
  static const defaultmodel = 'qwen2.5:0.5b';
  static const deathQuoteMaxTokens = 32;
  static const defaultMaxTokens = 64;
  static const newsMaxTokens = 128;
  static const defaultOllamaPort = '11434';
  static const defaultOllamaIP = 'localhost';
  static const workOllamaIP = 'localhost';

  static String genNewsPromt(String city, String day, List<String> events) {
    return '''
You are a charismatic radio news host in the mafia-controlled city of $city.
Here is a list of notable events that happened on $day:

${events.map((e) => '- $e').join('\n')}

Create a short but vivid daily crime news roundup based on these events.
Write it in a tone that combines seriousness, a touch of dry humor, and a cinematic flair—as if you were telling the latest mafia drama to your loyal radio listeners.
Structure it like a short news quote: 2–4 short sentences.
Keep it engaging and universal.
''';
  }

  static String genDethPromt(String name, String role, String? cause) {
    return '''
You must play the role of a character named $name. His role in the game is $role.
He just died${cause != null ? " because of $cause" : ""}.
Say his last words - emotionally, dramatically, or humorously.
The answer should be short, 1 sentence.
''';
  }
}
