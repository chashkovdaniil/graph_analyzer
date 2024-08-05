![Pub Likes](https://img.shields.io/pub/likes/code_uml) ![Pub Points](https://img.shields.io/pub/points/code_uml) ![Pub Popularity](https://img.shields.io/pub/popularity/code_uml)

# CodeUML

A command line tool to generate class uml diagram from dart code.
The tool supports PlantUml and mermaid.

## Unrealized features
- Generics
- Abstract, static methods, fields
- Enumeration
- Global functions, variables

## How to use
The first step is to perform the installation:

```bash
> dart pub global activate code_uml
```

## Selecting a UML service
### PlantUML
```bash
> code_uml --from=[<your_path_to_dir_input>] --to=[<your_path_to_dir_output>] --uml=plantuml
```
### Mermaid
```bash
> code_uml --from=[<your_path_to_dir_input>] --to=[<your_path_to_dir_output>] --uml=mermaid
```
Make to write <your_path_to_dir_input> and <your_path_to_dir_output> with the absolute paths of your input and output directories. On macOS and Linux, you can obtain the absolute path using pwd, and on Windows, you can use cd.

For example, if your project absolute path is /Users/tester/Desktop/your_project_name, the command would be:
```bash
> code_uml --from="/Users/tester/Desktop/your_project_name/lib" --to="/Users/tester/Desktop/your_project_name" --uml=plantuml
```

## Output
### File output
Then you need to run the command to output the code to the console:
```bash
> code_uml --from=[<your_path_to_dir_input>] --to=[<your_path_to_dir_output>]
```

## Example
![UML diagram](https://github.com/chashkovdaniil/graph_analyzer/raw/main/example/example.png)
