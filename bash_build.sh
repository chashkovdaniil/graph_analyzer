dart run jnigen --config jnigen.yaml
dart run jni:setup -p jni -s src/code_uml
find -name "*.java" > sources.txt
javac @sources.txt