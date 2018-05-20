







'                            Alt, f, x to quit                               '
'                            Shift + F5 to play                              '








DECLARE FUNCTION computer$ (kleur1$, kleur2$, kleur3$, kleur4$, kleur5$, kleur6$, kleur7$, kleur8$, kleur9$)

RANDOMIZE (TIMER)
10 CLS : SCREEN 12: WINDOW (-30, -30)-(30, 30): c = 14: s = beurt: kleur1$ = "": kleur2$ = "": kleur3$ = "": kleur4$ = "": kleur5$ = "": kleur6$ = "": kleur7$ = "": kleur8$ = "": kleur9$ = "": x = 0: y = 0: x1 = 0: y1 = 0: pe$ = "": pt$ = "": p3$ = "": p4$ = "": p5$ = "": p6$ = "": p7$ = "": p8$ = "": p9$ = ""
12 beurt = beurt + 1: IF beurt = 2 THEN beurt = 0
15 IF p1$ <> "" THEN COLOR 15: LOCATE 2, 1: PRINT p1$; " : "; score1: LOCATE 2, 65: PRINT p2$; " : "; score2
20 COLOR 15: LOCATE 3, 31: PRINT "Tic-Tac-Toe": COLOR c
30 LINE (-15, -15)-(15, 15), , B: LINE (-17, -17)-(17, 17), , B: PAINT (16, 16), c, c
40 LINE (-4, -15)-(-4, 15): LINE (-6, -15)-(-6, 15): PAINT (-5, 0), c, c
50 LINE (4, -15)-(4, 15): LINE (6, -15)-(6, 15): PAINT (5, 0), c, c
60 LINE (-15, -4)-(15, -4): LINE (-15, -6)-(15, -6): PAINT (0, -5), c, c: PAINT (-10, -5), c, c: PAINT (10, -5), c, c
70 LINE (-15, 4)-(15, 4): LINE (-15, 6)-(15, 6): PAINT (0, 5), c, c: PAINT (-10, 5), c, c: PAINT (10, 5), c, c
80 LOCATE 10, 27: PRINT "7": LOCATE 10, 40: PRINT "8": LOCATE 10, 54: PRINT "9"
90 LOCATE 16, 27: PRINT "4": LOCATE 16, 40: PRINT "5": LOCATE 16, 54: PRINT "6"
100 LOCATE 21, 27: PRINT "1": LOCATE 21, 40: PRINT "2": LOCATE 21, 54: PRINT "3"
103 IF p1$ <> "" THEN LOCATE 25, 31: PRINT "same names?": DO: a$ = INKEY$: LOOP WHILE a$ = "": IF a$ = "n" THEN LOCATE 25, 31: PRINT "              ": score1 = 0: score2 = 0: GOTO 110 ELSE 126
105 COLOR 9: LOCATE 25, 31: INPUT "Players(1-2)"; spelers%
    IF spelers% <> 1 AND spelers% <> 2 THEN 105
110 COLOR 9: LOCATE 26, 31: INPUT "Player 1 : ", p1$
120 IF spelers% = 2 THEN COLOR 9: LOCATE 27, 31: INPUT "Player 2 : ", p2$
122 IF p1$ = "" THEN p1$ = "Player 1"
124 IF p2$ = "" THEN
        IF spelers% = 2 THEN p2$ = "Player 2" ELSE p2$ = "Computer"
    END IF

126 COLOR 15: LOCATE 2, 1: PRINT p1$; " : "; score1: LOCATE 2, 65: PRINT p2$; " : "; score2:
130 LOCATE 25, 31: PRINT "                                  ": LOCATE 26, 31: PRINT "                                  ": LOCATE 27, 31: PRINT "                                  "
140 COLOR 11: IF s = 0 THEN LOCATE 5, 2: COLOR 12: PRINT p1$; "'s turn                 " ELSE LOCATE 5, 2: COLOR 2: PRINT p2$; : PRINT "'s turn              "
150 IF (s = 0 AND spelers% = 1) OR spelers% = 2 THEN DO: a$ = INKEY$: LOOP WHILE a$ = ""
    IF s = 1 AND spelers% = 1 THEN a$ = computer$(kleur1$, kleur2$, kleur3$, kleur4$, kleur5$, kleur6$, kleur7$, kleur8$, kleur9$)
160 IF a$ = "7" AND s < 1 AND pe$ <> "1" THEN x = -14: y = 14: x1 = -7: y1 = 7: c = 12: pe$ = "1": s = s + 1: kleur7$ = "r"
170 IF a$ = "8" AND s < 1 AND pt$ <> "1" THEN x = -3: y = 14: x1 = 3: y1 = 7: c = 12: pt$ = "1": s = s + 1: kleur8$ = "r"
180 IF a$ = "9" AND s < 1 AND p3$ <> "1" THEN x = 14: y = 14: x1 = 7: y1 = 7: c = 12: p3$ = "1": s = s + 1: kleur9$ = "r"
190 IF a$ = "4" AND s < 1 AND p4$ <> "1" THEN x = -14: y = 3: x1 = -7: y1 = -3: c = 12: p4$ = "1": s = s + 1: kleur4$ = "r"
200 IF a$ = "5" AND s < 1 AND p5$ <> "1" THEN x = -3: y = 3: x1 = 3: y1 = -3: c = 12: p5$ = "1": s = s + 1: kleur5$ = "r"
210 IF a$ = "6" AND s < 1 AND p6$ <> "1" THEN x = 14: y = 3: x1 = 7: y1 = -3: c = 12: p6$ = "1": s = s + 1: kleur6$ = "r"
220 IF a$ = "1" AND s < 1 AND p7$ <> "1" THEN x = -14: y = -14: x1 = -7: y1 = -7: c = 12: p7$ = "1": s = s + 1: kleur1$ = "r"
230 IF a$ = "2" AND s < 1 AND p8$ <> "1" THEN x = -3: y = -14: x1 = 3: y1 = -7: c = 12: p8$ = "1": s = s + 1: kleur2$ = "r"
240 IF a$ = "3" AND s < 1 AND p9$ <> "1" THEN x = 14: y = -14: x1 = 7: y1 = -7: c = 12: p9$ = "1": s = s + 1: kleur3$ = "r"
250 IF a$ = "7" AND s > 0 AND pe$ <> "1" THEN x = -14: y = 14: x1 = -7: y1 = 7: c = 2: pe$ = "1": s = s - 1: kleur7$ = "g"
260 IF a$ = "8" AND s > 0 AND pt$ <> "1" THEN x = -3: y = 14: x1 = 3: y1 = 7: c = 2: pt$ = "1": s = s - 1: kleur8$ = "g"
270 IF a$ = "9" AND s > 0 AND p3$ <> "1" THEN x = 14: y = 14: x1 = 7: y1 = 7: c = 2: p3$ = "1": s = s - 1: kleur9$ = "g"
280 IF a$ = "4" AND s > 0 AND p4$ <> "1" THEN x = -14: y = 3: x1 = -7: y1 = -3: c = 2: p4$ = "1": s = s - 1: kleur4$ = "g"
290 IF a$ = "5" AND s > 0 AND p5$ <> "1" THEN x = -3: y = 3: x1 = 3: y1 = -3: c = 2: p5$ = "1": s = s - 1: kleur5$ = "g"
300 IF a$ = "6" AND s > 0 AND p6$ <> "1" THEN x = 14: y = 3: x1 = 7: y1 = -3: c = 2: p6$ = "1": s = s - 1: kleur6$ = "g"
310 IF a$ = "1" AND s > 0 AND p7$ <> "1" THEN x = -14: y = -14: x1 = -7: y1 = -7: c = 2: p7$ = "1": s = s - 1: kleur1$ = "g"
320 IF a$ = "2" AND s > 0 AND p8$ <> "1" THEN x = -3: y = -14: x1 = 3: y1 = -7: c = 2: p8$ = "1": s = s - 1: kleur2$ = "g"
330 IF a$ = "3" AND s > 0 AND p9$ <> "1" THEN x = 14: y = -14: x1 = 7: y1 = -7: c = 2: p9$ = "1": s = s - 1: kleur3$ = "g"
340 IF a$ = CHR$(27) THEN END
350 LINE (x, y)-(x1, y1), c, B: PAINT ((x + x1) / 2, (y + y1) / 2), c, c
360 IF kleur1$ <> "" AND kleur1$ = kleur2$ AND kleur2$ = kleur3$ THEN 480
370 IF kleur4$ <> "" AND kleur4$ = kleur5$ AND kleur5$ = kleur6$ THEN 480
380 IF kleur7$ <> "" AND kleur7$ = kleur8$ AND kleur8$ = kleur9$ THEN 480
390 IF kleur1$ <> "" AND kleur1$ = kleur4$ AND kleur4$ = kleur7$ THEN 480
400 IF kleur2$ <> "" AND kleur2$ = kleur5$ AND kleur5$ = kleur8$ THEN 480
410 IF kleur3$ <> "" AND kleur3$ = kleur6$ AND kleur6$ = kleur9$ THEN 480
420 IF kleur1$ <> "" AND kleur1$ = kleur5$ AND kleur5$ = kleur9$ THEN 480
430 IF kleur3$ <> "" AND kleur3$ = kleur5$ AND kleur5$ = kleur7$ THEN 480
440 IF pe$ = "1" AND pt$ = "1" AND p3$ = "1" AND p4$ = "1" AND p5$ = "1" AND p6$ = "1" AND p7$ = "1" AND p8$ = "1" AND p9$ = "1" THEN BEEP: GOTO 500
450 IF s = 0 THEN COLOR 12: LOCATE 5, 2: PRINT p1$; "'s turn                " ELSE COLOR 2: LOCATE 5, 2: PRINT p2$; : PRINT "'s turn              "
460 GOTO 150
470 REM Dit alles is gecre‰erd door Jarno vd Kolk
480 PLAY "l16 o1 mb ml t255 cde c. p32 c+d+e c+."
490 COLOR 5: LOCATE 15, 30: IF s = 0 THEN PRINT p2$; " has won": score2 = score2 + 1 ELSE PRINT p1$; " has won": score1 = score1 + 1
500 COLOR 15: LOCATE 2, 1: PRINT p1$; " : "; score1: LOCATE 2, 65: PRINT p2$; " : "; score2: COLOR 7: LOCATE 26, 35: PRINT "Again?": DO: a$ = INKEY$: LOOP UNTIL a$ <> "": IF a$ = "n" THEN SYSTEM:  ELSE 10

FUNCTION computer$ (kleur1$, kleur2$, kleur3$, kleur4$, kleur5$, kleur6$, kleur7$, kleur8$, kleur9$)
computer$ = CHR$(INT(9 * RND) + 49)

IF kleur5$ = "" THEN computer$ = "5"

IF kleur1$ = "r" AND kleur2$ = "" AND kleur3$ = "" AND kleur4$ = "" AND kleur5$ = "g" AND kleur6$ = "" AND kleur7$ = "" AND kleur8$ = "" AND kleur9$ = "r" THEN
        keus% = INT(4 * RND) + 1
                IF keus% = 1 THEN computer$ = "2"
                IF keus% = 2 THEN computer$ = "4"
                IF keus% = 3 THEN computer$ = "6"
                IF keus% = 4 THEN computer$ = "8"
END IF

IF kleur1$ = "" AND kleur2$ = "" AND kleur3$ = "r" AND kleur4$ = "" AND kleur5$ = "g" AND kleur6$ = "" AND kleur7$ = "r" AND kleur8$ = "" AND kleur9$ = "" THEN
        keus% = INT(4 * RND) + 1
                IF keus% = 1 THEN computer$ = "2"
                IF keus% = 2 THEN computer$ = "4"
                IF keus% = 3 THEN computer$ = "6"
                IF keus% = 4 THEN computer$ = "8"
END IF

IF kleur1$ = "" AND kleur2$ = "r" AND kleur3$ = "" AND kleur4$ = "r" AND kleur5$ = "g" AND kleur6$ = "" AND kleur7$ = "" AND kleur8$ = "" AND kleur9$ = "" THEN
        keus% = INT(3 * RND) + 1
                IF keus% = 1 THEN computer$ = "1"
                IF keus% = 2 THEN computer$ = "3"
                IF keus% = 3 THEN computer$ = "7"
END IF

IF kleur1$ = "" AND kleur2$ = "r" AND kleur3$ = "" AND kleur4$ = "" AND kleur5$ = "g" AND kleur6$ = "r" AND kleur7$ = "" AND kleur8$ = "" AND kleur9$ = "" THEN
        keus% = INT(3 * RND) + 1
                IF keus% = 1 THEN computer$ = "1"
                IF keus% = 2 THEN computer$ = "3"
                IF keus% = 3 THEN computer$ = "9"
END IF

IF kleur1$ = "" AND kleur2$ = "" AND kleur3$ = "" AND kleur4$ = "" AND kleur5$ = "g" AND kleur6$ = "r" AND kleur7$ = "" AND kleur8$ = "r" AND kleur9$ = "" THEN
        keus% = INT(3 * RND) + 1
                IF keus% = 1 THEN computer$ = "3"
                IF keus% = 2 THEN computer$ = "7"
                IF keus% = 3 THEN computer$ = "9"
END IF

IF kleur1$ = "" AND kleur2$ = "" AND kleur3$ = "" AND kleur4$ = "r" AND kleur5$ = "g" AND kleur6$ = "" AND kleur7$ = "" AND kleur8$ = "r" AND kleur9$ = "" THEN
        keus% = INT(3 * RND) + 1
                IF keus% = 1 THEN computer$ = "1"
                IF keus% = 2 THEN computer$ = "7"
                IF keus% = 3 THEN computer$ = "9"
END IF


IF kleur1$ = "" AND kleur2$ = "" AND kleur3$ = "" AND kleur4$ = "" AND kleur5$ = "r" AND kleur6$ = "" AND kleur7$ = "" AND kleur8$ = "" AND kleur9$ = "" THEN
        keus% = INT(4 * RND) + 1
                IF keus% = 1 THEN computer$ = "1"
                IF keus% = 2 THEN computer$ = "3"
                IF keus% = 3 THEN computer$ = "7"
                IF keus% = 4 THEN computer$ = "9"
END IF

IF ((kleur1$ = "r" AND kleur9$ = "g") OR (kleur1$ = "g" AND kleur9$ = "r")) AND kleur2$ = "" AND kleur3$ = "" AND kleur4$ = "" AND kleur5$ = "r" AND kleur6$ = "" AND kleur7$ = "" AND kleur8$ = "" THEN
        keus% = INT(2 * RND) + 1
                IF keus% = 1 THEN computer$ = "3"
                IF keus% = 2 THEN computer$ = "7"
END IF

IF ((kleur3$ = "r" AND kleur7$ = "g") OR (kleur7$ = "g" AND kleur3$ = "r")) AND kleur2$ = "" AND kleur1$ = "" AND kleur4$ = "" AND kleur5$ = "r" AND kleur6$ = "" AND kleur9$ = "" AND kleur8$ = "" THEN
        keus% = INT(2 * RND) + 1
                IF keus% = 1 THEN computer$ = "1"
                IF keus% = 2 THEN computer$ = "9"
END IF



FOR i% = 1 TO 2

IF i% = 1 THEN ding$ = "r"
IF i% = 2 THEN ding$ = "g"

IF kleur1$ = ding$ AND kleur2$ = ding$ AND kleur3$ = "" THEN computer$ = "3"
IF kleur1$ = ding$ AND kleur2$ = "" AND kleur3$ = ding$ THEN computer$ = "2"
IF kleur1$ = "" AND kleur2$ = ding$ AND kleur3$ = ding$ THEN computer$ = "1"

IF kleur4$ = ding$ AND kleur5$ = ding$ AND kleur6$ = "" THEN computer$ = "6"
IF kleur4$ = ding$ AND kleur5$ = "" AND kleur6$ = ding$ THEN computer$ = "5"
IF kleur4$ = "" AND kleur5$ = ding$ AND kleur6$ = ding$ THEN computer$ = "4"

IF kleur7$ = ding$ AND kleur8$ = ding$ AND kleur9$ = "" THEN computer$ = "9"
IF kleur7$ = ding$ AND kleur8$ = "" AND kleur9$ = ding$ THEN computer$ = "8"
IF kleur7$ = "" AND kleur8$ = ding$ AND kleur9$ = ding$ THEN computer$ = "7"

IF kleur1$ = ding$ AND kleur4$ = ding$ AND kleur7$ = "" THEN computer$ = "7"
IF kleur1$ = ding$ AND kleur4$ = "" AND kleur7$ = ding$ THEN computer$ = "4"
IF kleur1$ = "" AND kleur4$ = ding$ AND kleur7$ = ding$ THEN computer$ = "1"

IF kleur2$ = ding$ AND kleur5$ = ding$ AND kleur8$ = "" THEN computer$ = "8"
IF kleur2$ = ding$ AND kleur5$ = "" AND kleur8$ = ding$ THEN computer$ = "5"
IF kleur2$ = "" AND kleur5$ = ding$ AND kleur8$ = ding$ THEN computer$ = "2"

IF kleur3$ = ding$ AND kleur6$ = ding$ AND kleur9$ = "" THEN computer$ = "9"
IF kleur3$ = ding$ AND kleur6$ = "" AND kleur9$ = ding$ THEN computer$ = "6"
IF kleur3$ = "" AND kleur6$ = ding$ AND kleur9$ = ding$ THEN computer$ = "3"

IF kleur3$ = ding$ AND kleur5$ = ding$ AND kleur7$ = "" THEN computer$ = "7"
IF kleur3$ = ding$ AND kleur5$ = "" AND kleur7$ = ding$ THEN computer$ = "5"
IF kleur3$ = "" AND kleur5$ = ding$ AND kleur7$ = ding$ THEN computer$ = "3"

IF kleur1$ = ding$ AND kleur5$ = ding$ AND kleur9$ = "" THEN computer$ = "9"
IF kleur1$ = ding$ AND kleur5$ = "" AND kleur9$ = ding$ THEN computer$ = "5"
IF kleur1$ = "" AND kleur5$ = ding$ AND kleur9$ = ding$ THEN computer$ = "1"

NEXT i%

END FUNCTION

