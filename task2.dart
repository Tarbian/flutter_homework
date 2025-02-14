import 'dart:convert';
import 'dart:io';

void main() {
  const String errorNonInt    = "Програма приймає тільки цілі числа!\nСпробуй ще раз:";
  const String errorbadString = "Де текст?\nСпробуй ще раз:";
  const String errorLanguage  = "Оберіть 1 (англійська) або 2 (українська)!\nСпробуй ще раз:";

  const Map<int, String> alphabet = {
    1: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    2: 'АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ'
  };

  const Map<int, Set<String>> vowels = {
    1: {'A', 'E', 'I', 'O', 'U', 'Y'},
    2: {'А', 'Е', 'Є', 'И', 'І', 'Ї', 'О', 'У', 'Ю', 'Я'}
  };

  print('Оберіть мову (1 - англійська, 2 - українська):');
  int languageChoice = getValidIntInput(errorLanguage, [1, 2]);

  print('Введіть рядок:');
  String inputString = getValidStringInput(errorbadString);

  inputString = inputString.toUpperCase();

  print('На яку кількість символів хочете його розбити?');
  int splitLength = getValidIntInput(errorNonInt);

  List<String> parts = splitString(inputString, splitLength);

  print(parts.join('-'));

  for (int i = 0; i < parts.length; i++) {
    int vowelCount = countVowels(parts[i], vowels[languageChoice]!);
    print('\nЧастина ${i + 1} (${parts[i]}):');
    print('Кількість голосних: $vowelCount');
  }

  List<String> coolestPart =
      findCoolestPart(parts, alphabet[languageChoice]!.split(''));
  print('\nНайкрутіші частини: $coolestPart');
}

String getValidStringInput(String errorMessage) {
  while (true) {
    String? input = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
    // баг не читає кирилицю на вінді https://github.com/dart-lang/sdk/issues/47133

    if (input != null && input.isNotEmpty) {
      print('INPUT: $input');
      return input;
    }
    print(errorMessage);
  }
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

List<String> splitString(String input, int splitLength) {
  List<String> result = [];
  for (int i = 0; i < input.length; i += splitLength) {
    if (i + splitLength <= input.length) {
      result.add(input.substring(i, i + splitLength));
    } else {
      String lastPart = input.substring(i);
      while (lastPart.length < splitLength) {
        lastPart += '*';
      }
      result.add(lastPart);
    }
  }
  return result;
}

int countVowels(String text, Set<String> vowels) {
  int count = 0;
  for (var char in text.split('')) {
    if (vowels.contains(char)) {
      count++;
    }
  }
  return count;
}

List<String> findCoolestPart(List<String> parts, List<String> alphabet) {
  int maxScore = -1;
  List<String> coolestParts = [];

  for (String part in parts) {
    int score = 0;
    for (String char in part.split('')) {
      if (char != '*') {
        score += alphabet.indexOf(char) + 1;
      }
    }

    if (score > maxScore) {
      maxScore = score;
      coolestParts = [];
      coolestParts.add(part);
    } else if (score == maxScore) {
      coolestParts.add(part);
    }
  }

  return coolestParts;
}
