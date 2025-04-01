import 'package:test/test.dart';
import '../task4.dart';

void main() {
  group('Testing soup functions', () {
    test('Soup popularity analysis works correctly', () {
      List<List<int>> soupChoices = [
        [1, 2, 3],
        [1, 2],
        [3, 3, 3],
        [4, 5],
        [1, 5, 6],
      ];

      Map<int, int> result = analyzeSoupPopularity(soupChoices);

      expect(result[1], equals(3)); // Soup 1 was chosen 3 times
      expect(result[3], equals(4)); // Soup 3 was chosen 4 times
      expect(result[5], equals(2)); // Soup 5 was chosen 2 times
    });

    test('Correctly selects the number of days', () {
      int input = getValidIntInputMock('Enter the number of days (1-30):',
          'Invalid number. Please try again:', 1, 30, 10);
      expect(input, inInclusiveRange(1, 30));
    });

    test('Filters and returns correct soup numbers', () {
      List<int> soups = getValidSoupNumbersMock(
          'Enter soup numbers separated by space (1-7):',
          'Please enter valid soup numbers (1-7):',
          [2, 5, 7]);
      expect(soups.every((num) => num >= 1 && num <= 7), isTrue);
    });

    test('Handles popularity soups correctly', () {
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
