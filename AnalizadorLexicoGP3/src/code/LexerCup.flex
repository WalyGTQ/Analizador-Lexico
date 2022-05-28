//area de Codigo de Usuario

package code;
import java_cup.runtime.Symbol;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%column
%char
J=[a|A|b|B|c|C|d|D|e|E|f|F|g|G|h|H|i|I|j|J|k|K|L|l|m|M|n|N|ñ|Ñ|o|O|p|P|q|Q|r|R|s|S|t|T|u|U|v|V|w|W|x|X|y|Y|z|Z]
L=[a-zA-Z_ñÑ]+
D=[0-9]+
S=[\- | \_ | \. | \:   | \; | \+  | \# | \$ | \%  | \/ | \( | \)  | ","| \[ | \] | \{ | \}]
espacio=[ ,\t,\r,\n]+

%{
    private Symbol symbol(int type, Object value){
       return new Symbol(type, yyline, yycolumn, value);}

    private Symbol symbol(int type){
       return new Symbol(type, yyline,yycolumn);}
     

%}
%%
//Palabras reservadas
break | case| catch |continue| default| delete| do|
finally| for| in| instanceof| new|
switch| this| throw| try| typeof|  void|
with|class|const|debugger|export|extends|import|
super | yield |enum {return new Symbol(sym.Palabra_Reservada, yychar, yyline, yytext());}

null {return new Symbol(sym.Vacio, yychar, yyline, yytext());}
abstract|boolean|byte|char|double|final|float|goto|int|long|
native|short|synchronized|throws|transient|volatile {return new Symbol(sym.ClaveReservada, yychar, yyline, yytext());}

//Especificas
var         {return new Symbol(sym.Var, yychar, yyline, yytext());}
return      {return new Symbol(sym.Return, yychar, yyline, yytext());}
(if)        {return new Symbol(sym.If, yychar, yyline, yytext());}   
(else)        {return new Symbol(sym.Else, yychar, yyline, yytext());}
while       {return new Symbol(sym.While, yychar, yyline, yytext());}
function    {return new Symbol(sym.Function, yychar, yyline, yytext());}



{espacio} {/*Ignore*/}
//"//".* {/*Ignore*/}
"=" {return new Symbol(sym.Operador_Asignacion, yychar, yyline, yytext());}

"+" {return new Symbol(sym.Operador_Suma, yychar, yyline, yytext());}
//"++" {{return new Symbol(sym.Incremento, yychar, yyline, yytext());}
"-" {return new Symbol(sym.Operador_Resta, yychar, yyline, yytext());}
"--" {return new Symbol(sym.Decremento, yychar, yyline, yytext());}
"*" {return new Symbol(sym.Operador_Multiplicacion, yychar, yyline, yytext());}
"/" {return new Symbol(sym.Operador_Division, yychar, yyline, yytext());}
"%" {return new Symbol(sym.Operador_Residuo, yychar, yyline, yytext());}
"**" {return new Symbol(sym.Operador_Potencia, yychar, yyline, yytext());}

"{" {return new Symbol(sym.LLave_Apertura, yychar, yyline, yytext());}
"}" {return new Symbol(sym.LLave_Cierre, yychar, yyline, yytext());}
"(" {return new Symbol(sym.Parentesis_Apertura, yychar, yyline, yytext());}
")" {return new Symbol(sym.Parentesis_Cierre, yychar, yyline, yytext());}
"[" {return new Symbol(sym.Corchete_Apertura, yychar, yyline, yytext());}
"]" {return new Symbol(sym.Corchete_Cierre, yychar, yyline, yytext());}

";" {return new Symbol(sym.Terminador, yychar, yyline, yytext());}
("/,") {return new Symbol(sym.Coma, yychar, yyline, yytext());}

true | false {return new Symbol(sym.Boleano, yychar, yyline, yytext());}





//Expreciones Regulares
{L}({L}|{D})* {return new Symbol(sym.Identificador, yychar, yyline, yytext());}

//Tipos de Numeros
-{D}+|{D} {return new Symbol(sym.Entero_Real, yychar, yyline, yytext());}
-{D}+\.{D}+ |{D}\.{D}+ {return new Symbol(sym.Decimal_Real, yychar, yyline, yytext());}
^([-|+]*{D}+e[-|+]*{D}+)  {return new Symbol(sym.NotacionCientifica, yychar, yyline, yytext());}

// Comentario y Cadena
("/""/"({L}|{D}|{S}|> | < | =)+ | "\/""\*"(\n| \t | {L}|{D}|{S}|> | < | =)+"\*""\/")  {/*Ignore*/}
("'"({L}|{D}|{S}|> | < | =)+"'") | ("\""({L}|{D}|{S}|> | < | =)+"\"") {return new Symbol(sym.Cadena, yychar, yyline, yytext());}
({J}) {return new Symbol(sym.Letra, yychar, yyline, yytext());}

("!=" | ">" | "<" | ">=" | "<=" | "==" | "===" | "+=" | "-=" | "*=" | "=" | "%=" | "**=" | "<<=" | ">>=" | ">>>=" | "&=" | "^=" | "|=" | "&&=" | "||=" | "??=") {return new Symbol(sym.Comparador, yychar, yyline, yytext());}
"\&\&" | "\|\|" {return new Symbol(sym.Operador_Logico, yychar, yyline, yytext());}

{S} {return new Symbol(sym.Simbolo, yychar, yyline, yytext());}

 . |. | ({D}+{L}+) {return new Symbol(sym.Error, yychar, yyline, yytext());}