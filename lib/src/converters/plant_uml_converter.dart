import '../class_def.dart';
import 'converter.dart';

class PlantUmlConverter implements Converter {
  static const _startText = '@startuml';
  static const _finishText = '@enduml';

  @override
  String convertToText(final List<ClassDef> defs) {
    final stringBuffer = StringBuffer('$_startText\n');

    for (final def in defs) {
      stringBuffer.write(def.isAbstract ? 'abstract ' : '');
      stringBuffer.write(convertStartClass(def));
      stringBuffer.write(convertFields(def));
      stringBuffer.write(methodsDivider);
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
          '${method.isPrivate ? privateAccessModifier : publicAccessModifier}'
          '${method.isGetter || method.isSetter ? '«' : ''}'
          '${method.isGetter ? 'get' : ''}'
          '${method.isGetter && method.isSetter ? '/' : ''}'
          '${method.isSetter ? 'set' : ''}'
          '${method.isGetter || method.isSetter ? '»' : ''}'
          '${method.name}(): '
          '${method.returnType}\n');
    }
    return result.toString();
  }

  @override
  String convertFields(final ClassDef def) {
    final result = StringBuffer();
    for (final field in def.fields) {
      result.write(
        '${field.isPrivate ? privateAccessModifier : publicAccessModifier}${field.name}: ${field.type}\n',
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
  final privateAccessModifier = '-';
  @override
  final publicAccessModifier = '+';
}
