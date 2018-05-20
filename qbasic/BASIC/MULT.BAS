1 p = 1
10 PRINT "enter numbers to multiply"
11 INPUT x
IF x = -11111 THEN GOTO 100
p = p * x
GOTO 11
100 PRINT "the solution is"; p
PRINT "do you wish to do another? y/n"
INPUT t$
IF t$ = "y" THEN GOTO 1
PRINT "goodbye"

