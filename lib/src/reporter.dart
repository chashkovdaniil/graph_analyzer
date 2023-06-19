import 'dart:io';

abstract class Reporter {
  factory Reporter.file() => FileReporter();
  factory Reporter.console() => ConsoleReporter();

  void report(String text, String reportFilePath);
}

class ConsoleReporter implements Reporter {
  @override
  void report(String text, String _) {
    print(text);
  }
}

class FileReporter implements Reporter {
  @override
  void report(String text, String reportFilePath) {
    final file = File(reportFilePath);
    file.createSync();
    var ioSink = file.openWrite();
    ioSink.write(text);
    ioSink.close();
  }
}
