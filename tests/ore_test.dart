import 'package:test/test.dart';
import 'dart:math';

void main() {
  group('Тести функції processOre', () {
    test('Повертає порожній список, якщо руда не містить компонентів', () {
      List<String> ore = [
        '............',
        '............',
      ];

      List result = processOre(ore);

      expect(result, isEmpty);
    });

    test('Повертає правильні компоненти з руди', () {
      List<String> ore = [
        '.::::..::.....::',
        '.::::..::.....::',
        '.::::..::....*.::',
      ];

      List result = processOre(ore);

      expect(result.where((part) => part == '|').length, greaterThan(0));
    });

    test('Викидає виняток, якщо руда порожня', () {
      List<String> ore = [];

      expect(() => processOre(ore), throwsA('Де руда?'));
    });
  });

  group('Тести функції createSmartphones', () {
    test('Створює правильну кількість смартфонів з компонентів', () {
      List<String> parts = ['|', '|', '|', '|', '|', '|', '_', '_', '_'];

      List smartphones = createSmartphones(parts);

      expect(smartphones.length, equals(3));
      expect(smartphones, equals(['|_|', '|_|', '|_|']));
    });

    test('Викидає виняток, якщо недостатньо компонентів', () {
      List<String> parts = ['|', '_'];

      expect(() => createSmartphones(parts),
          throwsA('Недостатньо детелей для навіть для одного смартфону('));
    });

    test('Викидає виняток, якщо немає компонентів', () {
      List<String> parts = [];

      expect(() => createSmartphones(parts),
          throwsA('Недостатньо детелей для навіть для одного смартфону('));
    });

    test(
        'Створює максимально можливу кількість смартфонів з наявних компонентів',
        () {
      List<String> parts = ['|', '|', '|', '|', '|', '|', '_', '_'];

      List smartphones = createSmartphones(parts);

      expect(smartphones.length, equals(2));
    });
  });
  group('Інтеграційні тести', () {
    test('Повний процес від руди до смартфонів працює коректно', () {
      List<String> ore = [
        '::*::*::*::*::*:',
        '::*::*::*::*::*:',
        '*..*..*..*..*..*',
      ];

      List<String> parts = processOre(ore);
      expect(parts.isNotEmpty, isTrue, reason: 'Частини повинні бути знайдені');

      List smartphones = createSmartphones(parts);

      expect(smartphones.length, greaterThan(0),
          reason: 'Має бути створено хоча б один смартфон');
      expect(smartphones.every((phone) => phone == '|_|'), isTrue);
    });

    test('Обробляє виняток при відсутності руди', () {
      List<String> ore = [];

      expect(() => processOre(ore), throwsA(equals('Де руда?')));
    });
  });
}

List<String> processOre(List<String> ore) {
  if (ore.isEmpty) {
    throw 'Де руда?';
  }

  List<String> parts = [];
  int oneThirdOfUnderscore = 0;

  for (String oreString in ore) {
    for (int i = 0; i < oreString.length - 1; i++) {
      if (oreString[i] == '*' && oreString[i + 1] == '.') {
        oneThirdOfUnderscore++;
        if (oneThirdOfUnderscore == 3) {
          parts.add('_');
          oneThirdOfUnderscore = 0;
        }
        i++;
      } else if (oreString[i] == ':') {
        parts.add('|');
      }
    }
  }

  return parts;
}

List<String> createSmartphones(List<String> parts) {
  int underscoreCount = parts.where((part) => part == '_').length;
  int colonCount = parts.where((part) => part == '|').length;

  int possiblePhones = min(underscoreCount, colonCount ~/ 2);

  if (possiblePhones == 0) {
    throw 'Недостатньо детелей для навіть для одного смартфону(';
  }

  List<String> smartphones = [];
  for (int i = 0; i < possiblePhones; i++) {
    smartphones.add('|_|');
  }

  return smartphones;
}
