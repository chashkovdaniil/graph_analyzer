import 'dart:io';

import 'class_def.dart';
import 'converters/converter.dart';

abstract class Reporter {
  late Converter converter;

  factory Reporter.file(
    String reportFilePath,
    Converter converter,
  ) =>
      _FileReporter(reportFilePath, converter);

  factory Reporter.console(
    Converter converter,
  ) =>
      _ConsoleReporter(converter);

  void report(List<ClassDef> text);
}

class _ConsoleReporter implements Reporter {
  Converter converter;
  _ConsoleReporter(this.converter);

  @override
  void report(List<ClassDef> defs) {
    print(converter.convertToText(defs));
  }
}

class _FileReporter implements Reporter {
  final String reportFilePath;
  Converter converter;

  _FileReporter(this.reportFilePath, this.converter);

  @override
  void report(List<ClassDef> defs) {
    final file = File(reportFilePath);
    file.createSync();
    var ioSink = file.openWrite();
    ioSink.write(converter.convertToText(defs));
    ioSink.close();
  }
}
