import '../entities/game_menu.dart';

void main() async {
  GameMenu menu = GameMenu();
  await menu.start();
}
