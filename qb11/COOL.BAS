
'This program created January 13 and 14, 2006 by Nathan Friend, age 14
'Press SHIFT + F5 to start program











DECLARE SUB presets ()
DECLARE SUB colorpick ()
DIM dots(49)
DIM SHARED c(24)
CLS
SCREEN 12
SLEEP 3

top1:
CLS

LOCATE 5, 2
INPUT "Would you like the circle to erase itself after it is done drawing? y/n  ", yn1$
LET yn1$ = UCASE$(MID$(yn1$, 1, 1))
IF yn1$ = "Y" THEN LET erasec = 1: GOTO nextq
IF yn1$ = "N" THEN GOTO nextq
GOTO top1

nextq:
LET usecolor = 1: presets: GOTO doneq

GOTO nextq
doneq:
CLS
LET u = 1

FOR l = 1 TO 360 STEP 360 / 24
        LET i = l * (3.14 / 180)
        PSET (((COS(i) * 225) + 320), ((SIN(i) * 225)) + 230), 15
        LET dots(u) = ((COS(i) * 225) + 320)
        LET u = u + 1
        LET dots(u) = ((SIN(i) * 225) + 230)
        LET u = u + 1
NEXT l

LET cc = 1
FOR i = 1 TO 47 STEP 2
        FOR y = i TO 47 STEP 2
                LINE (dots(i), dots(i + 1))-(dots(y), dots(y + 1)), c(cc)
        FOR g = 1 TO 10000
        NEXT g
        NEXT y
LET cc = cc + 1
done:
NEXT i


IF erasec = 1 THEN
        FOR i = 1 TO 47 STEP 2
                FOR y = i TO 47 STEP 2
                        LINE (dots(i), dots(i + 1))-(dots(y), dots(y + 1)), 0
                                FOR g = 1 TO 10000
                                 NEXT g
                NEXT y
        NEXT i
END IF

LOCATE 27, 2
PRINT "Press any key"
LOCATE 28, 2
PRINT "to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS
LOCATE 2, 2
INPUT "Would you like to draw another circle?  ", again$
IF UCASE$(MID$(again$, 1, 1)) = "Y" THEN LET erasec = 0: CLOSE : GOTO top1
END

SUB colorpick
topofhere:
CLOSE
CLS
LOCATE 2, 2
PRINT "Type in a new name for your preset,"
LOCATE 3, 2
PRINT "no longer than 16 characters:";
INPUT " ", presetname$
IF LEN(presetname$) > 16 THEN LOCATE 4, 2: PRINT "Sorry, but your name is too long. ": LOCATE 5, 2: PRINT "Please type a name that has less then 17 characters.": LOCATE 7, 2: PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: GOTO topofhere

LET presetname$ = UCASE$(presetname$)
OPEN "c:/work/nathan/qbasic~1/save/colors.txt" FOR INPUT AS #1
OPEN "c:/work/nathan/qbasic~1/save/tempcol.txt" FOR OUTPUT AS #2
DO UNTIL EOF(1)
INPUT #1, g$
PRINT #2, g$
LOOP
CLOSE
OPEN "c:/work/nathan/qbasic~1/save/colors.txt" FOR INPUT AS #1
INPUT #1, ffff
FOR i = 1 TO ffff
        INPUT #1, yy$
                IF presetname$ = yy$ THEN GOTO duplicate
        FOR p = 1 TO 24
                INPUT #1, oo
        NEXT p
NEXT i
GOTO nextstep
duplicate:
CLS
PRINT "There is already a preset named '"; presetname$; "'."
INPUT "Overwrite? y/n   ", yn$
LET yn$ = UCASE$(MID$(yn$, 1, 1))
IF yn$ = "Y" THEN GOTO nextstep
IF yn$ = "N" THEN GOTO topofhere
GOTO duplicate

nextstep:
CLS
LOCATE 2, 2
PRINT "Here you will chose your colors. Type in the number beside the color you want."

FOR i = 1 TO 15
        IF i <= 9 THEN LOCATE (i + 3), 50
        IF i > 9 THEN LOCATE (i + 3), 49
        COLOR i
        PRINT i; " "; STRING$(5, CHR$(219))
NEXT i


FOR i = 1 TO 24
        LOCATE (i + 3), 2
        PRINT "Color"; i
there:
        IF i < 10 THEN LOCATE (i + 3), 9
        IF i > 9 THEN LOCATE (i + 3), 10
        INPUT t
        IF t >= 0 AND t <= 15 THEN LET c(i) = t: GOTO done5
        LOCATE (i + 3), 2
        PRINT "Color"; i; "                     "
        GOTO there
done5:
NEXT i


CLOSE
OPEN "c:/work/nathan/qbasic~1/save/colors.txt" FOR OUTPUT AS #1
OPEN "c:/work/nathan/qbasic~1/save/tempcol.txt" FOR INPUT AS #2
INPUT #2, olde
PRINT #1, olde + 1
DO UNTIL EOF(2)
INPUT #2, f$
PRINT #1, f$
LOOP
PRINT #1, presetname$
FOR i = 1 TO 24
PRINT #1, c(i)
NEXT i
CLOSE
END SUB

SUB presets
DIM t$(entries + 3)
top:
CLOSE
CLS
OPEN "c:/work/nathan/qbasic~1/save/colors.txt" FOR INPUT AS #1

INPUT #1, entries
REDIM t$(entries + 3)
LOCATE 2, 2
PRINT "Here is a list of color presets:"
LOCATE 3, 2
PRINT "Type in 'new preset' to create your own color preset."

FOR i = 1 TO entries
INPUT #1, t$(i)
        FOR t = 1 TO 24
                INPUT #1, k
        NEXT t
NEXT i

LET gh = 1
FOR i = 1 TO entries STEP 4
LOCATE (gh + 4), 5
PRINT t$(i)
LOCATE (gh + 4), 24
PRINT t$(i + 1)
LOCATE (gh + 4), 43
PRINT t$(i + 2)
LOCATE (gh + 4), 60
PRINT t$(i + 3)
LET gh = gh + 1
NEXT i


CLOSE

OPEN "c:/work/nathan/qbasic~1/save/colors.txt" FOR INPUT AS #1

INPUT #1, entries

LOCATE ((entries / 4) + 7), 2

INPUT "Which color preset would you like to input?  ", cpreset$
LET cpreset$ = UCASE$(cpreset$)
IF cpreset$ = "NEW PRESET" THEN colorpick: CLOSE : GOTO ready
FOR i = 1 TO entries
        INPUT #1, name$
        IF name$ = cpreset$ THEN GOTO inputc
                FOR t = 1 TO 24
                INPUT #1, k
                NEXT t
NEXT i
CLS
PRINT "There is no preset called '"; cpreset$; "'."
PRINT "Press any key to continue."
DO WHILE INKEY$ = ""
LOOP
GOTO top

inputc:
CLOSE
OPEN "c:/work/nathan/qbasic~1/save/colors.txt" FOR INPUT AS #1

INPUT #1, entries

DO UNTIL tempname$ = cpreset$
INPUT #1, tempname$
       LOOP
       
FOR y = 1 TO 24
        INPUT #1, c(y)
NEXT y



ready:
END SUB

