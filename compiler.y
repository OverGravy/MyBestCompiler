%{
void yyerror (char *s);
int yylex();

#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>

/*ragionare su cosa sia meglio per salvare le variabili*/
typedef struct{
	int intSym[52];
	float fsym[52];
	char tip[52];
}symbols;

float FsymbolVal(char symbol);
int IsymbolVal(char symbol);
void updateSymbolVal(char symbol, int Ival,float Fval);
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
%type <id> IntDefAssignment IntDefinition FloatDefinition FloatDefAssignament assignment

%%

/* descriptions of expected inputs     corresponding actions (in C) */

principal	: assignment ';'            {;}
			| IntDefinition ';'         {;}
			| IntDefAssignment ';'		{;}
			| FloatDefAssignament ';'   {;}
			| FloatDefinition ';'		{;}
			| exit_command ';'		{exit(EXIT_SUCCESS);}
			| print exp ';'			{printf("Printing %d\n", $2);}
			| principal assignment ';' {;}
			| principal IntDefAssignment ';'	{;}
			| principal IntDefinition ';' {;}
			| principal FloatDefAssignament ';' {;}
			| principal FloatDefinition ';' {;}
			| principal print exp ';'	{printf("Printing %d\n", $3);}
			| principal exit_command ';'	{exit(EXIT_SUCCESS);}
			;

/*operazione di definzione e assegnazione integer */
IntDefAssignment : integer identifier '=' exp  { updateSymbolVal($2,$4,0); }
			;
FloatDefAssignament : floatin identifier '=' exp { updateSymbolVal($2,0,$4); }

IntDefinition : integer identifier {IAddSymbol($2);}
			;

FloatDefinition : floatin identifier {FAddSymbol($2);}
				;
/*Assegnamento generico*/
assignment : identifier '=' exp {updateSymbolVal($1,$3,);}


exp    	: term                  {$$ = $1;}
       	| exp '+' term          {$$ = $1 + $3;}
       	| exp '-' term          {$$ = $1 - $3;}
       	;
term   	: IntNumber             {$$ = $1;}
		| FloatNumber           {$$ = $1;}
		| identifier			{
			char t;
			int bucket = computeSymbolIndex($1)
			t=symbols.tip[bucket];
			if(t=='i') {$$= IsymbolVal($1);}
			else if(t=='f') {$$=FsymbolVal($1);}
			} 
        ;

%%                     /* C code */

/*Va realizzata un'organizzazione più efficente della symbol val*/
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
int IsymbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

float FsymbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int Ival,float Fval);
{
	int bucket;
	if(Ival != 0 && Fval == 0){
		bucket = computeSymbolIndex(symbol);
		symbols.intSym[bucket] = Ival;
		symbols.tip[bucket] = 'i'; // servirà dopo per capure il tipo
	}else if(Ival==0 && Fval != 0){
		bucket = computeSymbolIndex(symbol);
		symbols.fsym[bucket] = Fval;
		symbols.tip[bucket] = 'f';
	}	
}

// Updata la symboltable ma solo in caso di definizione quindi mette 0;
void IAddSymbol(char symbol){
	int bucket = computeSymbolIndex(symbol);
	symbols.intSym[bucket] = 0;
}

void FAddSymbol(char symbol){
	int bucket = computeSymbolIndex(symbol);
	symbols.intSym[bucket] = 0;
}

int main (void) {

	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols.intSym[i] = 0;
		symbols.fsym[i] =0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
