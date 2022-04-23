package code;
import static code.Tokens.*;
%%
%class Lexer
%type Tokens
%line
%column
%unicode 

L=[a-zA-Z_ñÑ]+
D=[0-9]+
S=[\- | \_ | \. | \:   | \; | \+  | \# | \$ | \%  | \/ | \( | \)  | ","| \[ | \] | \{ | \}]
espacio=[ ,\t,\r,\n]+
%{
    public String lexeme;
    public int linea;
    public int columna;
%}
%%
//Palabras reservadas
break | case| catch |continue| default| delete| do|
else| finally| for|function| if|in| instanceof| new|
return| switch| this| throw| try| typeof| var| void|
while| with|class|const|debugger|export|extends|import|
super | yield |enum {linea=yyline; columna=yycolumn; lexeme=yytext();return Palabra_Reservada;}
null {linea=yyline; columna=yycolumn; lexeme=yytext();return Vacio;}
abstract|boolean|byte|char|double|final|float|goto|int|long|
native|short|synchronized|throws|transient|volatile {linea=yyline; columna=yycolumn; lexeme=yytext();return ClaveReservada;}



{espacio} {/*Ignore*/}
//"//".* {/*Ignore*/}
"=" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Operador_Asignacion;}

"+" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Operador_Suma;}
"++" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Incremento;}
"-" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Operador_Resta;}
"--" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Decremento;}
"*" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Operador_Multiplicacion;}
"/" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Operador_Division;}
"%" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Operador_Residuo;}
"**" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Potencia;}

"{" {linea=yyline; columna=yycolumn; lexeme=yytext(); return LLave_Apertura;}
"}" {linea=yyline; columna=yycolumn; lexeme=yytext(); return LLave_Cierre;}
"(" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Parentesis_Apertura;}
")" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Parentesis_Cierre;}
"[" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Corchete_Apertura;}
"]" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Corchete_Cierre;}

";" {linea=yyline; columna=yycolumn; lexeme=yytext(); return Terminador;}
"," {linea=yyline; columna=yycolumn; lexeme=yytext(); return Coma;}

true | false {linea=yyline; columna=yycolumn; lexeme=yytext(); return Boleano;}



{L}({L}|{D})* {linea=yyline; columna=yycolumn; lexeme=yytext(); return Identificador;}

// ("(-"{D}+")")|{D} {linea=yyline; columna=yycolumn; lexeme=yytext(); return Numero;}


//Tipos de Numeros
-{D}+|{D} {linea=yyline; columna=yycolumn; lexeme=yytext(); return Entero_Real;}
-{D}+\.{D}+ |{D}\.{D}+ {linea=yyline; columna=yycolumn; lexeme=yytext(); return Decimal_Real;}
^([-|+]*{D}+e[-|+]*{D}+)  {linea=yyline; columna=yycolumn; lexeme=yytext(); return NotacionCientifica;}


//Otros LEXEMAS

("!=" | ">" | "<" | ">=" | "<=" | "==" | "===" | "+=" | "-=" | "*=" | "=" | "%=" | "**=" | "<<=" | ">>=" | ">>>=" | "&=" | "^=" | "|=" | "&&=" | "||=" | "??=") {linea=yyline; columna=yycolumn; lexeme=yytext(); return Comparador;}
"\&\&" | "\|\|" {lexeme=yytext(); return Operador_Logico;}

{S} {linea=yyline; columna=yycolumn; lexeme=yytext(); return Simbolo;}

("/""/"({L}|{D}|{S}|> | < | =)+ | "\/""\*"(\n| \t | {L}|{D}|{S}|> | < | =)+"\*""\/")  {linea=yyline; columna=yycolumn; lexeme=yytext(); return Comentario;}

("'"({L}|{D}|{S}|> | < | =)+"'") | ("\""({L}|{D}|{S}|> | < | =)+"\"") {linea=yyline; columna=yycolumn; lexeme=yytext(); return Cadena;}

 . |. | ({D}+{L}+) {linea=yyline; columna=yycolumn; lexeme=yytext(); return Error;} 



//Ultima Edicion 23/04/2022     01:31 AM
