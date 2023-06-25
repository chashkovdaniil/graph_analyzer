import 'dart:async';
import 'dart:io';

import 'package:code_uml/code_uml.dart';
import 'package:code_uml/src/reporter.dart';
import 'package:code_uml/utils.dart';

void main(List<String> arguments) async {
  const helper = _Helper();
  runZonedGuarded(() {
    final args = arguments.toList();
    if (args.contains('--verbose')) {
      Logger().activateVerbose();
      args.remove('--verbose');
    }
    if (args.isEmpty) {
      throw Exception('No arguments');
    }

    final Converter converter = PlantUmlConverter();
    final reportTo = args.last;
    final outputToConsole = reportTo == '--console';
    final reporter = outputToConsole
        ? Reporter.console(converter)
        : Reporter.file(
            reportTo,
            converter,
            PlantUmlDiagramCreator(),
          );
    final dirPaths = args.sublist(0, args.length - 1);
    final analyzer = CodeUml(
      reporter: reporter,
      logger: Logger(),
    );
    analyzer.analyze(dirPaths);
  }, (e, stackTrace) {
    Logger().error('$e\n\n$stackTrace');
    helper.printHelp();
    exit(64);
  });
}

class _Helper {
  const _Helper();

  void printHelp() {
    print(
      'This package will help you create code for UML, and then use it to build a diagram.\n\n'
      '📘HELP\n'
      'Usage:\n'
      'Output to console: code_uml <...directory_for_analysis> [--console]\n'
      'Output to file: code_uml <...directory_for_analysis> <output_result_file>\n'
      '\n'
      'Global options: \n'
      '--console \t-\toutput to console',
    );
  }
}
