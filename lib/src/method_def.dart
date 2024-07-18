import 'package:analyzer/dart/ast/ast.dart';

import 'converters/return_type.dart';

class MethodDef {
  /// Method name
  late final String name;

  /// Type of return value
  late final String returnType;

  /// Is private method?
  late final bool isPrivate;

  MethodDef(final MethodDeclaration declaration) {
    returnType = ReturnTypeConverter(
      declaration.returnType?.toString() ?? 'void',
    ).inUml;
    name = declaration.name.lexeme;
    isPrivate = name.startsWith('_');
  }
}
