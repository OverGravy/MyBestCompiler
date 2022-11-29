# MyBestCompiler 

Progetto: Realizzazione di un compilatore Risk-V per file .c

Parte personale del progetto condiviso sula realizzazione di un compilatore Risk-V per file .c con un set di istruzioni ridotti a quelle elementari 

# Strutturazione

Utilizzeremo Flex/Lex come generatore di flusso di token mediante la scannerizzazione e la realizzazione di un set di regole per identificare i token.

Usermo poi Bison/ come parser e Lexical Analyzer per interpretre ciò che avviene nel flusso di token

# Stato attuale

- Non riesco a genrare i file y.tab.c e y.tab.h causa molteplici errori nel passaggio di compiler.y all'interno di Bison/yacc
- Non riseco nella compilazione finale ovviamente


# Problematiche 

- Devo capire meglio come funziona il concetto di %token e %type con il tipo union.

# Note 

Il file Scanner.c è inutile per ora, non lo elimino per il meme.

Ricordati quando utilizzi Bison/yacc di usare -d per generare un nuovo file y.tab.c 