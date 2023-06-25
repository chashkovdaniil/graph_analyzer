# Example

Imagine that your code is in the folder: /home/user/source/lib and you want to save the output files to /home/user/Desktop. To generate a diagram for it, you need to run the commands:

```bash
> code_uml /home/user/source/lib /home/user/Desktop
```

At the output you will receive files: /home/user/Desktop/output.txt, /home/user/Desktop/output.svg.


If you have several folders, then list them like this:
```bash
> code_uml /home/user/source/lib /home/user/source_1/lib /home/user/source_2/lib /home/user/Desktop
```