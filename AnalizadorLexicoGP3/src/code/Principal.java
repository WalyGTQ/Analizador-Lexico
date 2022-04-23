package code;

import java.io.File;

public class Principal {

    public static void main(String[] args) {
        String ruta = "C:/Users/walyn/OneDrive/Documentos/NetBeansProjects/AnalizadorLexicoGP3/src/code/Lexer.flex";
        generarLexer(ruta);
    }

    public static void generarLexer(String ruta) {
        File archivo = new File(ruta);
        JFlex.Main.generate(archivo);

    }

}
