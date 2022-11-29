%{
void yyerror(char *s); /* La chiamo in presenza di un errore di sintassi*/
#include <stdlib.h>  /*Dichiarazioni di libreire  C usate nelle azioni*/
#include <stdio.h>

int IntSymbol[52]; // vettore di symboli per i nomi delle variabili, qui mettero e variabili
                //Qesta cosa qua nel nostr non può essere solo interi o float deve essere una
                //struttura versatile ad ospirare qualsiasi tipo in maniera dinamica

                 //52 perchè sono tutte le lettere minuscole e tutte le lettere maiuscole


int symbolVal(char symbol); //legge i valori che mi ritornano     /*Funzioni che utilizzero nelle azioni*/
void updateSymbolVal(char symbol, int val); //aggiorna la symbol table


//union mi dice cosa il mio lexical analyzer può ritornare
//first è la prima productio

// con <int> sto dicendo che questo token sarà salvato nello membro int in the union type
//ovvero salverò <int> in quelli con int nell'union

//funzionamento dell'union:  è un tipo di dato che serve per memorizzare oggetti diversi in istanti diversi con dimensioni e tipi diversi 
//in comune però hanno il ruolo all'interno del programma a livello di compilatore e allocazione di memoria usno tutte la stessa meori allocata.

%}

%union{char integer; char VarName; char equal; int value; char endline } 

%start first 

%token print
%token <integer> integer 
%token <VarName> variable
%token <equal> eq
%token <value> value
%token <endline> endline

%type <Num> value 
%type <str> assignamnet definition integer equal endline VarName




%%

/*descrizione di input attesi corrispondenti azioni da svolgere  in C*/

first : definition {;}
      | assignamnet {;}
      | print exp {printf("Printig %d\n",$2);}
      ;


definition : integer variable eq value endline {printf("Ho trovato una definizione");updateSymbolVal($2,$4);} //trovo una definzione aggiungo alla table il nome con il valore
           ;

assignamnet : variable eq exp {printf("Ho trovato un'espessione: %d",$3);updateSymbolVal($1,$3);} //inserisco il valore nel 
            ;

exp : term {$$=$1;}
    | exp '+' term {$$=$1+$3;}
    ;

term : value {$$ =$1;}
     | variable {$$ =symbolVal($1);}
     ;
%%

//Questa funzione mappa la Symbol table
int computeSymbolIndex(char token){
    int idx = -1;
    if(islower(token)){
        idx = token - 'a' + 26;       
    }else if(isupper(token)){
        idx =token -'A';
    }
    return idx;
}

int symbolVal(char symbol){
    int bucket = computeSymbolIndex(symbol);
    return IntSymbol[bucket];
}

void updateSymbolVal(char symbol,int val){
    int bucket =computeSymbolIndex(symbol);
    IntSymbol[bucket]=val;
}

int main(void){
    int i;
    for (i=0;i<52;i++){
        IntSymbol[i]=0; // metto tutto a 0 nella symbol table.
    }
    return yyparse();
}

void yyerror(char *s){fprintf(stderr,"%s\n",s);}