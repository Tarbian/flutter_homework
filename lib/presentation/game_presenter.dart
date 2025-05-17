import 'package:Tests/domain/use_cases/get_news_use_case.dart';

class GamePresenter {
  // final GetAllMafiosnicsUseCase getAllMafiosnics;
  // final GenerateDeathQuoteUseCase generateDeathQuote;
  final GetNewsUseCase getNewsUseCase;

  GamePresenter({
    // required this.getAllMafiosnics,
    // required this.generateDeathQuote,
    required this.getNewsUseCase,
  });

  // void showMafiosnicList() {
  //   final mafiosnics = getAllMafiosnics.execute();
  //   print('=== 👥 Команда мафії ===');
  //   for (var m in mafiosnics) {
  //     print(
  //         '${m.name} | Роль: ${m.role.name} | HP: ${m.hp} | Сила: ${m.strength} | IQ: ${m.iq} | Удача: ${m.luck} | Навички: ${m.skill} | Лояльність: ${m.loyalty}');
  //   }
  // }

  // void showDeathQuote() {
  //   final quote = generateDeathQuote.execute();
  //   print('💀 Передсмертна цитата: "$quote"');
  // }

  Future<void> showNews() async {
    final news = await getNewsUseCase.execute();
    print('🗞 Новини: $news');
  }
}
