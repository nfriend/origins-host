







'                            Type Alt, b, a to quit                          '
'                            Type Shift + F5 to play                         '








DECLARE SUB help ()
DECLARE SUB INTRO ()
DECLARE SUB DOOD1 ()
DECLARE SUB DOOD2 ()
DECLARE SUB DOOD3 ()
DECLARE SUB NogEenKeer ()
COMMON SHARED start, ax, ay, bx, by, sp1$, sp2$, speed, score1, score2
INTRO
10 ax = 1: ay = 100: bx = 318: by = 100: x1 = 1: y1 = 0: x2 = -1: y2 = 0: start = 0
CLS : SCREEN 7: LINE (0, 0)-(319, 199), 15, B
LINE (ax, ay)-(ax, ay), 2: LINE (bx, by)-(bx, by), 1
DO: a$ = INKEY$
IF a$ = CHR$(0) + "H" THEN y2 = -1: x2 = 0
IF a$ = CHR$(0) + "P" THEN y2 = 1: x2 = 0
IF a$ = CHR$(0) + "K" THEN x2 = -1: y2 = 0
IF a$ = CHR$(0) + "M" THEN x2 = 1: y2 = 0
IF a$ = "w" OR a$ = "e" THEN y1 = -1: x1 = 0
IF a$ = "x" OR a$ = "z" OR a$ = "s" THEN y1 = 1: x1 = 0
IF a$ = "a" THEN x1 = -1: y1 = 0
IF a$ = "d" THEN x1 = 1: y1 = 0
ax = ax + x1: ay = ay + y1
bx = bx + x2: by = by + y2
IF POINT(ax, ay) <> 0 AND POINT(bx, by) <> 0 THEN DOOD3
IF POINT(ax, ay) <> 0 THEN DOOD1
IF POINT(bx, by) <> 0 THEN DOOD2
IF start = 1 THEN 10
LINE (ax, ay)-(ax, ay), 14: LINE (bx, by)-(bx, by), 4
FOR i = 1 TO (9000 - 7.5 * (speed * 10)): NEXT i
LOOP UNTIL a$ = CHR$(27)

SUB DOOD1
kleur% = 14
FOR d = 0 TO 4 STEP .04
IF kleur% = 14 THEN kleur% = 15: GOTO hier
IF kleur% = 4 THEN kleur% = 14: GOTO hier
IF kleur% = 15 THEN kleur% = 4
hier:
CIRCLE (ax, ay), 4, kleur%: PAINT (ax, ay), kleur%, kleur%
FOR i = 1 TO 200: NEXT i
NEXT d
CLS : SCREEN 7: LOCATE 10, 8: COLOR 4: PRINT sp2$; " has won!!!"
LOCATE 12, 9: COLOR 14: PRINT sp1$; " has LOST!"
LOCATE 24, 1: COLOR 15: PRINT "Press <ENTER> to continue";
DO: a$ = INKEY$
c = c + 1: IF c = 16 THEN c = 1
LINE (50, 65)-(265, 100), c, B
LOOP UNTIL a$ = CHR$(13)
score2 = score2 + 1
NogEenKeer
END SUB

SUB DOOD2
kleur% = 14
FOR d = 0 TO 4 STEP .04
IF kleur% = 14 THEN kleur% = 15: GOTO hier2
IF kleur% = 4 THEN kleur% = 14: GOTO hier2
IF kleur% = 15 THEN kleur% = 4
hier2:
CIRCLE (bx, by), 4, kleur%: PAINT (bx, by), kleur%, kleur%
FOR i = 1 TO 200: NEXT i
NEXT d
CLS : SCREEN 7: LOCATE 10, 8: COLOR 14: PRINT sp1$; " has won!!!"
LOCATE 12, 9: COLOR 4: PRINT sp2$; " has LOST!"
LOCATE 24, 1: COLOR 15: PRINT "Press <ENTER> to continue";
DO: a$ = INKEY$
c = c + 1: IF c = 16 THEN c = 1
LINE (50, 65)-(265, 100), c, B
LOOP UNTIL a$ = CHR$(13)
score1 = score1 + 1
NogEenKeer
END SUB

SUB DOOD3
kleur% = 14
FOR d = 0 TO 4 STEP .04
IF kleur% = 14 THEN kleur% = 15: GOTO hier3
IF kleur% = 4 THEN kleur% = 14: GOTO hier3
IF kleur% = 15 THEN kleur% = 4
hier3:
CIRCLE (ax, ay), 4, kleur%: PAINT (ax, ay), kleur%, kleur%
CIRCLE (bx, by), 4, kleur%: PAINT (bx, by), kleur%, kleur%
FOR i = 1 TO 200: NEXT i
NEXT d
CLS : SCREEN 7: LOCATE 12, 15: COLOR 6: PRINT "It's a tie"
LOCATE 24, 1: COLOR 15: PRINT "Press <ENTER> to continu";
DO
c = c + 1
IF c = 16 THEN c = 1
LINE (103, 83)-(205, 100), c, B
a$ = INKEY$
LOOP UNTIL a$ = CHR$(13)
score1 = score1 + .5
score2 = score2 + .5
NogEenKeer
END SUB

SUB help
CLS : SCREEN 12
LOCATE 2, 27: PRINT "LINE HELP-SECTION"
LOCATE 5, 3: PRINT "The purpose :"
LOCATE 7, 5: PRINT "You must keep your own line on the screen (player 1 starts on the left)."
LOCATE , 5: PRINT "The player who crashes into something loses. Where something is the wall,"
LOCATE , 5: PRINT "your opponent or yourself. So you can win by forcing you opponent against"
LOCATE , 5: PRINT "the wall or at least give him as little space as possible."
LOCATE , 5: PRINT
LOCATE , 5: PRINT "NOTE : You can crash into your by steering in the wrong direction!"
LOCATE 15, 3: PRINT "The controls :"
LOCATE 17, 5: PRINT "          Player 1                                 Player 2"
LOCATE 19, 5: PRINT "              w"
LOCATE 21, 5: PRINT "           a     d                                 Arrowkeys"
LOCATE 23, 5: PRINT "              s"
LOCATE 28, 25: PRINT "Press any key to play!!"
LINE (147, 305)-(147, 350)
LINE (130, 327)-(163, 327)
DO: b$ = INKEY$: LOOP WHILE b$ = ""
END SUB

SUB INTRO
CLS : SCREEN 7: LOCATE 2, 16: COLOR 12: PRINT "LINE"
LOCATE 13, 10: COLOR 14: PRINT CHR$(16); " Play"
LOCATE 14, 10: COLOR 15: PRINT "  Help"
DO
       
        DO: a$ = INKEY$: LOOP UNTIL a$ = CHR$(13) OR a$ = CHR$(0) + "H" OR a$ = CHR$(0) + "P"
        IF a$ <> CHR$(13) THEN keuze% = NOT keuze%
        
        IF NOT keuze% THEN
                LOCATE 13, 10: COLOR 14: PRINT CHR$(16); " Play"
                LOCATE 14, 10: COLOR 15: PRINT "  Help"
        ELSE
                LOCATE 13, 10: COLOR 15: PRINT "  Play"
                LOCATE 14, 10: COLOR 14: PRINT CHR$(16); " Help"
        END IF

LOOP UNTIL a$ = CHR$(13)

IF keuze% THEN help

CLS : SCREEN 7: LOCATE 2, 16: COLOR 12: PRINT "LINE"
LOCATE 13, 10: COLOR 4: PRINT "Player 2 : ": LOCATE 15, 10: COLOR 7: PRINT "Speed (1-100) : "
LOCATE 11, 10: COLOR 14: INPUT "Player 1 : ", sp1$
LOCATE 13, 10: COLOR 4: INPUT "Player 2 : ", sp2$
LOCATE 15, 10: COLOR 7: INPUT "Speed (1-100) : ", speed
IF sp1$ = "" THEN sp1$ = "Speler 1"
IF sp2$ = "" THEN sp2$ = "Speler 2"
DO
IF speed < 0 OR speed > 100 THEN LOCATE 15, 29: PRINT STRING$(5, " "): LOCATE 15, 29: INPUT "", speed
LOOP WHILE speed < 0 OR speed > 100
IF speed = 0 THEN speed = 50
FOR i = 1 TO 5000: NEXT i
END SUB

SUB NogEenKeer
CLS
IF INT(score1) <> score1 THEN bij$ = CHR$(171)
IF score1 <> .5 AND score1 < 10 THEN LOCATE 2, 10: COLOR 14: PRINT sp1$; " :"; INT(score1); : LOCATE 2, (LEN(sp1$) + 14): PRINT bij$
IF score2 <> .5 AND score2 < 10 THEN LOCATE 4, 10: COLOR 4: PRINT sp2$; " :"; INT(score2); : LOCATE 4, (LEN(sp2$) + 14): PRINT bij$
IF score1 = .5 THEN LOCATE 2, 10: COLOR 14: PRINT sp1$; " : "; bij$
IF score2 = .5 THEN LOCATE 4, 10: COLOR 4: PRINT sp2$; " : "; bij$
IF score1 >= 10 THEN LOCATE 2, 10: COLOR 14: PRINT sp1$; " :"; INT(score1): LOCATE 2, (LEN(sp1$) + 15): PRINT bij$
IF score2 >= 10 THEN LOCATE 4, 10: COLOR 4: PRINT sp2$; " :"; INT(score2): LOCATE 4, (LEN(sp2$) + 15): PRINT bij$
bij$ = ""
DO: a$ = INKEY$
FOR i = 1 TO 800: NEXT i
c = c + 1: IF c = 16 THEN c = 1
COLOR c: LOCATE 11, 10: PRINT "Do you want to play again?"
LOOP UNTIL a$ = "n" OR a$ = "y" OR a$ = CHR$(27) OR a$ = CHR$(13)
IF a$ = "n" OR a$ = CHR$(27) THEN SYSTEM
start = 1
END SUB

