import 'package:code_uml/code_uml.dart';
import 'package:code_uml/src/reporter.dart';

void main(List<String> args) {
  final Converter converter = PlantUmlConverter();
  late Reporter reporter;
  List<String> dirPaths = args.sublist(0, args.length - 1);

  if (dirPaths.length == 0) {
    throw Exception(
      'The --console argument'
      ' or '
      'the path to the resulting file is not specified',
    );
  }
  if (args.last == '--console') {
    reporter = Reporter.console(converter);
  } else {
    final reportFilePath = args.last;
    reporter = Reporter.file(reportFilePath, converter);
  }

  final analyzer = CodeUml(reporter: reporter);
  analyzer(dirPaths);
}