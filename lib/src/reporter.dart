import 'dart:io';

import 'package:path/path.dart' as path;

import '../utils.dart';
import 'class_def.dart';
import 'converters/converter.dart';

abstract class Reporter {
  late Converter converter;
  DiagramCreator? diagramCreator;

  factory Reporter.file(
    final String reportDirPath,
    final Converter converter,
    final DiagramCreator diagramCreator,
  ) =>
      _FileReporter(reportDirPath, converter, diagramCreator);

  factory Reporter.console(
    final Converter converter,
  ) =>
      _ConsoleReporter(converter);

  Future<void> report(final List<ClassDef> text);
}

class _ConsoleReporter implements Reporter {
  @override
  DiagramCreator? diagramCreator;

  @override
  Converter converter;

  _ConsoleReporter(this.converter);

  @override
  Future<void> report(final List<ClassDef> defs) async {
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
  Future<void> report(final List<ClassDef> defs) async {
    final fileExtension = converter.fileExtension;
    final outputTxtFilePath = path.join(reportDirPath, 'output.$fileExtension');
    var file = File(outputTxtFilePath);

    Logger().info('Creating output file...', onlyVerbose: true);
    file = await file.create(recursive: true);

    final ioSink = file.openWrite();

    final text = converter.convertToText(defs);
    ioSink.write(text);
    await ioSink.close();
    Logger().success(
      'Created output file: $outputTxtFilePath',
      onlyVerbose: false,
    );

    diagramCreator?.createFromText(text, outputTxtFilePath);
  }
}
