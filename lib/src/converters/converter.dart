import '../class_def.dart';

abstract class DiagramCreator {
  Future<bool> createFromFile(String resultFilePath);
}

abstract class Converter {
  /// Converts [ClassDef] to uml code
  String convertToText(List<ClassDef> defs);
}
