REM THIS PROGRAM TAKES SENTENCES AND PUTS THEM INTO CODE
REM this next line is the one that changes the location of the file
OPEN "b:\basic\code.txt" FOR OUTPUT AS #1
DO
PRINT "Please enter the sentence to be changed."
PRINT "Or just type enter to stop writing."
INPUT sen$
FOR n = 1 TO LEN(sen$)
a = ASC(MID$(sen$, n, 1))
a = a - 64
IF a > 26 THEN a = a - 32
IF a = -33 THEN a = 0
f$ = CHR$(27 - a)
cod$ = cod$ + f$
cod$ = cod$ + ","
NEXT n
PRINT #1, cod$
PRINT cod$
cod$ = ""

LOOP UNTIL sen$ = ""
CLOSE #1

