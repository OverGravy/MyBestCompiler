# MyBestCompiler 

Progetto: Realizzazione di un compilatore Risk-V per file .c

Parte personale del progetto condiviso sula realizzazione di un compilatore Risk-V per file .c con un set di istruzioni ridotti a quelle elementari 

# Strutturazione

Utilizzeremo Flex/Lex come generatore di flusso di token mediante la scannerizzazione e la realizzazione di un set di regole per identificare i token.

Usermo poi Bison/ come parser e Lexical Analyzer per interpretre ciò che avviene nel flusso di token

# Stato attuale

- Genero bene i file compiler.tab.y e la controparte .c
- La compilazione riesce solo con warning e note 
- Qualsiasi cosa inserisca ottengo solo sytax error


# Problematiche 

- Devo capire meglio come funziona il concetto di %token e %type con il tipo union.
- Ho capito meglio alcune cose ma l'errore rime in quella parte ed è un'errore logico non capisco bene quale però.

# Note 

Il file Scanner.c è inutile per ora, non lo elimino per il meme.

yacc non va usato gener errori in fase di compilazione con gcc attribuibili a y.tab.h

Ricordati quando utilizzi Bison/yacc di usare bison -d per generare un nuovo file y.tab.c 