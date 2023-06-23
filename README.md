# CodeUML

## How to use
The first step is to perform the installation:
```bash
dart pub global activate code_uml
```

### Console

Then you need to run the command to output the code to the console:
```bash
code_uml [<your_path_to_dir>] --console
```

For example:
```bash
code_uml /home/user/my_dir_code/first_dir  --console
```
or
```bash
code_uml /home/user/my_dir_code/first_dir /home/user/my_dir_code/first_dir --console
```

### File
If you want to output the result to a file, then run the command:
```bash
code_uml [<your_path_to_dir>] <path_output_file>
```

For example:
```bash
code_uml /home/user/my_dir_code/first_dir  /home/user/documents/uml.txt
```

## Converter

### PlantUML

This library supports PlantUML for drawing diagrams so far. 

To convert the result to an svg file, [download this library](https://github.com/plantuml/plantuml/releases), then run the command:

#### Using
You need additional programms:

#### Linux
Open JDK 17

#### Mac Os

```bash
brew install graphviz
```

#### Windows
TODO: fill this

#### Then

```bash
java -jar <path_to_jar_file> <path_your_file_with_uml_code> -svg
```

#### Example SVG
![UML diagram of Provider.](https://github.com/chashkovdaniil/graph_analyzer/raw/main/example/example_of_provider.svg)
