import '../class_def.dart';

abstract class Converter {
  /// Converts [ClassDef] to uml code
  String convertToText(List<ClassDef> defs);
}
