%option noyywrap

%{
  #include "y.tab.h" 
%}

%%

"int"                 {return integer}

"print"               {return print}

[a-zA-Z][_a-zA-Z0-9]* {yyval.variable = yytext[0]; return variable;}


"="                   {return eq;}


[0-9][1-9]*           {yyval.value= atoi(yytext); return value;}
  

[ \t\n]               {;}

";"                   return {endline};

[+]                   return

%%

