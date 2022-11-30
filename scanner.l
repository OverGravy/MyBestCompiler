%option noyywrap

%{
  #include "compiler.tab.h" 
%}

%%

[int]                 {return integer;}


[a-zA-Z][_a-zA-Z0-9]* {yylval.VarName = yytext[0]; return VarValue;}


[=]                   {return equal;}


[0-9]+           {yylval.value= atoi(yytext); return VarValue;}
  

[\t\n\r]               {;}

[;]                  {return endline;}

[+]                   {return plus;}

%%

