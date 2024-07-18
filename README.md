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

## Output
### File output
Then you need to run the command to output the code to the console:
```bash
> code_uml --from=[<your_path_to_dir_input>] --to=[<your_path_to_dir_output>]
```

## Example
![UML diagram](https://github.com/chashkovdaniil/graph_analyzer/raw/main/example/example.png)
