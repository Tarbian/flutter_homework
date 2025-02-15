import 'dart:io';
import 'dart:math';

const maxAttempts = 4;

void main() {
  final position = Random().nextInt(10) + 1;
  int attempt = 0;
  bool hasWon = false;
  
  print("Вгадай де російський корабель!\nВведи число від 1 до 10:");

  while (attempt < maxAttempts && !hasWon) {
    int guess = getValidIntInput(
      "Введіть правильне число від 1 до 10:",
      List.generate(10, (i) => i + 1)
    );
    
    if (guess < position) {
      print("Занадто низько! Спробуй знову.");
    } else if (guess > position) {
      print("Занадто високо! Спробуй знову.");
    } else {
      hasWon = true;
    }
    attempt++;
  }
  
  print(hasWon 
    ? "Вітаю! Ти вгадав, корабель на позиції $position!" 
    : "Спроби вичерпано!\nТи програв :(");
}

int getValidIntInput(String errorMessage, [List<int>? allowedValues]) {
  while (true) {
    try {
      String? input = stdin.readLineSync();
      if (input != null && input.isNotEmpty) {
        int number = int.parse(input);
        if (allowedValues == null || allowedValues.contains(number)) {
          return number;
        }
      }
    } catch (e) {}
    print(errorMessage);
  }
}
