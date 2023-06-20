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
///
/// [isAbstract] - является ли класс абстрактным
class ClassDef {
  final List<FieldDef> fields = [];
  final List<MethodDef> methods = [];
  final Set<String> deps = {};
  final Set<String> implementsOf = {};

  String name = '';
  String? extendsOf;
  bool isAbstract = false;
}
