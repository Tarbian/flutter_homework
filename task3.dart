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

// Task 2

// Треба зробити фабрику з виробництва смартфонів.

// Наша фабрика отримує руду у вигляді масиву зі строк
// [
// ʼ*.**::::**..*::.*…**.*::’ , 
// ʼ*.**::::**..*::.*…**.*::’ ,
// ʼ*.**::::**..*::.*…**.*::’ ,
// ]

// Перший етап обробки руди - це діставання необхідних елементів з неї.

// Нас цікавить:
// *. Та :

// З трьох поєднань *. робиться одна така частина смартфону _

// З двох поєднань : робиться така |

// На виході, треба показати смартфони, що зробила наша фабрика та їх кількість. 

// |_| |_| |_| - 3 смартфони


// Необхідно створити масив руди. Тип даних List<String> та написати логіку її обробки.

// Якщо руди недостатньо для виробництва хоча б одного смартфону, мають бути помилки 

// Задачу треба розбити на функції
