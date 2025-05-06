import '../domain/use_cases.dart';

class GamePresenter {
  final GetAllMafiosnicsUseCase getAllMafiosnics;
  final GenerateDeathQuoteUseCase generateDeathQuote;
  final GenerateNewsUseCase generateNews;

  GamePresenter({
    required this.getAllMafiosnics,
    required this.generateDeathQuote,
    required this.generateNews,
  });

  void showMafiosnicList() {
    final mafiosnics = getAllMafiosnics.execute();
    print('=== 👥 Команда мафії ===');
    for (var m in mafiosnics) {
      print(
          '${m.name} | Роль: ${m.role.name} | HP: ${m.hp} | Сила: ${m.strength} | IQ: ${m.iq} | Удача: ${m.luck} | Навички: ${m.skill} | Лояльність: ${m.loyalty}');
    }
  }

  void showDeathQuote() {
    final quote = generateDeathQuote.execute();
    print('💀 Передсмертна цитата: "$quote"');
  }

  void showNews() {
    final news = generateNews.execute();
    print('🗞 Новини: $news');
  }
}
