import 'dart:io';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;
import 'dart:convert';
import '../task5.dart';

void main() {
  test('End-to-end test of encrypted file analyzer', () async {
    final scriptPath = p.join(Directory.current.path, '../task5.dart');
    final reportFile = File('investigation_report.txt');
    final filesDir = Directory('FILES');

    if (filesDir.existsSync()) {
      filesDir.deleteSync(recursive: true);
    }
    if (reportFile.existsSync()) {
      reportFile.deleteSync();
    }

    final process = await Process.start('dart', [scriptPath]);

    process.stdin.writeln('5');

    final output = await process.stdout.transform(utf8.decoder).join();
    final errors = await process.stderr.transform(utf8.decoder).join();

    final exitCode = await process.exitCode;

    expect(exitCode, 0, reason: 'Program should exit with code 0');
    expect(
        output,
        contains(
            'Звіт створено та зашифровано у файл investigation_report.txt'));

    expect(reportFile.existsSync(), isTrue, reason: 'Report file should exist');

    final decryptedReport = decryptText(reportFile.readAsStringSync(), 5);
    expect(decryptedReport, contains('Найдовший файл'));
    expect(decryptedReport, contains('Номери телефонів'));
    expect(decryptedReport, contains('+380'));

    filesDir.deleteSync(recursive: true);
    reportFile.deleteSync();
  });
}
