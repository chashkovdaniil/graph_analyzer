import 'package:code_uml/code_uml_java.dart';
import 'package:jni/jni.dart';
import 'package:path/path.dart';

void main() {
  Jni.spawn(
    dylibDir: join('build', 'jni_libs'),
    classPath: ['java', 'java/dev/plantuml'],
  );
}
