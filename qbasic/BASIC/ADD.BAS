1 CLS
PRINT "input numbers to add"
INPUT i
10 INPUT t
IF t = -11111 THEN GOTO 30
i = t + i
GOTO 10
30 PRINT "the sum is"; i
PRINT "do you wish to do another"
INPUT r$
IF r$ = "y" THEN GOTO 1
PRINT "goodbye"

