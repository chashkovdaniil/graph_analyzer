import '../class_def.dart';

abstract class DiagramCreator {
  Future<bool> createFromText(String text, String resultFilePath);
}

abstract class Converter {
  /// Converts [ClassDef] to uml code
  String convertToText(List<ClassDef> defs);
}
