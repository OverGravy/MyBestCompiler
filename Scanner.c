//Questo file usa la funzione yylex per capire cosa sta parsando e che tag sto vedendo 

#include <stdio.h>
#include "Definition.h"

//extern poicè sono esterne da qualche parte queste cose: dovrebbe stare in lex.yy.c

extern int yylex(); 
extern int yylineno; //serve per restituire il numero della linea dove trova il token
extern char* yytext; //puntatore al token

//metto i nomi di quello che trovo siccome dall'altra parte restituisco dei numeri ogni volta che trovo qualcosa
char *names[] ={NULL,"int","float","name", "var","value","assignamnet"};

int main(void){

    int ntoken, vtoken; 
    
    //ntoken = name token
    //vtoken = value token

    ntoken=yylex(); //ritorna il primo token valido 
    while (ntoken)
    {
        printf("%d\n",ntoken);   
        switch (ntoken)
        {
        case TYPEINT:
            if (ntoken!= VAR){ // se mi accorgo che non c'è VAR
              //printf("Syntax Error in line %d Expected varariable name but found: %s",yylineno,yytext);
              // printf("Syntax Error, Expexted variable name found: %s",yytext);         
            }
            break;
        case TYPEFLOAT:
            if (ntoken!= VAR){ // se mi accorgo che non c'è VAR
              //printf("Syntax Error in line %d Expected varariable name but found: %s",yylineno,yytext);
              // printf("Syntax Error, Expexted variable name found: %s",yytext);
              }
            break;
         case VAR:
            if (ntoken!= ENDLINE || ntoken!= ASSIGNAMENT){ // se mi accorgo che non c'è = 0 un assegnamento
              //printf("Syntax Error in line %d Expected Assignamnet or ';' but found: %s",yylineno,yytext);
              //printf("Syntax Error, Expexted ';' or '=' found: %s",yytext);
              }
            break;
        }
        ntoken =yylex();

    }
    return 0;
}