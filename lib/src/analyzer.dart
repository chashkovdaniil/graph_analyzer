import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'class_def.dart';
import 'field_def.dart';
import 'method_def.dart';

class GraphAnalyzer {
  List<String> _getFilePathsFromDir(List<String> dirsPath) {
    final files = <String>[];
    for (var dirPath in dirsPath) {
      var dir = Directory(dirPath);
      dir.listSync(recursive: true).forEach((fileEntity) {
        if (fileEntity.statSync().type != FileSystemEntityType.file) {
          return;
        }
        files.add(fileEntity.path);
      });
    }
    return files;
  }

  void call(List<String> dirsPath) {
    if (dirsPath.length == 1) {
      throw Exception('Не указан путь сохранения файла');
    }
    final reportFilePath = dirsPath.last;
    var includedPaths =
        _getFilePathsFromDir(dirsPath.sublist(0, dirsPath.length - 1)).toList();
    var classesDef = <ClassDef>[];
    var collection = AnalysisContextCollection(includedPaths: includedPaths);

    for (var path in includedPaths) {
      var unit = collection.contexts.first.currentSession.getParsedUnit(path);

      if (unit is ParsedUnitResult) {
        for (var unitMember in unit.unit.declarations) {
          if (unitMember is ClassDeclaration) {
            classesDef.add(_analyzeClass(unitMember));
          }
        }
      }
    }

    DIContainer.reporter.report(
      classesDef.map((e) => e.toString()).join('\n'),
      reportFilePath,
    );
  }

  ClassDef _analyzeClass(ClassDeclaration classDeclaration) {
    final extendsOf = classDeclaration.extendsClause?.superclass.name2.lexeme;
    final classDef = ClassDef();
    classDef.name = classDeclaration.name.lexeme;
    classDef.extendsOf = extendsOf;
    for (var member in classDeclaration.members) {
      if (member is MethodDeclaration) {
        classDef.methods.add(_analyzeMethod(member));
      } else if (member is FieldDeclaration) {
        classDef.fields.add(_analyzeField(member));
        classDef.deps.addAll(_analyzeDeps(member));
      }
    }
    return classDef;
  }

  MethodDef _analyzeMethod(MethodDeclaration methodDeclaration) {
    var methodDef = MethodDef();
    methodDef.returnType = methodDeclaration.returnType?.toString() ?? 'void';
    methodDef.name = methodDeclaration.name.lexeme;
    return methodDef;
  }

  FieldDef _analyzeField(FieldDeclaration fieldDeclaration) {
    var fieldDef = FieldDef();
    fieldDef.type = fieldDeclaration.fields.type.toString();
    fieldDef.name = fieldDeclaration.fields.variables.first.toString();
    return fieldDef;
  }

  List<String> _analyzeDeps(FieldDeclaration fieldDeclaration) {
    final result = <String>[];
    final type = fieldDeclaration.fields.type.toString();

    if (_isDep(type)) {
      result.add(type);
    }

    return result;
  }

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
      ].contains(type);
}

abstract class Reporter {
  void report(String text, String reportFilePath);
}

class ConsoleReporter extends Reporter {
  @override
  void report(String text, String _) {
    print(text);
  }
}

class FileReporter extends Reporter {
  @override
  void report(String text, String reportFilePath) {
    final file = File(reportFilePath);
    file.createSync();
    var ioSink = file.openWrite();
    ioSink.write(text);
    ioSink.close();
  }
}

class DIContainer {
  static Reporter get reporter => FileReporter();
  //ConsoleReporter();
}
