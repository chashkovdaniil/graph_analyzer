import '../../code_uml.dart';

part 'mermaid_uml_converter.dart';
part 'plant_uml_converter.dart';

/// This class converts definitions to uml code
sealed class Converter {
  factory Converter(final String converterType, {final String? theme}) {
    switch (converterType) {
      case 'mermaid':
        return MermaidUmlConverter(theme: theme);
      case 'plantuml':
      default:
        return PlantUmlConverter(theme: theme);
    }
  }

  String? get theme;

  /// Public access modifier
  String get publicAccessModifier;

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
