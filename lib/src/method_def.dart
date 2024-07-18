import 'package:analyzer/dart/ast/ast.dart';

import 'converters/return_type.dart';

/// This class describe method definition
class MethodDef {
  /// Method name
  late final String name;

  /// Type of return value
  late final String returnType;

  /// Is private method?
  late final bool isPrivate;

  /// Is setter?
  late final bool isSetter;

  /// Is getter?
  late final bool isGetter;

  /// Is operator?
  late final bool isOperator;

  MethodDef(final MethodDeclaration declaration) {
    returnType = ReturnTypeConverter(
      declaration.returnType?.toString() ?? 'void',
    ).inUml;
    name = declaration.name.lexeme;
    isGetter = declaration.isGetter;
    isSetter = declaration.isSetter;
    isOperator = declaration.isOperator;
    isPrivate = name.startsWith('_');
  }
}
