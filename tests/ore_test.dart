import 'package:test/test.dart';
import '../task3.dart';

void main() {
  group('Tests for processOre function', () {
    test('Returns an empty list if ore contains no components', () {
      List<String> ore = [
        '............',
        '............',
      ];

      List result = processOre(ore);

      expect(result, isEmpty);
    });

    test('Returns correct components from ore', () {
      List<String> ore = [
        '.::::..::.....::',
        '.::::..::.....::',
        '.::::..::....*.::',
      ];

      List result = processOre(ore);

      expect(result.where((part) => part == '|').length, greaterThan(0));
    });

    test('Throws an exception if ore is empty', () {
      List<String> ore = [];

      expect(() => processOre(ore), throwsA('Where is the ore?'));
    });
  });

  group('Tests for createSmartphones function', () {
    test('Creates the correct number of smartphones from components', () {
      List<String> parts = ['|', '|', '|', '|', '|', '|', '_', '_', '_'];

      List smartphones = createSmartphones(parts);

      expect(smartphones.length, equals(3));
      expect(smartphones, equals(['|_|', '|_|', '|_|']));
    });

    test('Throws an exception if there are not enough components', () {
      List<String> parts = ['|', '_'];

      expect(() => createSmartphones(parts),
          throwsA('Not enough parts even for one smartphone('));
    });

    test('Throws an exception if there are no components', () {
      List<String> parts = [];

      expect(() => createSmartphones(parts),
          throwsA('Not enough parts even for one smartphone('));
    });

    test('Creates the maximum possible number of smartphones from available components', () {
      List<String> parts = ['|', '|', '|', '|', '|', '|', '_', '_'];

      List smartphones = createSmartphones(parts);

      expect(smartphones.length, equals(2));
    });
  });

  group('Integration tests', () {
    test('The full process from ore to smartphones works correctly', () {
      List<String> ore = [
        '::*::*::*::*::*:',
        '::*::*::*::*::*:',
        '*..*..*..*..*..*',
      ];

      List<String> parts = processOre(ore);
      expect(parts.isNotEmpty, isTrue, reason: 'Parts should be found');

      List smartphones = createSmartphones(parts);

      expect(smartphones.length, greaterThan(0),
          reason: 'At least one smartphone should be created');
      expect(smartphones.every((phone) => phone == '|_|'), isTrue);
    });

    test('Handles exception when ore is missing', () {
      List<String> ore = [];

      expect(() => processOre(ore), throwsA(equals('Where is the ore?')));
    });
  });
}
