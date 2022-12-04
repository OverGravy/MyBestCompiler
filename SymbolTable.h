#ifndef __SYMBOLTABLE__
#define __SYMBOLTABLE__

// Personalmente non mi piace questa symbol table

//La symbol table è una struct con array da 52 perchè considero a-z e A-Z
typedef struct{ 
	int intSym[52]; // valori tipo int
	double fsym[52]; //valori tipo float
	int tip[52]; //questo array salva 1 se il valore è float e 0 è int almeno dopo posso capire il tipo delle variabili
}sym;

//funzioni che restituiscono il valore 
float FsymbolVal(char symbol,sym symbols);
int IsymbolVal(char symbol,sym symbols);

//funzione che updata il valore
void updateSymbolVal(char symbol, int Ival,float Fval,sym *symbols);

//funzioni per aggiungere solo il simbolo utili nella definzione e basta di una varibile.
void IAddSymbol(char symbol,sym *symbols);
void FAddSymbol(char symbol,sym *symbols);

//trovo un post alla variabile nell'array
int computeSymbolIndex(char token);

#endif