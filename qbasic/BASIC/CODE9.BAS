REM THIS PROGRAM TAKES SENTENCES AND PUTS THEM INTO CODE
REM tricky code!!
REM this next line is the one that changes the location of the file
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
REM This next line is the one to change if you want to mess with the codes.
a = 27 - a
f$ = STR$(a)
IF LEN(f$) = 2 THEN f$ = MID$(f$, 2, 1) + MID$(f$, 1, 1)
cod$ = cod$ + f$
cod$ = cod$ + ","
NEXT n
PRINT #1, cod$
cod$ = ""
LOOP UNTIL sen$ = ""
CLOSE #1

