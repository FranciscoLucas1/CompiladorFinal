%{
#include <string.h>
#include "compilador.tab.h"

void yyerror(char *s);
%}

NUM [0-9]+\.?[0-9]*
VARS [a-z][a-z0-9_]*
STRING \"[^\"\n]*\"
FIM "fim"
IF "if"
ELSE "else"
WHILE "while"
PRINT "escreva"
SCAN "ler"
DECL "var"

%%
\/\/[^\n]* {;}
"/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+"/" {;}

{FIM} {return FIM;}
{IF} {return IF;}
{ELSE} {return ELSE;}
{WHILE} {return WHILE;}
{PRINT} {return PRINT;}
{SCAN} {return SCAN;}
{DECL} {return DECL;}

{VARS} {
    strcpy(yylval.str,yytext);
    return VARS;
}

{STRING} {
    if (yyleng - 2 >= 256) {
        yyerror("string literal e muito longa, sera ignorada");
        yylval.str[0] = '\0'; 
        return STRING;
    } else {
        strncpy(yylval.str, yytext + 1, yyleng - 2);
        yylval.str[yyleng - 2] = '\0';
        return STRING;
    }
}

{NUM} {
    yylval.flo = atof(yytext);
    return NUM;
}

[-+()=/*,^{};\[\]] {return *yytext; 
}
            
">" {yylval.fn = 1; return CMP; }
"<" {yylval.fn = 2; return CMP; }
"<>" {yylval.fn = 3; return CMP; }
"==" {yylval.fn = 4; return CMP; }
">=" {yylval.fn = 5; return CMP; }
"<=" {yylval.fn = 6; return CMP; }

[[:space:];]+    {;} 
. {printf("(%s) Caractere Invalido Ignorado\n",yytext);}
%%

int yywrap(){
    return 1;
}