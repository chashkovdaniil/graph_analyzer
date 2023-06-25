import 'dart:io';

import 'package:jni/jni.dart';
import 'package:path/path.dart' as path;

import '../../code_uml_java.dart';
import '../../utils.dart';
import '../class_def.dart';
import 'converter.dart';

class PlantUmlDiagramCreator implements DiagramCreator {
  @override
  Future<bool> createFromText(String text, String resultFilePath) async {
    final outputDiagramFile = resultFilePath.replaceAll(
      RegExp(r'\..*$'),
      '.svg',
    );
    Logger().info(
      'Creating diagram to $outputDiagramFile...',
      onlyVerbose: true,
    );

    final string = CodeUmlJava.getSvg(JString.fromString(text));
    final svg = string.castTo(JString.type).toDartString();
    final file = File(outputDiagramFile);
    final ioSink = file.openWrite();
    ioSink.write(svg);
    // final processResult = await Process.run(
    //   "bash",
    //   ["-c", "java -jar /$binPath/plantuml.jar $resultFilePath -svg"],
    // );
    // print(processResult.stdout);
    // if ((processResult.stderr as String).isNotEmpty) {
    //   throw Exception(processResult.stderr);
    // }
    // if ((processResult.stdout as String).isEmpty) {}
    Logger().success(
      'Created diagram: $outputDiagramFile',
    );
    ioSink.close();
    return true;
  }

  String get binPath => Platform.script.pathSegments
      .sublist(0, Platform.script.pathSegments.length - 1)
      .join(path.separator);
}

class PlantUmlConverter implements Converter {
  static const _startText = '@startuml';
  static const _finishText = '@enduml';

  @override
  String convertToText(List<ClassDef> defs) {
    var result = '$_startText\n';

    for (final def in defs) {
      result += def.isAbstract ? 'abstract ' : '';

      result += 'class ${def.name} {\n';

      for (var field in def.fields) {
        result += '${field.isPrivate ? '-' : ''}${field.name}: ${field.type}\n';
      }

      result += '---\n';

      for (var method in def.methods) {
        result +=
            '${method.isPrivate ? '-' : ''}${method.name}(): ${method.returnType}\n';
      }

      result += '}\n';

      if (def.extendsOf != null) {
        result += '${def.extendsOf} <|-- ${def.name}\n';
      }
      if (def.deps.isNotEmpty) {
        for (var dep in def.deps) {
          result += '${def.name} ..> $dep\n';
        }
      }
      if (def.implementsOf.isNotEmpty) {
        for (var implementOf in def.implementsOf) {
          result += '${def.name} ..|> $implementOf\n';
        }
      }
    }

    result += _finishText;
    return result;
  }
}
