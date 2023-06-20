import '../class_def.dart';
import 'converter.dart';

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
