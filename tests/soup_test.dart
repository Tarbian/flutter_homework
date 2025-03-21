import 'package:test/test.dart';

void main() {
  group('Тестування функцій супів', () {
    test('Аналіз популярності супів працює коректно', () {
      List<List<int>> soupChoices = [
        [1, 2, 3],
        [1, 2],
        [3, 3, 3],
        [4, 5],
        [1, 5, 6],
      ];

      Map<int, int> result = analyzeSoupPopularity(soupChoices);

      expect(result[1], equals(3)); // Суп 1 вибрали 3 рази
      expect(result[3], equals(4)); // Суп 3 вибрали 4 рази
      expect(result[5], equals(2)); // Суп 5 вибрали 2 рази
    });

    test('Коректно вибирає кількість днів', () {
      int input = getValidIntInputMock('Введіть кількість днів (1-30):',
          'Некоректне число. Спробуйте ще раз:', 1, 30, 10);
      expect(input, inInclusiveRange(1, 30));
    });

    test('Фільтрує та повертає коректні номери супів', () {
      List<int> soups = getValidSoupNumbersMock(
          'Введіть номери супів через пробіл (1-7):',
          'Будь ласка, введіть коректні номери супів (1-7):',
          [2, 5, 7]);
      expect(soups.every((num) => num >= 1 && num <= 7), isTrue);
    });

    test('Обробляє популярні супи правильно', () {
      Map<int, int> soupCount = {1: 5, 2: 3, 3: 7, 4: 2};
      List<MapEntry<int, int>> sortedSoups = soupCount.entries.toList();
      sortedSoups.sort((a, b) => b.value.compareTo(a.value));

      expect(sortedSoups.first.key, equals(3));
    });
  });
}

int getValidIntInputMock(
    String question, String errorMessage, int min, int max, int mockInput) {
  if (mockInput >= min && mockInput <= max) {
    return mockInput;
  }
  throw ArgumentError(errorMessage);
}

List<int> getValidSoupNumbersMock(
    String question, String errorMessage, List<int> mockInput) {
  if (mockInput.every((num) => num >= 1 && num <= 7)) {
    return mockInput;
  }
  throw ArgumentError(errorMessage);
}

Map<int, int> analyzeSoupPopularity(List<List<int>> soupChoices) {
  Map<int, int> soupCount = {};

  for (var dayChoices in soupChoices) {
    for (var soup in dayChoices) {
      soupCount[soup] = (soupCount[soup] ?? 0) + 1;
    }
  }

  return soupCount;
}
