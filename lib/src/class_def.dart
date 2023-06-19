import 'field_def.dart';
import 'method_def.dart';

class ClassDef {
  final List<FieldDef> fields = [];
  final List<MethodDef> methods = [];
  final List<String> deps = [];
  final List<String> implementsOf = [];

  String name = '';
  String? extendsOf;

  @override
  String toString() {
    var result = 'class $name {\n';

    for (var field in fields) {
      result += '${field.name}: ${field.type}\n';
    }

    result += '\n---\n';

    for (var method in methods) {
      result += '${method.name}(): ${method.returnType}\n';
    }

    result += '\n}\n';

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
