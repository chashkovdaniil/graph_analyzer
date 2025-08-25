import 'field_def.dart';
import 'method_def.dart';

/// This entity describes the class.
///
/// [fields] - class fields
///
/// [methods] - class methods
///
/// [deps] - class dependencies
///
/// [implementsOf] - Interfaces that this class implements
///
/// [extendsOf] - the class from which the current one is inherited
///
/// [isAbstract] - whether the class is abstract
class ClassDef {
  final List<FieldDef> fields = [];
  final List<MethodDef> methods = [];
  final Set<String> deps = {};
  final Set<String> implementsOf = {};

  String name = '';
  String? extendsOf;
  bool isAbstract = false;
  bool isInterface = false;
  bool isMixin = false;
}
