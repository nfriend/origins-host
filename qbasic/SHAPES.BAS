DECLARE SUB balls ()
DECLARE SUB shape ()
DECLARE SUB starter ()
CALL starter

SUB balls
toper:
CLS
SCREEN 12
PRINT "Would you like to clear the screen after each ball is viewed, or not?", clsn$
PRINT "N or n = no"
PRINT "Y or y = yes"
LOCATE 1, 73
INPUT clsn$
IF clsn$ = "Y" OR clsn$ = "y" OR clsn$ = "n" OR clsn$ = "N" THEN

ELSE
        PRINT "Sorry, you must type in a Y (or y) or a N (or n)."
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        GOTO toper
END IF
CLS
COLOR 0
DO WHILE key$ = ""
IF clsn$ = "y" OR clsn$ = "Y" THEN
        CLS
ELSE
END IF
key$ = INKEY$
RANDOMIZE TIMER
tt = INT(RND * 517) + 63
jj = INT(RND * 360) + 63
FOR iii = tt TO tt + 1
g = 1
a = 64
FOR y = 1 TO 63
g = g + .2338701
a = a - 1
CIRCLE (iii, jj), y, g
IF y = 63 THEN EXIT FOR
PALETTE g, a
'FOR i = 1 TO 3000
'NEXT i
NEXT y
NEXT iii
LOOP
END SUB

SUB shape
CLS
SCREEN 12
LINE (300, 140)-(400, 200)
LINE (400, 200)-(420, 100)
LINE (420, 100)-(300, 140)
LINE (420, 100)-(460, 180)
LINE (460, 180)-(400, 200)
LINE (300, 140)-(420, 250)
LINE (420, 250)-(460, 180)
LINE (400, 200)-(420, 250)
PAINT (350, 175), 9, 15
PAINT (380, 175), 10, 15
PAINT (410, 210), 11, 15
PAINT (420, 150), 12, 15
LINE (300, 140)-(400, 200), 1
LINE (400, 200)-(420, 100), 2
LINE (420, 100)-(300, 140), 3
LINE (420, 100)-(460, 180), 4
LINE (460, 180)-(400, 200), 5
LINE (300, 140)-(420, 250), 6
LINE (420, 250)-(460, 180), 7
LINE (400, 200)-(420, 250), 8
PALETTE 4, 60
PALETTE 2, 60
PALETTE 5, 60
PALETTE 12, 60
PALETTE 1, 40
PALETTE 3, 40
PALETTE 10, 40
PALETTE 6, 20
PALETTE 7, 20
PALETTE 9, 20
PALETTE 8, 50
PALETTE 11, 50
END SUB

SUB starter
top:
CLS
INPUT "Would you like to view program 1 (1) or program 2 (2)?", which
IF which = 1 THEN CALL shape: END
IF which = 2 THEN CALL balls: END
PRINT "You must type in a 1 or a 2.": SLEEP 3: GOTO top
END SUB

