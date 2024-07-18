import '../../code_uml.dart';

abstract class DiagramCreator {
  Future<bool> createFromText(final String text, final String resultFilePath);
}

abstract class Converter {
  /// Private access modifier
  String get privateAccessModifier;

  /// File extension
  String get fileExtension;

  /// Divider between fields and methods
  String get methodsDivider;

  /// Converts start of [ClassDef] to uml code
  String convertStartClass(final ClassDef def);

  /// Converts end of [ClassDef] to uml code
  String convertEndClass(final ClassDef def);

  /// Converts [FieldDef] to uml code
  String convertFields(final ClassDef def);

  /// Converts [MethodDef] to uml code
  String convertMethods(final ClassDef def);

  /// Converts [ClassDef] to uml code
  String convertToText(final List<ClassDef> defs);

  /// Converts 'extends' to uml code
  String convertExtends(final ClassDef classDef);

  /// Convert class dependencies to uml code
  String convertDependencies(final ClassDef def);

  /// Convert implements to uml code
  String convertImplements(final ClassDef def);
}
