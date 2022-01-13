%{
#include <stdio.h>
#include <stdlib.h>
#include "syntax.h"

#define ERRO(msg) printf("ERRO: %s", msg);

void emit(char*);
%}

N           [0-9]+
D           [ ]+

%%

{N}         { emit(yytext); return(T_NUMBER); }
"+"         return T_PLUS;
"-"         return T_MINUS;
"**"        return T_POWER;
"*"         return T_TIMES;
"/"         return T_DIV;
"("         return T_OPEN_BRACKET;
")"         return T_CLOSE_BRACKET;
{D}         {;}

.           ERRO("erro lexico");

%%

char atomo[100];

void emit(char* num) {
    strcpy(atomo, num);
}