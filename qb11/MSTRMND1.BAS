DECLARE SUB answercatch ()
DECLARE SUB win ()
DECLARE SUB colorcatch ()
COMMON SHARED c$, answer$, y, i$

DIM previous(10)

column = 8

CLS

LOCATE 3, 24: COLOR 12: PRINT "R": LOCATE 3, 30: COLOR 6: PRINT "O": LOCATE 3, 36: COLOR 14: PRINT "Y": LOCATE 3, 43: COLOR 10: PRINT "G": LOCATE 3, 49: COLOR 9: PRINT "B": LOCATE 3, 55: COLOR 5: PRINT "P":

answercatch
LET a$ = answer$
PRINT a$
answercatch
LET aa$ = answer$
PRINT aa$
answercatch
LET aaa$ = answer$
PRINT aaa$

DO UNTIL chances = 10

chances = chances + 1
column = column + 2

COLOR 15

LOCATE 8, 3
PRINT "1st Color?"
colorcatch
LET c$ = i$
LOCATE column, 37
COLOR y
PRINT c$

COLOR 15
LOCATE 8, 3
PRINT "2nd Color?"
colorcatch
LET cc$ = i$
LOCATE column, 40
COLOR y
PRINT cc$


COLOR 15
LOCATE 8, 3
PRINT "3rd Color?"
colorcatch
LET ccc$ = i$
LOCATE column, 43
COLOR y
PRINT ccc$




IF c$ = a$ AND cc$ = aa$ AND ccc$ = aaa$ THEN win

IF c$ = a$ THEN LET red = red + 1
IF cc$ = aa$ THEN LET red = red + 1
IF ccc$ = aaa$ THEN LET red = red + 1

IF c$ = aa$ OR c$ = aaa$ THEN LET white = white + 1
IF cc$ = a$ AND c$ <> a$ THEN LET white = white + 1
IF cc$ = aaa$ AND c$ <> aaa$ AND ccc$ <> aaa$ THEN LET white = white + 1
IF ccc$ = a$ AND c$ <> a$ AND cc$ <> a$ THEN LET white = white + 1
IF ccc$ = aa$ AND c$ <> aa$ AND cc$ <> aa$ THEN LET white = white + 1

DO UNTIL red <= 0
red = red - 1

IF red = -1 THEN EXIT DO

RANDOMIZE TIMER
position = INT(RND * 3) + 1

top:

IF position = 1 THEN
        IF previous(1) = 1 THEN LET position = 2
ELSE
        LET previous(1) = 1
        LOCATE column, 21
        COLOR 12
        PRINT CHR$(254)
END IF

IF position = 2 THEN
        IF previous(2) = 1 THEN LET position = 3
ELSE
        LET previous(2) = 1
        LOCATE column, 24
        COLOR 12
        PRINT CHR$(254)
END IF

IF position = 3 THEN
        IF previous(3) = 1 THEN GOTO top
ELSE
        LET previous(3) = 1
        LOCATE column, 27
        COLOR 12
        PRINT CHR$(254)
END IF


LOOP

DO UNTIL white <= 0
white = white - 1

IF white = -1 THEN EXIT DO

RANDOMIZE TIMER
position = INT(RND * 3) + 1

top2:

IF position = 1 THEN
        IF previous(1) = 1 THEN LET position = 2
ELSE
        LET previous(1) = 1
        LOCATE column, 21
        COLOR 15
        PRINT CHR$(254)
END IF

IF position = 2 THEN
        IF previous(2) = 1 THEN LET position = 3
ELSE
        LET previous(2) = 1
        LOCATE column, 24
        COLOR 15
        PRINT CHR$(254)
END IF

IF position = 3 THEN
        IF previous(3) = 1 THEN GOTO top2
ELSE
        LET previous(3) = 1
        LOCATE column, 27
        COLOR 15
        PRINT CHR$(254)
END IF


LOOP


ERASE previous
LOOP

SUB answercatch


RANDOMIZE TIMER
b = INT(RND * 6) + 1


IF b = 1 THEN LET answer$ = "p"
IF b = 2 THEN LET answer$ = "b"
IF b = 3 THEN LET answer$ = "g"
IF b = 4 THEN LET answer$ = "y"
IF b = 5 THEN LET answer$ = "o"
IF b = 6 THEN LET answer$ = "r"


END SUB

SUB colorcatch
redo:

i$ = ""

DO WHILE i$ = ""
i$ = INKEY$
LOOP
              
LET i$ = LCASE$(i$)
IF i$ = "r" OR i$ = "o" OR i$ = "y" OR i$ = "g" OR i$ = "b" OR i$ = "p" THEN GOTO done

GOTO redo


done:


IF i$ = "r" THEN LET y = 12
IF i$ = "o" THEN LET y = 6
IF i$ = "y" THEN LET y = 14
IF i$ = "g" THEN LET y = 10
IF i$ = "b" THEN LET y = 9
IF i$ = "p" THEN LET y = 5




END SUB

SUB win
PRINT "YOU WIN!!!"
END
END SUB

