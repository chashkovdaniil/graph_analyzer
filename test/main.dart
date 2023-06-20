import 'dart:async';

import 'package:code_uml/code_uml.dart';
import 'package:code_uml/src/reporter.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

final expectedCode = removeBreakLine('''
@startuml
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
-_a(): void
}
E ..|> A
E ..|> D
@enduml
''');

void main() {
  test('Проверка на правильность построения', () {
    String result = '';
    final zoneSpecification = ZoneSpecification(
      print: (self, ZoneDelegate parent, Zone zone, String line) {
        result += line;
      },
    );
    runZoned(
      () {
        final dirPaths = [
          path.absolute('test', 'files_for_test'),
        ];
        final converter = PlantUmlConverter();
        final reporter = Reporter.console(converter);

        final analyzer = CodeUml(reporter: reporter);
        analyzer(dirPaths);
      },
      zoneSpecification: zoneSpecification,
    );
    expect(removeBreakLine(result), expectedCode);
  });
}

String removeBreakLine(String text) => text.replaceAll('\n', '');
