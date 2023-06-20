import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'class_def.dart';
import 'field_def.dart';
import 'method_def.dart';
import 'reporter.dart';

/// Analyzes the code and turns it into uml code
///
/// [reporter] - the entity that outputs the result
class CodeUml {
  final Reporter reporter;

  CodeUml({required this.reporter});

  /// Retrieves files from the specified directories
  List<String> _getFilePathsFromDir(List<String> dirsPath) {
    final files = <String>[];
    for (final dirPath in dirsPath) {
      final dir = Directory(dirPath);

      dir.listSync(recursive: true).forEach((fileEntity) {
        if (fileEntity.statSync().type != FileSystemEntityType.file ||
            !fileEntity.path.endsWith('.dart')) {
          return;
        }
        files.add(fileEntity.path);
      });
    }
    return files;
  }

  void call(List<String> dirsPath) {
    if (dirsPath.length < 1) {
      throw Exception('Directories are not specified');
    }
    final includedPaths = _getFilePathsFromDir(dirsPath).toList();
    final classesDef = <ClassDef>[];
    final collection = AnalysisContextCollection(includedPaths: includedPaths);

    for (final path in includedPaths) {
      final unit = collection.contexts.first.currentSession.getParsedUnit(path);

      if (unit is ParsedUnitResult) {
        for (final unitMember in unit.unit.declarations) {
          if (unitMember is ClassDeclaration) {
            final analyzedClass = _analyzeClass(unitMember);
            classesDef.add(analyzedClass);
          }
        }
      }
    }

    reporter.report(classesDef);
  }

  /// Analyzes a class for methods, fields, inheritance, implementations, and dependencies
  ClassDef _analyzeClass(ClassDeclaration classDeclaration) {
    final extendsOf = classDeclaration.extendsClause?.superclass.name2.lexeme;
    final implementsOf = classDeclaration.implementsClause?.interfaces
            .map((e) => e.name2.lexeme)
            .toList() ??
        [];
    final classDef = ClassDef();
    classDef.name = classDeclaration.name.lexeme;
    classDef.extendsOf = extendsOf;
    classDef.isAbstract = classDeclaration.abstractKeyword != null;
    classDef.implementsOf.addAll(implementsOf);
    for (final member in classDeclaration.members) {
      if (member is MethodDeclaration) {
        classDef.methods.add(_analyzeMethod(member));
      } else if (member is FieldDeclaration) {
        classDef.fields.add(_analyzeField(member));
        classDef.deps.addAll(_analyzeDeps(member));
      }
    }
    return classDef;
  }

  /// Analyzes a method
  MethodDef _analyzeMethod(MethodDeclaration methodDeclaration) {
    final methodDef = MethodDef();
    methodDef.returnType = methodDeclaration.returnType?.toString() ?? 'void';
    methodDef.name = methodDeclaration.name.lexeme;
    methodDef.isPrivate = methodDef.name.startsWith('_');
    return methodDef;
  }

  /// Analyzes a class field
  FieldDef _analyzeField(FieldDeclaration fieldDeclaration) {
    final fieldDef = FieldDef();
    fieldDef.type = fieldDeclaration.fields.type.toString();
    fieldDef.name = fieldDeclaration.fields.variables.first.name.lexeme;
    fieldDef.isPrivate = fieldDef.name.startsWith('_');
    return fieldDef;
  }

  /// Analyzes dependencies
  Set<String> _analyzeDeps(FieldDeclaration fieldDeclaration) {
    final result = <String>{};
    var type = fieldDeclaration.fields.type.toString();

    if (type.endsWith('?')) {
      type = type.replaceAll('?', '');
    }

    if (type.contains('<')) {
      type = type.replaceAll(RegExp(r'<.*>'), '');
    }

    if (_isDep(type)) {
      result.add(type);
    }

    return result;
  }

  /// Determines whether the data type is a dependency. It is a dependency if it is not a base type
  bool _isDep(String type) =>
      !type.startsWith('List') &&
      !type.startsWith('Map') &&
      !type.startsWith('Set') &&
      ![
        'String',
        'int',
        'double',
        'num',
        'String?',
        'int?',
        'double?',
        'num?',
        'Object',
        'Object?',
        'dynamic',
        'bool',
        'bool?',
        'null',
        'Symbol',
        'Symbol?',
      ].contains(type) &&
      !type.contains(' ');
}
