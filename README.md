# CodeUML

This package will help you create code for PlantUML, and then use it to build a diagram.

## How to use
The first step is to perform the installation:

### Common step
Install Open JDK 17.

Then:
```bash
dart pub global activate code_uml
```

### MacOS
You must have java on your computer

```bash
code_uml <dirs_for_analysis> <dir_where_outputs_files_will_be_saved>
```

### Linux
You must have java on your computer

```bash
code_uml <dirs_for_analysis> <dir_where_outputs_files_will_be_saved>
```

### Windows

NOT IMPLEMENTED

### Console output

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
code_uml /home/user/my_dir_code/first_dir_for_analysis /home/user/my_dir_code/second_dir_for_analysis --console
```

### File
If you want to output the result to a file, then run the command:
```bash
code_uml <...your_path_to_dir> <dir_where_outputs_files_will_be_saved>
```

For example:
```bash
code_uml /home/user/my_dir_code/first_dir  /home/user/documents/uml/
```

#### Example SVG
![UML diagram of Provider.](https://github.com/chashkovdaniil/graph_analyzer/raw/main/example/example_of_provider.svg)
