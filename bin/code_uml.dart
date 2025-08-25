import 'package:args/args.dart';
import 'package:code_uml/code_uml.dart';
import 'package:code_uml/src/reporter.dart';
import 'package:code_uml/utils.dart';

void main(final List<String> arguments) async {
  final logger = Logger();
  final argsParser = ArgParser();
  argsParser
    ..addFlag('help', abbr: 'h', help: 'Show this help', negatable: false)
    ..addOption(
      'uml',
      abbr: 'u',
      help: 'UML variant',
      defaultsTo: 'plantuml',
      valueHelp: 'uml_variant',
      allowed: ['plantuml', 'mermaid'],
      allowedHelp: {
        'plantuml': 'PlantUML',
        'mermaid': 'Mermaid uml',
      },
    )
    ..addOption(
      'theme',
      abbr: 't',
      help: 'Theme for the UML diagram (must match the selected UML variant)',
      defaultsTo: null,
      valueHelp: 'theme_name',
    )
    ..addMultiOption('input',
        abbr: 'i',
        help: 'Input directories for analysis, '
            'specify multiple with additional -i options',
        valueHelp: 'analysis_dirs',
        defaultsTo: ['./lib'])
    ..addOption('output',
        abbr: 'o',
        help: 'Output directory to save the generate UML file',
        valueHelp: 'output_dir',
        defaultsTo: './uml')
    ..addMultiOption('exclude-files',
        abbr: 'e',
        help: 'Files to exclude from analysis, this will try to match the'
            ' end of the file(s) found in the input directories, '
            'specify multiple with additional -e options',
        valueHelp: 'exclude_files',
        defaultsTo: [])
    ..addFlag('verbose', abbr: 'v', help: 'Verbose output', negatable: false);
  final ArgResults argsResults;
  try {
    argsResults = argsParser.parse(arguments);
  } catch (e) {
    logger.error('Error parsing arguments: $e', onlyVerbose: false);
    logger.info('Usage:\n', onlyVerbose: false);
    logger.regular(argsParser.usage, onlyVerbose: false);
    return;
  }
  if (argsResults.wasParsed('verbose')) {
    logger.activateVerbose();
  }
  if (argsResults.wasParsed('help')) {
    logger.regular('Usage:\n', onlyVerbose: false);
    logger.regular(argsParser.usage, onlyVerbose: false);
    return;
  }
  final input = argsResults['input'] as Iterable<String>;
  final reportTo = argsResults['output'] as String;
  final converter = Converter(argsResults['uml'] as String,
      theme: argsResults['theme'] as String?);
  final reporter = Reporter.file(reportTo, converter);
  final analyzer = CodeUml(reporter: reporter, logger: logger);

  analyzer.analyze(input.toList(growable: false),
      excludeFiles: argsResults['exclude-files'] as List<String>);
}
