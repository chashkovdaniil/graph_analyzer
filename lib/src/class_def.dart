import 'field_def.dart';
import 'method_def.dart';

/// Этот сущность описывает класс.
///
/// [fields] - поля класса
///
/// [methods] - методы класса
///
/// [deps] - зависимости класса
///
/// [implementsOf] - Интерфейсы, которые реализует данный класс
///
/// [extendsOf] - класс, от которого наследуется текущий
class ClassDef {
  final List<FieldDef> fields = [];
  final List<MethodDef> methods = [];
  final Set<String> deps = {};
  final Set<String> implementsOf = {};

  String name = '';
  String? extendsOf;
  bool isAbstract = false;

  @override
  String toString() {
    var result = isAbstract ? 'abstract ' : '';

    result += 'class $name {\n';

    for (var field in fields) {
      result += '${field.name}: ${field.type}\n';
    }

    result += '---\n';

    for (var method in methods) {
      result += '${method.name}(): ${method.returnType}\n';
    }

    result += '}\n';

    if (extendsOf != null) {
      result += '$extendsOf <|-- $name\n';
    }
    if (deps.isNotEmpty) {
      for (var dep in deps) {
        result += '$name ..> $dep\n';
      }
    }
    if (implementsOf.isNotEmpty) {
      for (var implementOf in implementsOf) {
        result += '$name ..|> $implementOf\n';
      }
    }

    return result;
  }
}
