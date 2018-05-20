REM THIS PROGRAM TAKES SENTENCES AND PUTS THEM INTO CODE
REM Just a normal a=1 z=26 type code
OPEN "./save/code.txt" FOR OUTPUT AS #1
DO
PRINT "Please enter the sentence to be changed."
PRINT "Or just type enter to stop writing."
INPUT sen$
FOR n = 1 TO LEN(sen$)
a = ASC(MID$(sen$, n, 1))
a = a - 64
IF a > 26 THEN a = a - 32
IF a = -33 THEN a = 0
f$ = STR$(a)
cod$ = cod$ + f$
cod$ = cod$ + ","
NEXT n
PRINT #1, cod$
cod$ = ""
LOOP UNTIL sen$ = ""
CLOSE #1

