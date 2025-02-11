import 'dart:io';
import 'dart:math';

void main() {
  const maxAttempts = 4;
  final posisiton = Random().nextInt(10) + 1;
  int attempt = 0;
  String result = "Спроби вичерпано!\nТи програв :(";

  print("Вгадай де російський корабель!\nВведи число від 1 до 10:");

  while (attempt < maxAttempts) {
    String? input = stdin.readLineSync();
    if (input == '' || input == null) {
      print("А де цифри?");
    } else {
      try {
        int? quess = int.parse(input);
        if (quess < 1 || quess > 10) {
          print("Число має бути у діапазоні 1 - 10");
        } else if (quess < posisiton) {
          print("Занадто низько! Спробуй знову.");
          attempt++;
        } else if (quess > posisiton) {
          print("Занадто високо! Спробуй знову.");
          attempt++;
        } else if (quess == posisiton) {
          result = "Вітаю! Ти вгадав, корабель на позиції $posisiton!";
          break;
        }
      } on FormatException {
        print("Програма приймає тільки цілі числа!\nСпробуй ще раз:");
      }
    }
  }
  print(result);
}
