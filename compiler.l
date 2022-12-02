%{
#include "y.tab.h"
void yyerror (char *s);
int yylex();
%}
%%
"int"				   {return integer;}
"print"				   {return print;}
[a-zA-Z][_a-zA-Z0-9]*  {yylval.id = yytext[0]; return identifier;}
[0-9]+                 {yylval.num = atoi(yytext); return IntNumber;}
[ \t\n]                ;
[-+=;]           	   {return yytext[0];}
.                      {ECHO; yyerror ("unexpected character");}

%%
int yywrap (void) {return 1;}

