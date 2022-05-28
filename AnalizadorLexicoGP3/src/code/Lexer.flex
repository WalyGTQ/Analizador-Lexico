//area de Codigo de Usuario
package code;
import static code.Tokens.*;
%%
%class Lexer
%type Tokens
%line
%column
%unicode 
J=[a|A|b|B|c|C|d|D|e|E|f|F|g|G|h|H|i|I|j|J|k|K|L|l|m|M|n|N|ñ|Ñ|o|O|p|P|q|Q|r|R|s|S|t|T|u|U|v|V|w|W|x|X|y|Y|z|Z]
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
finally| for| in| instanceof| new|
switch| this| throw| try| typeof|  void|
with|class|const|debugger|export|extends|import|
super | yield |enum {linea=yyline; columna=yycolumn; lexeme=yytext();return Palabra_Reservada;}

null {linea=yyline; columna=yycolumn; lexeme=yytext();return Vacio;}
abstract|boolean|byte|char|double|final|float|goto|int|long|
native|short|synchronized|throws|transient|volatile {linea=yyline; columna=yycolumn; lexeme=yytext();return ClaveReservada;}

//Especificas
var         {linea=yyline; columna=yycolumn; lexeme=yytext();return Var;}
return      {linea=yyline; columna=yycolumn; lexeme=yytext();return Return;}
if          {linea=yyline; columna=yycolumn; lexeme=yytext();return If;}    
else        {linea=yyline; columna=yycolumn; lexeme=yytext();return Else;}
while       {linea=yyline; columna=yycolumn; lexeme=yytext();return While;}
function    {linea=yyline; columna=yycolumn; lexeme=yytext();return Function;}



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
("/,") {linea=yyline; columna=yycolumn; lexeme=yytext(); return Coma;}

true | false {linea=yyline; columna=yycolumn; lexeme=yytext(); return Boleano;}





//Expreciones Regulares
{L}({L}|{D})* {linea=yyline; columna=yycolumn; lexeme=yytext(); return Identificador;}

//Tipos de Numeros
-{D}+|{D} {linea=yyline; columna=yycolumn; lexeme=yytext(); return Entero_Real;}
-{D}+\.{D}+ |{D}\.{D}+ {linea=yyline; columna=yycolumn; lexeme=yytext(); return Decimal_Real;}
^([-|+]*{D}+e[-|+]*{D}+)  {linea=yyline; columna=yycolumn; lexeme=yytext(); return NotacionCientifica;}

// Comentario y Cadena
("/""/"({L}|{D}|{S}|> | < | =)+ | "\/""\*"(\n| \t | {L}|{D}|{S}|> | < | =)+"\*""\/")  {linea=yyline; columna=yycolumn; lexeme=yytext(); return Comentario;}
("'"({L}|{D}|{S}|> | < | =)+"'") | ("\""({L}|{D}|{S}|> | < | =)+"\"") {linea=yyline; columna=yycolumn; lexeme=yytext(); return Cadena;}
({J}) {linea=yyline; columna=yycolumn; lexeme=yytext(); return Letra;}

("!=" | ">" | "<" | ">=" | "<=" | "==" | "===" | "+=" | "-=" | "*=" | "=" | "%=" | "**=" | "<<=" | ">>=" | ">>>=" | "&=" | "^=" | "|=" | "&&=" | "||=" | "??=") {linea=yyline; columna=yycolumn; lexeme=yytext(); return Comparador;}
"\&\&" | "\|\|" {lexeme=yytext(); return Operador_Logico;}

{S} {linea=yyline; columna=yycolumn; lexeme=yytext(); return Simbolo;}

 . |. | ({D}+{L}+) {linea=yyline; columna=yycolumn; lexeme=yytext(); return Error;} 