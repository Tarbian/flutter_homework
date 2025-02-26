import 'dart:io';
import 'dart:math';

const SOUPS = {
  1: 'Борщ',
  2: 'Солянка',
  3: 'Розсольник',
  4: 'Грибний суп',
  5: 'Том Ям',
  6: 'Курячий бульйон',
  7: 'Суп-пюре з гарбуза'
};

const weekDays = [
  'Понеділок',
  'Вівторок',
  'Середа',
  'Четвер',
  'П\'ятниця',
  'Субота',
  'Неділя'
];

const visitors = [
  {'name': 'Вітя', 'favoriteSoup': 1},
  {'name': 'Коля', 'favoriteSoup': 4},
  {'name': 'Алекс', 'favoriteSoup': 7},
];

void main() {
  Random random = Random();
  int mostPopularSoup = -1;
  int maxCount = -1;
  List<int> popularSoups = [];

  int days = getValidIntInput('Введіть кількість днів (1-30):',
      'Некоректне число. Спробуйте ще раз:', 1, 30);
  List<List<int>> soupChoices = getSoupChoices(days);

  Map<int, int> soupCount = analyzeSoupPopularity(soupChoices);

  for (var entry in soupCount.entries) {
    if (entry.value > maxCount) {
      maxCount = entry.value;
      mostPopularSoup = entry.key;
    }
  }

  print('Найпопулярніший суп - ${SOUPS[mostPopularSoup]}!');

  print('\nСтатистика популярності супів:');
  soupCount.forEach((key, value) {
    print('${SOUPS[key]}: $value раз(ів)');
  });

  List<MapEntry<int, int>> sortedSoups = soupCount.entries.toList();

  sortedSoups.sort((a, b) => b.value.compareTo(a.value));

  for (int i = 0; i < sortedSoups.length; i++) {
    popularSoups.add(sortedSoups[i].key);
  }

  print('\nМеню супів на тиждень:');
  for (int i = 0; i < 7; i++) {
    print('${weekDays[i]}: ${SOUPS[popularSoups[i % popularSoups.length]]}');
  }

  print('\nОцінки від відвідувачів:');

  for (int day = 0; day < 7; day++) {
    print('\nДень ${day + 1}:');
    int todaySoup = popularSoups[day % popularSoups.length];

    for (var visitor in visitors) {
      int rating;
      if (visitor['favoriteSoup'] == todaySoup) {
        rating = 6 + random.nextInt(5);
      } else {
        rating = 1 + random.nextInt(10);
      }
      print('Клієнт ${visitor['name']}: $rating');
    }
  }
}

int getValidIntInput(String question, String errorMessage, int min, int max) {
  while (true) {
    print(question);
    try {
      String? input = stdin.readLineSync();
      if (input != null && input.isNotEmpty) {
        int number = int.parse(input);
        if (number >= min && number <= max) {
          return number;
        }
      }
    } catch (e) {}
    print(errorMessage);
  }
}

List<int> getValidSoupNumbers(String question, String errorMessage) {
  while (true) {
    print(question);
    try {
      String? input = stdin.readLineSync();
      if (input != null && input.isNotEmpty) {
        List<int> numbers = [];
        for (String num in input.split(' ')) {
          int soupNumber = int.parse(num);
          if (soupNumber >= 1 && soupNumber <= 7) {
            numbers.add(soupNumber);
          }
        }
        if (numbers.isNotEmpty) {
          return numbers;
        }
      }
    } catch (e) {}
    print(errorMessage);
  }
}

List<List<int>> getSoupChoices(int days) {
  List<List<int>> soupChoices = [];

  for (int i = 0; i < days; i++) {
    List<int> dayChoices = getValidSoupNumbers(
        '\nДень ${i + 1}. Введіть номери супів через пробіл (1-7):',
        'Будь ласка, введіть коректні номери супів (1-7):');
    soupChoices.add(dayChoices);
  }

  print('\nОбрані супи по днях:');
  for (int i = 0; i < soupChoices.length; i++) {
    print('День ${i + 1}: ${soupChoices[i].map((e) => SOUPS[e]).join(", ")}');
  }

  return soupChoices;
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



// Task 4

// Завдання: Суп дня преміум
// Умова:

// Користувач вводить кількість днів 
// 𝑛
// n (не більше 30), протягом яких він записує свій вибір «супу дня». Кількість днів має 
// бути в межах від 1 до 30. Якщо користувач вводить неприпустиму кількість днів, програма
// має попросити його ввести правильне значення.

// Для кожного дня користувач вводить одне або кілька чисел від 1 до 7 (через пробіл), 
// які відповідають певному супу:

// 1 - «Борщ»
// 2 - «Солянка»
// 3 - «Розсольник»
// 4 - «Грибний суп»
// 5 - «Том Ям»
// 6 - «Курячий бульйон»
// 7 - «Суп-пюре з гарбуза»

// Приклад: «1 3» - означає, що на цей день було обрано “Борщ” і “Розсольник”.

// Програма повинна:

// - Вивести список супів, обраних користувачем для кожного дня.

// - Підрахувати, скільки разів був обраний кожен суп за весь період.

// - Показати, який суп був обраний найчастіше.

// - Треба прорекламувати найчастіше обраний суп

// - Треба створити масів меню на кожен день тижня, де будуть використовуватися найбільш популярні супи.

// - Далі треба створити масив відвідувачів, вони люблять або один або інший суп та зробити так, щоб ці відвідувачі
// приходили кожен день та брали суп з меню та ставили оцінку за обслуговування. від 1 до 10 на рандом, 
// але якщо є улюблений суп, то оцінка завжди має бути не менше 6.

// Приклад 

// *обрали супи дня*
// *підбили статистику*
// Наше меню супів на тиждень згідно з уподобань гурмана:
// пн - Борщ
// вт - Грибний суп
// ...

// Ось оцінки від наших відвідувачів:

// День 1:
// Клієнт Вітя 2,
// Клієнт Коля 3,
// Клієнт Алекс 10

// День 2:
// Клієнт Вітя 4,
// Клієнт Коля 7,
// Клієнт Алекс 6
