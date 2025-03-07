import 'dart:io';

const topwords = 5;
const testEncryptionKey = 5;
const maxKey = 10000;
final isPhoneregExp = RegExp(r'\+380\d{9}');
const reportFileName = "investigation_report.txt";

void main() {
  Directory dir = Directory('FILES');
  print('Генерація тестових файлів');
  print("-------------------------");
  genTestFiles(dir);
  print(
      'Тестові файли створено в директорії "FILES" з ключем шифрування: $testEncryptionKey');
  if (!dir.existsSync()) {
    print('Папка з файлами відсутня!');
    return;
  }
  if (dir.listSync().isEmpty) {
    print('Папка порожня!');
    return;
  }
  print("-------------------------");
  print('Знайдена папка з файлами!');
  int key = getValidIntInput('Ведіть ключ для дешифрування (1 - 10000):',
      'Помилка! Введіть число (1 - $maxKey):', 1, maxKey);
  print("-------------------------");
  print('Розшифровую файли');
  Map<String, String> decryptedFiles = decryptFiles(dir, key);
  Map<String, int> longestTextFile = findLongestTextFile(decryptedFiles);
  Map<String, int> shortestTextFile = findShortestTextFile(decryptedFiles);
  Map<String, int> uniqueWordsInFiles = countUniqueWordsInFiles(decryptedFiles);
  Map<String, int> mostFrequentWord = findMostFrequentWords(decryptedFiles);
  List<String> wordsSortedByLength =
      getUniqueWordsSortedByLength(decryptedFiles);
  Map<String, List<String>> phoneNumbers = findPhoneNumbers(decryptedFiles);
  Map<String, List<String>> SUSphoneNumbers = findSUSPhoneNumbers(phoneNumbers);
  print("-------------------------");
  print('Зміст:');
  print(decryptedFiles);
  print("-------------------------");
  print('Найдовший файл (${longestTextFile.values.first} символи):');
  print(longestTextFile);
  print("-------------------------");
  print('Найкоротший файл (${shortestTextFile.values.first} символи):');
  print(shortestTextFile);
  print("-------------------------");
  print('Унікальні слова у файлах:');
  print(uniqueWordsInFiles);
  print("-------------------------");
  print('Найчастіше слово:');
  print(mostFrequentWord.keys.first);
  print("-------------------------");
  print('Топ ${topwords} слів за довжиною :');
  try {
    for (var i = 1; i <= topwords; i++) {
      print("$i - ${wordsSortedByLength[i]}");
    }
  } catch (e) {
    print("Якась помилка, можливо ключ не вірний.");
  }
  print("-------------------------");
  print('Номери телефонів:');
  print(phoneNumbers);
  print("-------------------------");
  print('Підозрілі номери телефонів:');
  print(SUSphoneNumbers);
  print("-------------------------");

  createInvestigationReport(
      longestTextFile: longestTextFile,
      shortestTextFile: shortestTextFile,
      uniqueWordsInFiles: uniqueWordsInFiles,
      mostFrequentWord: mostFrequentWord,
      wordsSortedByLength: wordsSortedByLength,
      phoneNumbers: phoneNumbers,
      SUSphoneNumbers: SUSphoneNumbers,
      topwords: topwords,
      encryptionKey: key,
      file_name: reportFileName);
  print('Звіт створено та зашифровано у файл $reportFileName');
}

void createInvestigationReport({
  required Map<String, int> longestTextFile,
  required Map<String, int> shortestTextFile,
  required Map<String, int> uniqueWordsInFiles,
  required Map<String, int> mostFrequentWord,
  required List<String> wordsSortedByLength,
  required Map<String, List<String>> phoneNumbers,
  required Map<String, List<String>> SUSphoneNumbers,
  required int topwords,
  required int encryptionKey,
  required String file_name,
}) {
  final report = StringBuffer();

  report.writeln('Найдовший файл (${longestTextFile.values.first} символи):');
  report.writeln(longestTextFile);
  report.writeln("-------------------------");

  report
      .writeln('Найкоротший файл (${shortestTextFile.values.first} символи):');
  report.writeln(shortestTextFile);
  report.writeln("-------------------------");

  report.writeln('Унікальні слова у файлах:');
  report.writeln(uniqueWordsInFiles);
  report.writeln("-------------------------");

  report.writeln('Найчастіше слово:');
  report.writeln(mostFrequentWord.keys.first);
  report.writeln("-------------------------");

  report.writeln('Топ ${topwords} слів за довжиною:');
  try {
    for (var i = 1; i <= topwords; i++) {
      report.writeln("$i - ${wordsSortedByLength[i]}");
    }
  } catch (e) {
    report.writeln("Якась помилка, можливо ключ не вірний.");
  }
  report.writeln("-------------------------");

  report.writeln('Номери телефонів:');
  report.writeln(phoneNumbers);
  report.writeln("-------------------------");

  report.writeln('Підозрілі номери телефонів:');
  report.writeln(SUSphoneNumbers);
  report.writeln("-------------------------");

  final encryptedReport = encryptText(report.toString(), encryptionKey);

  final file = File(file_name);
  file.writeAsStringSync(encryptedReport);
}

Map<String, List<String>> findSUSPhoneNumbers(
    Map<String, List<String>> filesWithPhoneNumbers) {
  final suspiciousNumbers = <String, List<String>>{};

  bool isSuspicious(String phoneNumber) {
    final firstThree = phoneNumber.substring(4, 7);
    final lastThree = phoneNumber.substring(10, 13);
    if (firstThree == lastThree) {
      return true;
    }

    final digits = phoneNumber.substring(4);
    if (digits == digits.split('').reversed.join('')) {
      return true;
    }

    return false;
  }

  filesWithPhoneNumbers.forEach((filePath, phoneNumbers) {
    final suspicious =
        phoneNumbers.where((number) => isSuspicious(number)).toList();

    if (suspicious.isNotEmpty) {
      suspiciousNumbers[filePath] = suspicious;
    }
  });

  return suspiciousNumbers;
}

Map<String, List<String>> findPhoneNumbers(Map<String, String> decryptedFiles) {
  final phoneNumbers = <String, List<String>>{};

  decryptedFiles.forEach((filePath, text) {
    final matches = isPhoneregExp.allMatches(text);

    if (matches.isNotEmpty) {
      final numbers = matches.map((match) => match.group(0)!).toList();
      phoneNumbers[filePath] = numbers;
    }
  });

  return phoneNumbers;
}

List<String> getUniqueWordsSortedByLength(Map<String, String> files) {
  final uniqueWords = <String>{};

  files.forEach((filePath, text) {
    final words = text
        .toLowerCase()
        .split(' ')
        .where((word) => !isPhoneregExp.hasMatch(word))
        .map((word) => word.trim())
        .toSet();

    uniqueWords.addAll(words);
  });

  final sortedWords = uniqueWords.toList()
    ..sort((a, b) => b.length.compareTo(a.length));

  return sortedWords;
}

Map<String, int> findMostFrequentWords(Map<String, String> files) {
  final wordCount = <String, int>{};
  final sortedWordCount = <String, int>{};

  files.forEach((filePath, text) {
    text.toLowerCase().split(' ').map((word) => word.trim()).forEach((word) {
      if (word.isNotEmpty) {
        wordCount[word] = (wordCount[word] ?? 0) + 1;
      }
    });
  });

  if (wordCount.isEmpty) return {};

  List<MapEntry<String, int>> entries = wordCount.entries.toList();

  entries.sort((a, b) => b.value.compareTo(a.value));

  for (var entry in entries) {
    sortedWordCount[entry.key] = entry.value;
  }

  return sortedWordCount;
}

Map<String, int> countUniqueWordsInFiles(Map<String, String> files) {
  final uniqueWordCounts = <String, int>{};

  files.forEach((filePath, text) {
    final words = text
        .toLowerCase()
        .split(' ')
        .where((word) => !isPhoneregExp.hasMatch(word))
        .toSet();

    uniqueWordCounts[filePath] = words.length;
  });

  return uniqueWordCounts;
}

Map<String, int> findLongestTextFile(Map<String, String> decryptedFiles) {
  Map<String, int> result = {};

  if (decryptedFiles.isEmpty) {
    return result;
  }

  String longestFilePath = decryptedFiles.keys.first;
  int maxLength = decryptedFiles[longestFilePath]!.length;

  decryptedFiles.forEach((filePath, content) {
    if (content.length > maxLength) {
      maxLength = content.length;
      longestFilePath = filePath;
    }
  });

  result[longestFilePath] = maxLength;
  return result;
}

Map<String, int> findShortestTextFile(Map<String, String> decryptedFiles) {
  Map<String, int> result = {};

  if (decryptedFiles.isEmpty) {
    return result;
  }

  String shortestFilePath = decryptedFiles.keys.first;
  int minLength = decryptedFiles[shortestFilePath]!.length;

  decryptedFiles.forEach((filePath, content) {
    if (content.length < minLength) {
      minLength = content.length;
      shortestFilePath = filePath;
    }
  });

  result[shortestFilePath] = minLength;
  return result;
}

Map<String, String> decryptFiles(Directory dir, int decryptionKey) {
  Map<String, String> decryptedFiles = {};
  int i = 1;
  try {
    List<FileSystemEntity> files = dir.listSync();

    for (FileSystemEntity entity in files) {
      if (entity is File && entity.path.toLowerCase().endsWith('.txt')) {
        String encryptedText = File(entity.path).readAsStringSync();
        String decryptedText = decryptText(encryptedText, decryptionKey);
        decryptedFiles[entity.path] = decryptedText;
        print('${i} Розшифровано: ${entity.path}');
        i++;
      }
    }
  } catch (e) {
    print('Помилка: $e');
  }

  return decryptedFiles;
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

String encryptText(String text, int key) {
  StringBuffer result = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    int charCode = text.codeUnitAt(i);
    int newCharCode = charCode + key;
    result.write(String.fromCharCode(newCharCode));
  }
  return result.toString();
}

String decryptText(String text, int key) {
  StringBuffer result = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    int charCode = text.codeUnitAt(i);
    int newCharCode = charCode - key;
    result.write(String.fromCharCode(newCharCode));
  }
  return result.toString();
}

void genTestFiles(Directory dir) {
  if (!dir.existsSync()) {
    dir.createSync();
  }

  List<String> testStrings = [
    "Цей файл містить короткий секретний запис про проект. Звертайтесь до розробника за номером +380972223333 для отримання деталей. Код доступу змінено.",
    "Оновлені дані проекту знаходяться на сервері бази даних. Доступ можна отримати після підтвердження. Використовуйте захищений протокол. Лабораторія завершила аналіз результатів тестування. Для термінового зв'язку телефонуйте +380989898989 або +380954566789. Алгоритм обробки даних покращено.",
    "СЕКРЕТНИЙ ДОКУМЕНТ. Експеримент з використанням нової ТЕХНОЛОГІЇ завершено успішно. Результати аналізу підтверджують ефективність методу. Команда розробників вдосконалила СИСТЕМУ захисту інформації на основі модульного підходу. Ключові файли заархівовано та зашифровано з використанням алгоритму контролю доступу. Пароль змінено адміністратором мережі. За додатковою інформацією звертайтесь до керівника проекту за номером +380966669666 або до координатора лабораторії +380935557555. Звіт буде оновлено після завершення тестування нових модулів. База даних користувачів перенесена на резервний сервер. ДОКУМЕНТИ проекту доступні в зашифрованому вигляді. Код програми оптимізовано.",
    "Виявлено спробу несанкціонованого доступу до системи. Підозрюється витік даних з IP-адреси 192.168.1.45. Останні активні контакти: Оператор (+380977779777), Адміністратор (+380966966699), Невідомий користувач (+380911119111). Необхідно негайно змінити ключі шифрування та паролі доступу до бази проекту.",
    "Проект проект проект дані дані система система система система інформація інформація база база код. Для контакту використовуйте зашифрований канал зв'язку або телефонуйте за номером +380944944944. Ключ доступу змінюється щодня згідно протоколу безпеки."
  ];

  int encryptionKey = testEncryptionKey;

  for (int i = 0; i < testStrings.length; i++) {
    String fileName = 'file_${i + 1}.txt';
    String encryptedContent = encryptText(testStrings[i], encryptionKey);
    File file = File('FILES/$fileName');
    file.writeAsStringSync(encryptedContent);
  }
}



// Ти - кібердетектив, який розслідує витік даних у секретній лабораторії. 
// У тебе є папка із зашифрованими текстовими файлами, в яких прихована 
// важлива інформація. Потрібно проаналізувати їх, щоб знайти ключові докази 
// і скласти звіт.  
// Треба 
// 1. Розшифрувати файли.
// 2. Знайти файл з найдовшим текстом (максимальна кількість символів).
// Знайти файл з найкоротшим текстом. Визначити кількість унікальних слів
// у кожному файлі.
// 3. Знайти слово, що найчастіше зустрічається серед усіх файлів. 
// Знайти топ-5 найдовших слів.
// Знайти серед цих файлів всі номери телефонів. Перевірити, чи є в файлах
// номери телефонів, які є підозрілими. Підозрілі - це ті, в яких або
// повторюються перші три (після +380) та останні три цифри, а також, 
// де цифри йдуть навхрест (+380989898989)

// 5. Створити новий файл investigation_report.txt. 
// Записати в нього всю зібрану статистику та зашифрувати її.   
// Алгоритм шифрування
// Користувач вводить числовий ключ (наприклад, 5).
// Цей ключ визначає, наскільки будуть змінюватися символи у файлі.
// До кожного символу тексту додається значення ключа в таблиці ASCII.
// Наприклад, якщо літера A (ASCII 65) та ключ 5, новий символ буде F (ASCII 70).
// Якщо символ – пробіл або спеціальний символ, його теж зміщуємо. 
// Алгоритм дешифрування
// Зчитати encrypted.txt.
// Отримати ключ дешифрування від користувача.
// Відняти зсув ASCII-кодів (тобто повернути символи назад).
