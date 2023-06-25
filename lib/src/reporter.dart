import 'dart:io';

import 'package:code_uml/utils.dart';
import 'package:path/path.dart' as path;

import 'class_def.dart';
import 'converters/converter.dart';

abstract class Reporter {
  late Converter converter;
  DiagramCreator? diagramCreator;

  factory Reporter.file(
    String reportDirPath,
    Converter converter,
    DiagramCreator diagramCreator,
  ) =>
      _FileReporter(reportDirPath, converter, diagramCreator);

  factory Reporter.console(
    Converter converter,
  ) =>
      _ConsoleReporter(converter);

  Future<void> report(List<ClassDef> text);
}

class _ConsoleReporter implements Reporter {
  @override
  DiagramCreator? diagramCreator;

  @override
  Converter converter;

  _ConsoleReporter(this.converter);

  @override
  Future<void> report(List<ClassDef> defs) async {
    print(converter.convertToText(defs));
  }
}

class _FileReporter implements Reporter {
  @override
  DiagramCreator? diagramCreator;

  final String reportDirPath;
  @override
  Converter converter;

  _FileReporter(this.reportDirPath, this.converter, this.diagramCreator);

  @override
  Future<void> report(List<ClassDef> defs) async {
    var outputTxtFilePath = path.join(reportDirPath, 'output.txt');
    var file = File(outputTxtFilePath);
    Logger().info('Creating output file...', onlyVerbose: true);
    file = await file.create(recursive: true);
    var ioSink = file.openWrite();
    final text = converter.convertToText(defs);
    ioSink.write(text);
    await ioSink.close();
    Logger().success('Created output file: $outputTxtFilePath');
    diagramCreator?.createFromText(text, outputTxtFilePath);
  }
}
