import 'dart:io';
import 'package:test/test.dart';
import '../task5.dart';

const topwords = 5;
const testEncryptionKey = 5;
const testReportFile = 'test_investigation_report.txt';
void main() {
  test('End-to-end test of encrypted file analyzer', () async {
    final testDir = Directory('TEST_FILES');
    if (testDir.existsSync()) {
      testDir.deleteSync(recursive: true);
    }

    final reportFile = File(testReportFile);
    if (reportFile.existsSync()) {
      reportFile.deleteSync();
    }

    try {
      testDir.createSync();

      final testStrings = [
        "Це тестовий файл із номером телефону +380972223333 для тестування.",
        "Інший тестовий файл із кількома телефонними номерами +380989898989 та +380954566789.",
        "Довший тестовий файл із підозрілими номерами +380966669666 і +380977779777.",
      ];

      for (int i = 0; i < testStrings.length; i++) {
        String fileName = 'test_file_${i + 1}.txt';
        String encryptedContent =
            encryptText(testStrings[i], testEncryptionKey);
        File file = File('${testDir.path}/$fileName');
        file.writeAsStringSync(encryptedContent);
      }

      final results =
          runAnalyzerWithMockInput(testDir, testEncryptionKey, testReportFile);

      expect(results,
          contains('Звіт створено та зашифровано у файл $testReportFile'));

      expect(reportFile.existsSync(), isTrue,
          reason: 'Report file should exist');

      final decryptedReport =
          decryptText(reportFile.readAsStringSync(), testEncryptionKey);
      expect(decryptedReport, contains('Найдовший файл'));
      expect(decryptedReport, contains('Номери телефонів'));
      expect(decryptedReport, contains('+380'));
    } finally {
      if (testDir.existsSync()) {
        testDir.deleteSync(recursive: true);
      }

      if (reportFile.existsSync()) {
        reportFile.deleteSync();
      }
    }
  });
}

// Mock version of the main method
String runAnalyzerWithMockInput(
    Directory testDir, int key, String reportFileName) {
  final output = StringBuffer();

  output.writeln('Знайдена папка з файлами!');
  output.writeln("-------------------------");
  output.writeln('Розшифровую файли');

  Map<String, String> decryptedFiles = decryptFiles(testDir, key);
  Map<String, int> longestTextFile = findLongestTextFile(decryptedFiles);
  Map<String, int> shortestTextFile = findShortestTextFile(decryptedFiles);
  Map<String, int> uniqueWordsInFiles = countUniqueWordsInFiles(decryptedFiles);
  Map<String, int> mostFrequentWord = findMostFrequentWords(decryptedFiles);
  List<String> wordsSortedByLength =
      getUniqueWordsSortedByLength(decryptedFiles);
  Map<String, List<String>> phoneNumbers = findPhoneNumbers(decryptedFiles);
  Map<String, List<String>> SUSphoneNumbers = findSUSPhoneNumbers(phoneNumbers);

  output.writeln("-------------------------");
  output.writeln('Зміст:');
  output.writeln(decryptedFiles);
  output.writeln("-------------------------");
  output.writeln('Найдовший файл (${longestTextFile.values.first} символи):');
  output.writeln(longestTextFile);
  output.writeln("-------------------------");
  output
      .writeln('Найкоротший файл (${shortestTextFile.values.first} символи):');
  output.writeln(shortestTextFile);
  output.writeln("-------------------------");
  output.writeln('Унікальні слова у файлах:');
  output.writeln(uniqueWordsInFiles);
  output.writeln("-------------------------");
  output.writeln('Найчастіше слово:');
  output.writeln(mostFrequentWord.keys.first);
  output.writeln("-------------------------");
  output.writeln('Топ ${topwords} слів за довжиною :');
  try {
    for (var i = 1; i <= topwords; i++) {
      output.writeln("$i - ${wordsSortedByLength[i]}");
    }
  } catch (e) {
    output.writeln("Якась помилка, можливо ключ не вірний.");
  }
  output.writeln("-------------------------");
  output.writeln('Номери телефонів:');
  output.writeln(phoneNumbers);
  output.writeln("-------------------------");
  output.writeln('Підозрілі номери телефонів:');
  output.writeln(SUSphoneNumbers);
  output.writeln("-------------------------");

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

  output.writeln('Звіт створено та зашифровано у файл $reportFileName');

  return output.toString();
}
