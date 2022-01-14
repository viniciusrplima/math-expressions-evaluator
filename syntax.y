%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "lex.c"

#define ERRO(msg) printf("ERRO: %s", msg);
    
int yywrap();
void yyerror(char*);

%}

%start S

%token T_NUMBER
%token T_PLUS
%token T_MINUS
%token T_TIMES
%token T_DIV
%token T_POWER
%token T_EXP

%token T_OPEN_BRACKET
%token T_CLOSE_BRACKET

%left T_PLUS T_MINUS
%left T_TIMES T_DIV
%right T_POWER

%%

S: expr { printf("%d\n", $$); }

expr: expr T_PLUS expr { $$ = $1 + $3; }
    | expr T_MINUS expr { $$ = $1 - $3; }
    | expr T_TIMES expr { $$ = $1 * $3; }
    | expr T_DIV expr { $$ = $1 / $3; }
    | expr T_POWER term { $$ = pow($1, $3); }
    | T_OPEN_BRACKET expr T_CLOSE_BRACKET { $$ = $2; }
    | expr T_EXP { $$ = $1 * $1; }
    | term
    ;

term: T_NUMBER { $$ = atoi(atomo); }

%% 

int yywrap() {
    return 1;
}

void yyerror(char *s) {
    ERRO(s);
}

int main() {
    char expr[100];
    fgets(expr, 100, stdin);

    while(expr[0] != 'q') {
        yy_scan_string(expr);
        yyparse();
        fgets(expr, 100, stdin);
    } 
}
