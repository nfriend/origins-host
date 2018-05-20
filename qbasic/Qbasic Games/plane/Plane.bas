







'                           Press Alt, B, A to quit                          '
'                           Press F5 to play again                           '









DECLARE SUB Einde ()
DECLARE FUNCTION Menu! (keuze AS INTEGER)
DECLARE SUB hiscores ()
DECLARE SUB LeesFile (naam AS STRING)
DECLARE SUB gameover ()
DECLARE SUB KRACHT3 ()
DECLARE SUB FIRE3 ()
DECLARE SUB Boem3 ()
DECLARE SUB FIRE2 ()
DECLARE SUB KRACHT2 ()
DECLARE SUB Boem2 ()
DECLARE SUB Boem ()
DECLARE SUB KRACHT ()
DECLARE SUB FIRE ()
COMMON SHARED hoek%, xkogel, ykogel, ykracht, xkracht, xkogel2, ykogel2, ykracht2, xkracht2, vuur%, vuur2%, t, t2, t3, score%, ykogeloud, xkogeloud, ykogeloud2, xkogeloud2, bonus%, xkogel3, ykogel3, ykracht3, xkracht3, vuur3%, ykogeloud3, xkogeloud3, game%, spelvoorbij%
RANDOMIZE (TIMER)
a = RND - .5
speed% = INT(21 * RND)

start:
CLEAR
SCREEN 12: CLS
LOCATE 2, 30
PRINT "Schoot-the-plane"
LOCATE 5, 37: PRINT "Choose : "
dummy% = Menu(0)

DO
 DO WHILE q$ = "": q$ = INKEY$: LOOP
 IF q$ = CHR$(27) OR q$ = "q" THEN Einde
 IF q$ = "h" THEN hiscores: GOTO start
 IF q$ = "p" THEN EXIT DO
 IF q$ = CHR$(0) + "H" THEN keuze% = keuze% - 1
 IF q$ = CHR$(0) + "P" THEN keuze% = keuze% + 1
 IF keuze% > 2 THEN keuze% = 0
 IF keuze% < 0 THEN keuze% = 2
 qstand$ = CHR$(Menu(keuze%))
 IF q$ = CHR$(13) THEN q$ = qstand$ ELSE q$ = ""
 
 LOOP

CLS : SCREEN 7: ammo% = 40: hoek% = 90
LINE (0, 180)-(320, 190), 2, BF
DO
y = INT(100 * RND) + 20
FOR x = 470 TO -10 STEP -1
IF x = 50 * INT(.02 * x) THEN a = RND - .5
y = y + a * SIN(.03 * x)
LINE (x - 1, y - 4)-(x + 3, y - 4), 0
LINE (x - 4, y - 3)-(x - 1, y - 3), 0: LINE (x - 1, y - 3)-(x + 2, y - 3), 8: LINE (x + 3, y - 3)-(x + 3, y - 1), 0
LINE (x - 28, y - 2)-(x - 4, y - 2), 0: LINE (x - 4, y - 2)-(x + 1, y - 2), 8: LINE (x + 2, y - 2)-(x + 2, y - 2), 0
LINE (x - 28, y - 1)-(x + 1, y - 1), 8: LINE (x + 2, y - 1)-(x + 2, y - 1), 0
LINE (x - 26, y)-(x, y), 8: LINE (x - 29, y)-(x - 27, y), 1: LINE (x + 1, y)-(x + 1, y), 0
LINE (x - 31, y + 1)-(x - 1, y + 1), 8: LINE (x - 20, y + 1)-(x - 7, y + 1), 7: LINE (x, y + 1)-(x, y + 1), 0
LINE (x - 29, y + 2)-(x - 3, y + 2), 8: LINE (x - 2, y + 2)-(x - 2, y + 2), 0
LINE (x - 29, y + 3)-(x - 4, y + 3), 0: LINE -(x + 2, y - 1), 0: LINE (x - 4, y + 3)-(x - 3, y + 3), 0
FOR i = 1 TO speed%: NEXT i
a$ = INKEY$
IF a$ = CHR$(0) + "K" THEN hoek% = hoek% - 2
IF a$ = CHR$(0) + "M" THEN hoek% = hoek% + 2
IF a$ = "4" THEN hoek% = hoek% - 4
IF a$ = "6" THEN hoek% = hoek% + 4
IF game% = 0 AND vuur% = 1 AND vuur2% = 1 AND vuur3% = 0 AND (a$ = CHR$(13) OR a$ = " ") THEN ammo% = ammo% - 1: KRACHT3: vuur3% = 1
IF game% = 0 AND vuur% = 1 AND vuur2% = 0 AND (a$ = CHR$(13) OR a$ = " ") THEN ammo% = ammo% - 1: KRACHT2: vuur2% = 1
IF game% = 0 AND vuur% = 0 AND (a$ = CHR$(13) OR a$ = " ") THEN ammo% = ammo% - 1: KRACHT: vuur% = 1
IF a$ = CHR$(27) THEN EXIT FOR
IF vuur% = 1 THEN FIRE
IF vuur2% = 1 THEN FIRE2
IF vuur3% = 1 THEN FIRE3
IF vuur% = 0 THEN xkogel = 160: ykogel = 180: xkracht = 0: ykracht = 0: t = 0: CIRCLE (xkogeloud, ykogeloud), 1, 0: LINE (xkogeloud, ykogeloud)-(xkogeloud, ykogeloud), 0
IF vuur2% = 0 THEN xkogel2 = 160: ykogel2 = 180: xkracht2 = 0: ykracht2 = 0: t2 = 0: CIRCLE (xkogeloud2, ykogeloud2), 1, 0: LINE (xkogeloud2, ykogeloud2)-(xkogeloud2, ykogeloud2), 0
IF vuur3% = 0 THEN xkogel3 = 160: ykogel3 = 180: xkracht3 = 0: ykracht3 = 0: t3 = 0: CIRCLE (xkogeloud3, ykogeloud3), 1, 0: LINE (xkogeloud3, ykogeloud3)-(xkogeloud3, ykogeloud3), 0
IF hoek% > 181 THEN hoek% = 0
IF hoek% < 0 THEN hoek% = hoek% + 180
IF ammo% = 0 THEN gameover
IF spelvoorbij% THEN GOTO start
COLOR 14: LOCATE 25, 1: PRINT USING "Ammo : ##"; ammo%; : LOCATE 25, 15: PRINT USING "Angle : ###"; hoek%; : PRINT CHR$(248); : LOCATE 25, 30: PRINT USING "Score : ###"; score%;
IF hoek% <> hoekoud% THEN LINE (160, 179)-(160 - 10 * COS((hoekoud% / 180) * 3.1415926536#), 179 - 10 * SIN((hoekoud% / 180) * 3.1415926536#)), 0: LINE (160, 179)-(160 - 10 * COS((hoek% / 180) * 3.1415926536#), 179 - 10 * SIN((hoek% / 180) * 3.1415926536#))
IF hoek% <> hoekoud% THEN hoekoud% = hoek%
t = t + 1: t2 = t2 + 1: t3 = t3 + 1
NEXT x
bonus% = 0
LOOP UNTIL a$ = CHR$(27)

GOTO start

SUB Boem
BEEP
score% = score% + 10 + bonus%
FOR d = 1 TO 33 STEP .05
c = c + 1: IF c = 16 THEN c = 1
CIRCLE (xkogel, ykogel), d, c, , , .2
NEXT d
FOR d = 33 TO 1 STEP -.1
CIRCLE (xkogel, ykogel), d, 0, , , .2
NEXT d
bonus% = bonus% + 5
END SUB

SUB Boem2
BEEP
score% = score% + 10 + bonus%
FOR d = 1 TO 33 STEP .05
c = c + 1: IF c = 16 THEN c = 1
CIRCLE (xkogel2, ykogel2), d, c, , , .2
NEXT d
FOR d = 33 TO 1 STEP -.1
CIRCLE (xkogel2, ykogel2), d, 0, , , .2
NEXT d
bonus% = bonus% + 5
END SUB

SUB Boem3
BEEP
score% = score% + 10 + bonus%
FOR d = 1 TO 33 STEP .05
c = c + 1: IF c = 16 THEN c = 1
CIRCLE (xkogel3, ykogel3), d, c, , , .2
NEXT d
FOR d = 33 TO 1 STEP -.1
CIRCLE (xkogel3, ykogel3), d, 0, , , .2
NEXT d
bonus% = bonus% + 5
END SUB

SUB Einde
SCREEN 13
CLS
OPEN "plane.hi" FOR INPUT AS #1
INPUT #1, a$
DO
        FOR i% = 32 TO 56
        COLOR i%
        FOR t% = 1 TO 100
        b$ = INKEY$
        IF b$ <> "" THEN SYSTEM
        NEXT t%
        LOCATE 12, 5: PRINT "The number ONE : '"; a$; "' rules"
        LOCATE 14, 3: PRINT "Try to beat that!!"
        NEXT i%
LOOP
CLOSE
END SUB

SUB FIRE
xkogel = xkogel + xkracht
ykogel = ykogel + ykracht + .5 * t * .0981
IF POINT(xkogel, ykogel) = 2 OR POINT(xkogel, ykogel) = -1 THEN vuur% = 0: GOTO eind
IF POINT(xkogel, ykogel) = 8 OR POINT(xkogel, ykogel) = 7 THEN Boem: vuur% = 0: GOTO eind
CIRCLE (xkogeloud, ykogeloud), 1, 0: LINE (xkogeloud, ykogeloud)-(xkogeloud, ykogeloud), 0
CIRCLE (xkogel, ykogel), 1, 15: LINE (xkogel, ykogel)-(xkogel, ykogel), 15
xkogeloud = xkogel: ykogeloud = ykogel
eind:
END SUB

SUB FIRE2
xkogel2 = xkogel2 + xkracht2
ykogel2 = ykogel2 + ykracht2 + .5 * t2 * .0981
IF POINT(xkogel2, ykogel2) = 2 OR POINT(xkogel2, ykogel2) = -1 THEN vuur2% = 0: GOTO eind2
IF POINT(xkogel2, ykogel2) = 8 OR POINT(xkogel2, ykogel2) = 7 THEN Boem2: vuur2% = 0: GOTO eind2
CIRCLE (xkogeloud2, ykogeloud2), 1, 0: LINE (xkogeloud2, ykogeloud2)-(xkogeloud2, ykogeloud2), 0
CIRCLE (xkogel2, ykogel2), 1, 4: LINE (xkogel2, ykogel2)-(xkogel2, ykogel2), 4
xkogeloud2 = xkogel2: ykogeloud2 = ykogel2
eind2:
END SUB

SUB FIRE3
xkogel3 = xkogel3 + xkracht3
ykogel3 = ykogel3 + ykracht3 + .5 * t3 * .0981
IF POINT(xkogel3, ykogel3) = 2 OR POINT(xkogel3, ykogel3) = -1 THEN vuur3% = 0: GOTO eind3
IF POINT(xkogel3, ykogel3) = 8 OR POINT(xkogel3, ykogel3) = 7 THEN Boem3: vuur3% = 0: GOTO eind3
CIRCLE (xkogeloud3, ykogeloud3), 1, 0: LINE (xkogeloud3, ykogeloud3)-(xkogeloud3, ykogeloud3), 0
CIRCLE (xkogel3, ykogel3), 1, 5: LINE (xkogel3, ykogel3)-(xkogel3, ykogel3), 5
xkogeloud3 = xkogel3: ykogeloud3 = ykogel3
eind3:
END SUB

SUB gameover
game% = 1
IF vuur% = 0 AND vuur2% = 0 AND vuur3% = 0 THEN
 SCREEN 13: CLS
 DO
 FOR cr% = 16 TO 31
 COLOR cr%
 LOCATE 13, 7: PRINT USING "You scored ### points"; score%
 FOR i% = 1 TO 20000: NEXT i%
 NEXT cr%
 FOR cr% = 31 TO 16 STEP -1
 COLOR cr%
 LOCATE 13, 7: PRINT USING "You scored ### points"; score%
 FOR i% = 1 TO 20000: NEXT i%
 NEXT cr%
 LOOP WHILE INKEY$ = ""
 COLOR 15

 OPEN "plane.hi" FOR INPUT AS #1
 INPUT #1, invoer$, invoer$, invoer$, invoer$, invoer$, invoer$, invoer$, invoer$, invoer$, invoer$
 CLOSE
 IF VAL(invoer$) < score% THEN
 LOCATE 15, 2
 PRINT "You have got a HISCORE!!! Type your name :"
 INPUT naam$
 END IF
 LeesFile (naam$)
 spelvoorbij% = 1
END IF
END SUB

SUB hiscores
OPEN "plane.hi" FOR INPUT AS #1
CLS
COLOR 14
LOCATE 10
LOCATE , 24: PRINT "***********************************"
LOCATE , 24: PRINT "*             "; : COLOR 4: PRINT "Hiscores"; : COLOR 14: PRINT "            *"
LOCATE , 24: PRINT "***********************************"
LOCATE , 24: PRINT "*                                 *"
FOR i = 1 TO 5
INPUT #1, a$, b$
LOCATE , 24: PRINT "* "; : COLOR 6: PRINT USING "# \                 \      ####"; i; a$; VAL(b$); : COLOR 14: PRINT " *"
NEXT
COLOR 14
LOCATE , 24: PRINT "*                                 *"
LOCATE , 24: PRINT "***********************************"
CLOSE
COLOR 15
LOCATE 29
PRINT "Press any key to continu";
DO WHILE c$ = "": c$ = INKEY$: LOOP
END SUB

SUB KRACHT
xkracht = 4 * COS((hoek% / 180) * 3.1415926536# + 3.1415926536#)
ykracht = 4 * SIN((hoek% / 180) * 3.1415926536# + 3.1415926536#)
END SUB

SUB KRACHT2
xkracht2 = 4 * COS((hoek% / 180) * 3.1415926536# + 3.1415926536#)
ykracht2 = 4 * SIN((hoek% / 180) * 3.1415926536# + 3.1415926536#)
END SUB

SUB KRACHT3
xkracht3 = 4 * COS((hoek% / 180) * 3.1415926536# + 3.1415926536#)
ykracht3 = 4 * SIN((hoek% / 180) * 3.1415926536# + 3.1415926536#)
END SUB

SUB LeesFile (naam AS STRING)

DIM a$(4)
DIM c%(4)

OPEN "plane.hi" FOR INPUT AS #1
FOR i = 1 TO 5
INPUT #1, a$(i - 1), b$
c%(i - 1) = VAL(b$)
IF plek% = 0 AND score% > c%(i - 1) THEN plek% = i
NEXT
CLOSE
FOR i = 0 TO 4
NEXT
IF plek% <> 0 THEN
        FOR i = 5 TO plek% + 1 STEP -1
        a$(i - 1) = a$(i - 2)
        c%(i - 1) = c%(i - 2)
        NEXT
     
        a$(plek% - 1) = naam$
        c%(plek% - 1) = score%
END IF

OPEN "plane.hi" FOR OUTPUT AS #1
FOR i = 0 TO 4
PRINT #1, a$(i)
PRINT #1, c%(i)
NEXT
CLOSE

OPEN "plane.hi" FOR INPUT AS #1
FOR i = 0 TO 4
INPUT #1, d$, e%
NEXT
CLOSE

END SUB

FUNCTION Menu (keuze AS INTEGER)
IF keuze% = 0 THEN
 COLOR 14
  LOCATE 7, 36: PRINT CHR$(16) + " (P)lay"
 COLOR 15
 LOCATE 8, 36: PRINT "  (H)iscores"
 LOCATE 9, 36: PRINT "  (Q)uit"
 Menu = 115
END IF

IF keuze% = 1 THEN
 LOCATE 7, 36: PRINT "  (P)lay"
 COLOR 14
  LOCATE 8, 36: PRINT CHR$(16) + " (H)iscores"
 COLOR 15
 LOCATE 9, 36: PRINT "  (Q)uit"
 Menu = 104
END IF

IF keuze% = 2 THEN
 LOCATE 7, 36: PRINT "  (P)lay"
 LOCATE 8, 36: PRINT "  (H)iscores"
 COLOR 14
  LOCATE 9, 36: PRINT CHR$(16) + " (Q)uit"
 COLOR 15
 Menu = 101
END IF



'chr$(16)'
END FUNCTION

