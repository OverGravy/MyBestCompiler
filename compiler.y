%{
void yyerror (char *s);
int yylex();

#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>

int symbols[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
%}

%union {
	int num; 
	float Fnum;
	char id;
}         /* Yacc definitions */

%start principal

/* */
%token print
%token exit_command

/*token di tipo*/
%token <type> integer
%token <type> floatin 


%token <id> identifier

/*token relativi a union*/
%token <num> IntNumber
%token <Fnum> FloatNumber

/* Non terminali*/
%type <num> principal exp term 
%type <id> IntDefAssignment IntDefinition assignment

%%

/* descriptions of expected inputs     corresponding actions (in C) */

principal	: assignment ';'            {;}
			| IntDefinition ';'         {;}
			| IntDefAssignment ';'		{;}
			| exit_command ';'		{exit(EXIT_SUCCESS);}
			| print exp ';'			{printf("Printing %d\n", $2);}
			| principal assignment ';' {;}
			| principal IntDefAssignment ';'	{;}
			| principal IntDefinition ';' {;}
			| principal print exp ';'	{printf("Printing %d\n", $3);}
			| principal exit_command ';'	{exit(EXIT_SUCCESS);}
			;

/*operazione di definzione e assegnazione integer */
IntDefAssignment : integer identifier '=' exp  { updateSymbolVal($2,$4); }
			;

IntDefinition : integer identifier {updateSymbolVal($2,0);}
			;

/*Assegnamento generico*/
assignment : identifier '=' exp {updateSymbolVal($1,$3);}


exp    	: term                  {$$ = $1;}
       	| exp '+' term          {$$ = $1 + $3;}
       	| exp '-' term          {$$ = $1 - $3;}
       	;
term   	: IntNumber             {$$ = $1;}
		| FloatNumber           {$$ = $1;}
		| identifier			{$$ = symbolVal($1);} 
        ;

%%                     /* C code */

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

/* returns the value of a given symbol */
int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

int main (void) {

	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
