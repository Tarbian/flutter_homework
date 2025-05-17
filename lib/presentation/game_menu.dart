import 'dart:io';

import 'package:Tests/presentation/game_presenter.dart';

import 'game_initialiser.dart';

class GameMenu {
  late GamePresenter presenter;
  final GameInitialiser gameInitialiser = GameInitialiser();

  bool isRunning = true;
  GameMenu() {
    this.presenter = gameInitialiser.getGamePresenter();
  }

  Future<void> start() async {
    print('\n🎮 Вітаємо у Mafia Empire!');
    print('🌆 Твоє завдання — захопити місто й обійти конкурентів.\n');

    while (isRunning) {
      _printMenu();
      String? input = stdin.readLineSync();

      switch (input) {
        case '1':
          _handleRacket();
          break;
        case '2':
          _handleCaptureObject();
          break;
        case '3':
          await _handleCheckTeam();
          break;
        case '4':
          _handleHealFighter();
          break;
        case '5':
          _handleHireMember();
          break;
        case '6':
          _handleViewMap();
          break;
        case '7':
          _handleNextDay();
          break;
        case '0':
          _exitGame();
          break;
        default:
          print('❗ Невідома команда. Спробуйте ще раз.\n');
      }
    }
  }

  void _printMenu() {
    print('''
===========================
🕹 Дії (обери цифру):

[1] Провести рекет
[2] Захопити об'єкт
[3] Перевірити команду
[4] Вилікувати бійця
[5] Найняти мафіозніка
[6] Переглянути мапу міста
[7] Наступний день >>
[0] Вийти з гри
===========================
''');
    stdout.write('> Вибір: ');
  }

  void _handleRacket() {
    print('\n🔫 [Рекет] — функціонал у розробці...\n');
  }

  void _handleCaptureObject() {
    print('\n🏚 [Захоплення об\'єкта] — функціонал у розробці...\n');
  }

  Future _handleCheckTeam() async {
    print('\n👥 [Команда]:');
    await presenter.showNews();
    print('');
  }

  void _handleHealFighter() {
    print('\n💉 [Лікування бійця] — функціонал у розробці...\n');
  }

  void _handleHireMember() {
    print('\n🤝 [Найм мафіозніка] — функціонал у розробці...\n');
  }

  void _handleViewMap() {
    print('\n🗺 [Мапа міста] — функціонал у розробці...\n');
  }

  void _handleNextDay() {
    print('\n📆 [Наступний день] — функціонал у розробці...\n');
  }

  void _exitGame() {
    stdout.write('\n❓ Ви дійсно хочете вийти з гри? (y/n): ');
    String? confirmation = stdin.readLineSync();

    if (confirmation != null && confirmation.toLowerCase() == 'y') {
      print('\n💀 Гру завершено. До зустрічі у підпіллі!');
      exit(0);
    } else {
      print('\n👍 Добре, продовжуємо гру!');
    }
  }
}
