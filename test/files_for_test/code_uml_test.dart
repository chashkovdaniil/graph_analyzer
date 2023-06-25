// ignore_for_file: unused_element

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

  void _a() {}
}
