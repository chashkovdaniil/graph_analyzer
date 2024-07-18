import 'dart:io';

import 'package:path/path.dart' as path;

import '../class_def.dart';
import 'converter.dart';

class PlantUmlDiagramCreator implements DiagramCreator {
  @override
  Future<bool> createFromText(
      final String text, final String resultFilePath) async {
    // Logger().info('PlantUml file path is $outputDiagramFile');
    //
    // Logger().success(
    //   'Created diagram: $outputDiagramFile',
    //   onlyVerbose: false,
    // );
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
  String convertToText(final List<ClassDef> defs) {
    final stringBuffer = StringBuffer('$_startText\n');

    for (final def in defs) {
      stringBuffer.write(def.isAbstract ? 'abstract ' : '');
      stringBuffer.write(convertStartClass(def));
      stringBuffer.write(methodsDivider);
      stringBuffer.write(convertFields(def));
      stringBuffer.write(convertMethods(def));
      stringBuffer.write(convertEndClass(def));
      stringBuffer.write(convertExtends(def));
      stringBuffer.write(convertDependencies(def));
      stringBuffer.write(convertImplements(def));
    }

    stringBuffer.write(_finishText);
    return stringBuffer.toString();
  }

  @override
  String get fileExtension => 'puml';

  @override
  String convertMethods(final ClassDef def) {
    final result = StringBuffer();
    for (final method in def.methods) {
      result.write(
        '${method.isPrivate ? privateAccessModifier : ''}${method.name}(): ${method.returnType}\n',
      );
    }
    return result.toString();
  }

  @override
  String convertFields(final ClassDef def) {
    final result = StringBuffer();
    for (final field in def.fields) {
      result.write(
        '${field.isPrivate ? privateAccessModifier : ''}${field.name}: ${field.type}\n',
      );
    }
    return result.toString();
  }

  @override
  String convertStartClass(final ClassDef def) => 'class ${def.name} {\n';

  @override
  String convertEndClass(final ClassDef def) => '}\n';

  @override
  String get methodsDivider => '---\n';

  @override
  String convertExtends(final ClassDef classDef) {
    if (classDef.extendsOf != null) {
      return '${classDef.extendsOf} <|-- ${classDef.name}\n';
    }
    return '';
  }

  @override
  String convertDependencies(final ClassDef def) {
    final result = StringBuffer();
    for (final dep in def.deps) {
      result.write('${def.name} ..> $dep\n');
    }
    return result.toString();
  }

  @override
  String convertImplements(final ClassDef def) {
    final result = StringBuffer();
    for (final implementOf in def.implementsOf) {
      result.write('${def.name} ..|> $implementOf\n');
    }
    return result.toString();
  }

  @override
  String get privateAccessModifier => '-';
}
