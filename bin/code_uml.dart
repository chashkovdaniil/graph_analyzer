import 'package:args/args.dart';
import 'package:code_uml/code_uml.dart';
import 'package:code_uml/src/reporter.dart';
import 'package:code_uml/utils.dart';

void main(final List<String> arguments) async {
  const helper = _Helper();

  final argsParser = ArgParser();
  argsParser
    ..addFlag('verbose', abbr: 'v', help: 'More logs', hide: true)
    ..addOption(
      'uml',
      abbr: 'u',
      help: 'Select uml coder',
      defaultsTo: 'plantuml',
      valueHelp: 'plantuml',
      allowed: ['mermaid', 'plantuml'],
    )
    ..addOption('from', abbr: 'f', help: 'Input directory for analyze')
    ..addFlag('help', abbr: 'h')
    ..addOption('to', abbr: 't', help: 'Output file name', defaultsTo: './uml');

  final argsResults = argsParser.parse(arguments);
  if (argsResults.wasParsed('verbose')) {
    Logger().activateVerbose();
  }
  if (argsResults.wasParsed('help')) {
    Logger().regular(helper.helpText(), onlyVerbose: false);
    return;
  }
  final from = argsResults['from'] as String;
  final reportTo = argsResults['to'] as String;

  if (!argsResults.wasParsed('from')) {
    Logger().error('Argument from is empty');
    return;
  }

  final converter = Converter(argsResults['uml'] as String);
  final reporter = Reporter.file(reportTo, converter);
  final analyzer = CodeUml(reporter: reporter, logger: Logger());

  analyzer.analyze(from.split(','));
}

class _Helper {
  const _Helper();

  String helpText() {
    return '''This package will help you create code for UML, and then use it to build a diagram.
📘Usage:
Output to console: code_uml <...directory_for_analysis> [--console]
Output to file: code_uml <...directory_for_analysis> <output_result_file>\n
Global options: 
--to=console \t-\toutput to console
--uml=plantuml \t-\tselect uml tool. One of [mermaid, plantuml]
--verbose \t-\tmore logs''';
  }
}
