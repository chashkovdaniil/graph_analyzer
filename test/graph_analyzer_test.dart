// import 'package:flutter_test/flutter_test.dart';

// import 'package:graph_analyzer/graph_analyzer.dart';

// void main() {
//   test('adds one to input values', () {
//     final calculator = Calculator();
//     expect(calculator.addOne(2), 3);
//     expect(calculator.addOne(-7), -6);
//     expect(calculator.addOne(0), 1);
//   });
// }

class A {
  void a() {}
}

class B extends A {
  String b() => '';
}

class C {
  final A a;

  C(this.a);
}

class D {}

class E implements A, D {
  @override
  void a() {}
}
