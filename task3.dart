import 'dart:math';

void main() {
  List<String> ore = [
    '*.**::::**..*::.*...**.*::',
    '*.**::::**..*::.*...**.*::',
    '*.**::::**..*::.*...**.*::',
  ];

  try {
    List<String> parts = processOre(ore);
    List<String> smartphones = createSmartphones(parts);
    print('${smartphones.join(' ')} - ${smartphones.length} смартфонів');
  } catch (e) {
    print('Помилка: $e');
  }
}

List<String> processOre(List<String> ore) {
  if (ore.isEmpty) {
    throw 'Де руда?';
  }

  List<String> parts = [];
  for (String oreString in ore) {
    for (int i = 0; i < oreString.length - 1; i++) {
      if (oreString[i] == '*' && oreString[i + 1] == '.') {
        parts.add('_');
        i++;
      } else if (oreString[i] == ':') {
        parts.add('|');
      }
    }
  }

  if (parts.isEmpty) {
    throw 'Руди не хватило на делаті(';
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
