import 'dart:io';

abstract class Reporter {
  factory Reporter.file(String reportFilePath) => FileReporter(reportFilePath);
  factory Reporter.console() => ConsoleReporter();

  void report(String text);
}

class ConsoleReporter implements Reporter {
  @override
  void report(String text) {
    print(text);
  }
}

class FileReporter implements Reporter {
  final String reportFilePath;

  const FileReporter(this.reportFilePath);

  @override
  void report(String text) {
    final file = File(reportFilePath);
    file.createSync();
    var ioSink = file.openWrite();
    ioSink.write(text);
    ioSink.close();
  }
}
