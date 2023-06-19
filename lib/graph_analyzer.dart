import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:graph_analyzer/src/analyzer.dart';

void main(List<String> args) async {
  try {
    var analyzer = GraphAnalyzer();
    analyzer(args);
  } catch (error) {
    print(error.toString());
  }
}
