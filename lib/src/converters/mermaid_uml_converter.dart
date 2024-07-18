import '../../code_uml.dart';

class MermaidUmlConverter implements Converter {
  MermaidUmlConverter();

  @override
  String convertToText(final List<ClassDef> defs) {
    final stringBuffer = StringBuffer();
    stringBuffer.write('classDiagram\n');

    for (final def in defs) {
      stringBuffer.write(convertStartClass(def));
      stringBuffer.write(def.isAbstract ? '<<abstract>>\n' : '');
      stringBuffer.write(methodsDivider);
      stringBuffer.write(convertFields(def));
      stringBuffer.write(convertMethods(def));
      stringBuffer.write(convertEndClass(def));
      stringBuffer.write(convertExtends(def));
      stringBuffer.write(convertDependencies(def));
      stringBuffer.write(convertImplements(def));
    }

    return stringBuffer.toString();
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
  String convertExtends(final ClassDef classDef) {
    if (classDef.extendsOf != null) {
      return '${classDef.extendsOf} <|-- ${classDef.name}\n';
    }
    return '';
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
  String convertImplements(final ClassDef def) {
    final result = StringBuffer();
    for (final implementOf in def.implementsOf) {
      result.write('${def.name} ..|> $implementOf\n');
    }
    return result.toString();
  }

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
  String convertStartClass(final ClassDef def) {
    final showBrace = def.methods.isNotEmpty;
    return 'class ${def.name} ${showBrace ? '{' : ''}\n';
  }

  @override
  String convertEndClass(final ClassDef def) {
    final showBrace = def.methods.isNotEmpty;
    if (showBrace) {
      return '}\n';
    }
    return '\n';
  }

  @override
  String get fileExtension => 'mmd';

  @override
  String get methodsDivider => '';

  @override
  final privateAccessModifier = '-';

  @override
  final publicAccessModifier = '+';
}
