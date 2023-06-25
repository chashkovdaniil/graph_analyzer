package dev.dart;

import com.plantuml.api.cheerpj.v1.Svg;
import java.io.IOException;

public class CodeUmlJava {
    public static Object getSvg(String text) throws IOException, InterruptedException {
        return Svg.convert("", text);
    }
}