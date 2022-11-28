%option noyywrap

%{
  #include "Definition.h" 
%}

%%

"int"                 return TYPEINT;
"float"               return TYPEFLOAT;


[a-zA-Z][_a-zA-Z0-9]* return VAR;


"="                   return ASSIGNAMENT;


[0-9][1-9]*           return VALUE;
  

[ \t\n]               ;

";"                   return ENDLINE;

%%

