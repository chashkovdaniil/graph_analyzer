import 'field_def.dart';
import 'method_def.dart';

class ClassDef {
  final List<FieldDef> fields = [];
  final List<MethodDef> methods = [];
  final List<String> deps = [];

  String name = '';
  String? extendsOf;

  @override
  String toString() {
    var result = '''class $name {\n''';

    for (var field in fields) {
      result += '${field.name}: ${field.type}\n';
    }

    result += '''\n---\n''';

    for (var method in methods) {
      result += '${method.name}(): ${method.returnType}\n';
    }

    result += '''
      }
    ''';
    if (extendsOf != null) {
      result += '$extendsOf <|-- $name\n';
    }
    if (deps.isNotEmpty) {
      for (var dep in deps) {
        result += '$name ..> $dep\n';
      }
    }

    return result;
  }
}
