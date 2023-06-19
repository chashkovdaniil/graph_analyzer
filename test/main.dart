import 'dart:async';

import 'package:graph_analyzer/src/analyzer.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

final expectedCode = removeBreakLine('''
class A {
---
a(): void
}

class B {
---
b(): String
}
A <|-- B

class C {
a: A
---
}
C ..> A

class D {
---
}

class E {
---
a(): void
}
E ..|> A
E ..|> D


''');

void main() {
  final paths = [
    path.absolute('test', 'files_for_test'),
    path.absolute('result.txt')
  ];

  test('Проверка на правильность построения', () {
    String result = '';
    final zoneSpecification = ZoneSpecification(
      print: (self, ZoneDelegate parent, Zone zone, String line) {
        result += line;
      },
    );
    runZoned(
      () {
        GraphAnalyzer()(paths);
      },
      zoneSpecification: zoneSpecification,
    );
    expect(removeBreakLine(result), expectedCode);
  });
}

String removeBreakLine(String text) => text.replaceAll('\n', '');
