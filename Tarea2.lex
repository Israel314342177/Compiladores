%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap
%option yylineno

pr @(if|else|while)
letra [A-Za-z]
letra_ _|{letra}
digito [0-9]
id #({letra_}|{digito})*
arit "+"|"-"|"*"|"/"|"%"
relac ">"|"<"|">="|"<="|"=="
asign "="
logic v
op {arit}|{asig}|{relac}|{logic}
sign_punt [,;]
coment "/"(~("/"))"*/"
espacios [ \t\n\r]+

%%

{pr} {printf("Se encontro una palabra reservada:%s\n",yytext);}
{id} {printf("Se encontre un id:%s\n",yytext);}
{operador} {printf("Se encontro un operador:%s\n",yytext);}
{sign_punt} {printf("Se encontro un simbolo de puntuacion:%s\n",yytext);}
{espacios}  {/* Ignorar los espacios */}
{coment} {/* Ignorar los comentarios */}

%%

int main(int argc, char ** argv){
    FILE *f;
    if (argv < 2){
        printf("Falta agregar el archivo");
        exit(-1);
    }
    f = fopen(argv[1],"r");
    if (!f){
        printf("No se pudo abrir el archivo seleccionado");
        exit(-1);
    }
    yyin = f;
    yylex();
    return 0;

}
