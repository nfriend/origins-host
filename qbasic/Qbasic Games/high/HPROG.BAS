  ON ERROR GOTO 112
  DEF SEG = 0
  KeyFlags = PEEK(1047)
  IF (KeyFlags AND 32) = 0 THEN POKE 1047, KeyFlags OR 32
  OPEN "TOCKE.DAT" FOR INPUT AS #1
  INPUT #1, IME1$
  INPUT #1, HIGH1
  INPUT #1, IME2$
  INPUT #1, HIGH2
  INPUT #1, IME3$
  INPUT #1, HIGH3
  INPUT #1, IME4$
  INPUT #1, HIGH4
  INPUT #1, IME5$
  INPUT #1, HIGH5
  CLOSE #1
  GOTO 109
5 COLOR 6, 14
  DIM Left%(400)
  DIM Right%(400)
  DIM Space%(400)
  DIM Krsta%(400)
  DIM Ldead%(400)
  DIM Rdead%(400)
  DIM Kocija%(400)
  DIM Space2%(400)
  TOC1 = 0
  TOC2 = 0
  CAS = 201
  GET (140, 50)-(156, 70), Space2%
  OPEN "KOCIJA.DAT" FOR INPUT AS #1
  FOR A = 1 TO 20
  FOR B = 1 TO 16
  INPUT #1, SLI
  PSET (140 + B, 61 + A), SLI
  NEXT B, A
  CLOSE #1
  GET (141, 61)-(156, 82), Kocija%
  'Right
  OPEN "RIGHT.DAT" FOR INPUT AS #1
  FOR A = 1 TO 16
  FOR B = 1 TO 11
  INPUT #1, SLI
  PSET (260 + B, 80 + A), SLI
  NEXT B, A
  CLOSE #1
  GET (261, 81)-(271, 96), Right%
  'Left
  OPEN "LEFT.DAT" FOR INPUT AS #1
  FOR A = 1 TO 16
  FOR B = 1 TO 11
  INPUT #1, SLI
  PSET (40 + B, 80 + A), SLI
  NEXT B, A
  CLOSE #1
  GET (41, 81)-(51, 96), Left%
  'Space
  GET (11, 51)-(21, 76), Space%
10 CLS
   KOC = 0
   ZIP = 0
   Y3 = 61
   LINE (0, 0)-(320, 30), 8, BF
   LINE (4, 4)-(315, 26), 6, B
   OPEN "KAKTUS.DAT" FOR INPUT AS #1
   FOR A = 1 TO 20
   FOR B = 1 TO 16
   INPUT #1, SLI
   PSET (220 + B, 60 + A), SLI
   NEXT B, A
   CLOSE #1
   OPEN "KAKTUS.DAT" FOR INPUT AS #1
   FOR A = 1 TO 20
   FOR B = 1 TO 16
   INPUT #1, SLI
   PSET (70 + B, 145 + A), SLI
   NEXT B, A
   CLOSE #1
   Y1 = 81
   Y2 = 81
   YK = 120
   MET1 = 6
   MET2 = 6
   PUT (41, Y2), Left%, PSET
   PUT (261, Y1), Right%, PSET
   PUT (141, Y3), Kocija%
20 IF STR1 = 1 THEN GOSUB 105
   IF STR2 = 1 THEN GOSUB 106
   KEYS$ = INKEY$
   SELECT CASE KEYS$
   CASE "q": PUT (41, Y2), Space%, PSET: GOSUB 121: Y2 = Y2 - 16: PUT (41, Y2), Left%, PSET
   CASE "a": PUT (41, Y2), Space%, PSET: GOSUB 121: Y2 = Y2 + 16: PUT (41, Y2), Left%, PSET
   CASE "0": IF STR1 <> 1 THEN PLAY "O1": PLAY "L64": PLAY "T200": PLAY "F": MET1 = MET1 - 1: IF MET1 > -1 THEN STR1 = 1: XS1 = 258: YS1 = Y1 + 7
   CASE "8": PUT (261, Y1), Space%, PSET: GOSUB 107: Y1 = Y1 - 16: PUT (261, Y1), Right%, PSET
   CASE "2": PUT (261, Y1), Space%, PSET: GOSUB 107: Y1 = Y1 + 16: PUT (261, Y1), Right%, PSET
   CASE "y": IF STR2 <> 1 THEN PLAY "O1": PLAY "L64": PLAY "T200": PLAY "F": MET2 = MET2 - 1: IF MET2 > -1 THEN STR2 = 1: XS2 = 52: YS2 = Y2 + 7
   CASE CHR$(27): GOSUB 111: CLS : GOTO 110
   END SELECT
   IF MET1 = 0 AND MET2 = 0 AND STR1 = 0 AND STR2 = 0 THEN FOR ZID = 1 TO 90000: NEXT ZID: GOTO 10
   IF MET1 < 0 THEN MET1 = 0
   IF MET2 < 0 THEN MET2 = 0
   CAS = CAS - .003
   IF ZIP < 7 THEN KOC = KOC + .5: IF KOC = 450 THEN KOC = 0: ZIP = ZIP + 1: GOSUB 108
   LOCATE 2, 2: PRINT " Bullets"; MET2
   LOCATE 3, 2: PRINT " Kills  ": GOSUB 98
   LOCATE 2, 14: PRINT " Time    "; INT(CAS)
   LOCATE 3, 29: PRINT " Kills  ": GOSUB 99
   LOCATE 2, 29: PRINT " Bullets"; MET1
   IF INT(CAS) <= 0 THEN CAS = 0: GOSUB 111: CLS : GOSUB 115: GOTO 110
   GOTO 20
98 IF TOC2 < 10 THEN LOCATE 3, 10: PRINT TOC2
   IF TOC2 < 100 AND TOC2 > 9 THEN LOCATE 3, 9: PRINT TOC2
   IF TOC2 < 1000 AND TOC2 > 99 THEN LOCATE 3, 8: PRINT TOC2
   RETURN

99 IF TOC1 < 10 THEN LOCATE 3, 37: PRINT TOC1
   IF TOC1 < 100 AND TOC1 > 9 THEN LOCATE 3, 36: PRINT TOC1
   IF TOC1 < 1000 AND TOC1 > 99 THEN LOCATE 3, 35: PRINT TOC1
   RETURN
100 IF ZAD = 1 THEN GOTO 103 ELSE GOTO 104
101 'Right
    OPEN "KRSTA.DAT" FOR INPUT AS #1
    FOR A = 1 TO 16
    FOR B = 1 TO 11
    INPUT #1, SLI
    PSET (260 + B, 120 + A), SLI
    NEXT B, A
    CLOSE #1
    GET (261, 121)-(271, 136), Krsta%
    PUT (261, Y1), Space%, PSET
    PLAY "L20"
    PLAY "O3"
    PLAY "T50"
    PLAY "D"
    PLAY "P50"
    PLAY "D"
    PLAY "P50"
    PLAY "DD"
    PUT (261, YK - 16), Krsta%, PSET
    PUT (261, YK), Space%, PSET
    PLAY "P50"
    PLAY "F"
    FOR ZID = 1 TO 30000: NEXT ZID
    PUT (261, YK - 32), Krsta%, PSET
    PUT (261, YK - 16), Space%, PSET
    PLAY "P50"
    PLAY "EE"
    FOR ZID = 1 TO 30000: NEXT ZID
    PUT (261, YK - 48), Krsta%, PSET
    PUT (261, YK - 32), Space%, PSET
    PLAY "DD"
    FOR ZID = 1 TO 30000: NEXT ZID
    PUT (261, YK - 64), Krsta%, PSET
    PUT (261, YK - 48), Space%, PSET
    PLAY "C#D"
    FOR ZID = 1 TO 60000: NEXT ZID
    PUT (261, YK - 64), Space%, PSET
    PUT (141, Y3), Space2%, PSET
    PUT (41, Y2), Space%, PSET
    CLS
    GOTO 10

102 'Left
    OPEN "KRSTA.DAT" FOR INPUT AS #1
    FOR A = 1 TO 16
    FOR B = 1 TO 11
    INPUT #1, SLI
    PSET (40 + B, 120 + A), SLI
    NEXT B, A
    CLOSE #1
    GET (41, 121)-(51, 136), Krsta%
    PUT (41, Y2), Space%, PSET
    PLAY "L20"
    PLAY "O3"
    PLAY "T50"
    PLAY "D"
    PLAY "P50"
    PLAY "D"
    PLAY "P50"
    PLAY "DD"
    PUT (41, YK - 16), Krsta%, PSET
    PUT (41, YK), Space%, PSET
    PLAY "P50"
    PLAY "F"
    FOR ZID = 1 TO 30000: NEXT ZID
    PUT (41, YK - 32), Krsta%, PSET
    PUT (41, YK - 16), Space%, PSET
    PLAY "P50"
    PLAY "EE"
    FOR ZID = 1 TO 30000: NEXT ZID
    PUT (41, YK - 48), Krsta%, PSET
    PUT (41, YK - 32), Space%, PSET
    PLAY "DD"
    FOR ZID = 1 TO 30000: NEXT ZID
    PUT (41, YK - 64), Krsta%, PSET
    PUT (41, YK - 48), Space%, PSET
    PLAY "C#D"
    FOR ZID = 1 TO 60000: NEXT ZID
    PUT (41, YK - 64), Space%, PSET
    PUT (141, Y3), Space2%, PSET
    PUT (261, Y1), Space%, PSET
    CLS
    GOTO 10

103 'Right
    ZAD = 0
    TOC2 = TOC2 + 1
    OPEN "RDEAD.DAT" FOR INPUT AS #1
    FOR A = 1 TO 16
    FOR B = 1 TO 11
    INPUT #1, SLI
    PSET (260 + B, Y1 + A - 1), SLI
    NEXT B, A
    CLOSE #1
    FOR ZID = 1 TO 90000: NEXT ZID: GOTO 101

104 'Left
    ZAD = 0
    TOC1 = TOC1 + 1
    OPEN "LDEAD.DAT" FOR INPUT AS #1
    FOR A = 1 TO 16
    FOR B = 1 TO 11
    INPUT #1, SLI
    PSET (40 + B, Y2 + A - 1), SLI
    NEXT B, A
    CLOSE #1
    FOR ZID = 1 TO 90000: NEXT ZID: GOTO 102
105 PSET (XS1, YS1), 8
    PRESET (XS1 + 1, YS1)
    IF POINT(XS1 - 1, YS1) <> -1 AND POINT(XS1 - 1, YS1) <> 0 AND XS1 < 60 THEN PRESET (XS1, YS1): ZAD = 2: STR1 = 0: GOTO 100
    IF POINT(XS1 - 1, YS1) <> -1 AND POINT(XS1 - 1, YS1) <> 0 THEN PRESET (XS1, YS1): PRESET (XS1 - 1, YS1): PRESET (XS1 - 2, YS1): PRESET (XS1 - 3, YS1): STR1 = 0: GOTO 20
    IF POINT(XS1, YS1) = -1 THEN STR1 = 0
    XS1 = XS1 - 1
    RETURN
106 PSET (XS2, YS2), 8
    PRESET (XS2 - 1, YS2)
    IF POINT(XS2 + 1, YS2) <> -1 AND POINT(XS2 + 1, YS2) <> 0 AND XS2 > 250 THEN PRESET (XS2, YS2): ZAD = 1: STR2 = 0: GOTO 100
    IF POINT(XS2 + 1, YS2) <> -1 AND POINT(XS2 + 1, YS2) <> 0 THEN PRESET (XS2, YS2): PRESET (XS2 + 1, YS2): PRESET (XS2 + 2, YS2): PRESET (XS2 + 3, YS2): STR2 = 0: GOTO 20
    IF POINT(XS2, YS2) = -1 THEN STR2 = 0
    XS2 = XS2 + 1
    RETURN
107 IF Y1 + 16 > 176 THEN Y1 = Y1 - 16
    IF Y1 < 45 THEN Y1 = Y1 + 16
    RETURN
108 'Kocija
    IF ZIP = 0 THEN PUT (141, Y3), Kocija%
    IF ZIP = 1 THEN Y3 = Y3 + 20: PUT (141, Y3 - 20), Space2%, PSET: PUT (141, Y3), Kocija%, PSET
    IF ZIP = 2 THEN Y3 = Y3 + 20: PUT (141, Y3 - 20), Space2%, PSET: PUT (141, Y3), Kocija%, PSET
    IF ZIP = 3 THEN Y3 = Y3 + 20: PUT (141, Y3 - 20), Space2%, PSET: PUT (141, Y3), Kocija%, PSET
    IF ZIP = 4 THEN Y3 = Y3 + 20: PUT (141, Y3 - 20), Space2%, PSET: PUT (141, Y3), Kocija%, PSET
    IF ZIP = 5 THEN Y3 = Y3 + 20: PUT (141, Y3 - 20), Space2%, PSET: PUT (141, Y3), Kocija%, PSET
    IF ZIP = 6 THEN Y3 = Y3 + 20: PUT (141, Y3 - 20), Space2%, PSET
    RETURN
109 CLS : SCREEN 7: COLOR 4, 14
    PRINT
    PRINT " л  л л лппл л  л   л  л лппл лппл л  л"
    PRINT " лллл л л    лллл   лпмл л  л л  л лпмл"
    PRINT " л  л л лмлл л  л   л  л лммл лммл л  л"
    PRINT ""
    COLOR 8
    PRINT ""
    PRINT "  мм                  ммммммммм"
    PRINT "  лллллллллллллллллллллллллллллллл  л"
    PRINT "          пппппппппппплллллллллллллп "
    PRINT "                         л  л      л"
    PRINT "                        п    л      л"
    PRINT "                              л      л"
    PRINT "                               л      л"
    PRINT "                                лллллл"
    PRINT ""
    LOCATE 10, 30: COLOR 4: PRINT "лллллл"
    LOCATE 11, 31: COLOR 4: PRINT "лллллл"
    LOCATE 12, 32: COLOR 4: PRINT "лллллл"
    LOCATE 13, 33: COLOR 4: PRINT "лллллл"
    COLOR 8: LOCATE 15, 10: PRINT "By:"
    COLOR 6: LOCATE 17, 10: PRINT "Crt Brezovar"
    COLOR 6: LOCATE 19, 10: PRINT "1997"
    SCALE$ = "CDEGGAGECDEEDCDEGGAGECDEEDDCFFAAAGGECDCDEGGAGECDEEDDC"
    PLAY "L16"
    FOR I% = 2 TO 2
        PLAY "O" + STR$(I%)
        PLAY "X" + VARPTR$(SCALE$)
    NEXT I%
    CLS
110 COLOR 6, 14
    LOCATE 3, 12: PRINT "-= HIGH NOON =-"
    COLOR 8, 14
    LOCATE 6, 9: PRINT "(1) Start shootin'"
    LOCATE 8, 9: PRINT "(2) How to shoot"
    LOCATE 10, 9: PRINT "(3) Hall of fame"
    LOCATE 12, 9: PRINT "(4) Escape"
    K$ = INKEY$
    IF K$ = "1" OR K$ = "2" OR K$ = "3" OR K$ = "4" OR K$ = CHR$(27) THEN GOTO 113
    GOTO 110
111 COLOR 8, 14
    LOCATE 13, 15: PRINT "HIGH NOON"
    FOR ZID = 1 TO 400 STEP 10
    IF ZID = 5 THEN A = 0
    IF ZID = 101 THEN A = 0
    IF ZID = 201 THEN A = 0
    IF ZID = 301 THEN A = 0
    IF ZID < 100 AND ZID > 0 THEN BAR = 3: IF A <> 1 THEN PLAY "CD": A = 1
    IF ZID < 200 AND ZID > 100 THEN BAR = 2: IF A <> 1 THEN PLAY "EF": A = 1
    IF ZID < 300 AND ZID > 200 THEN BAR = 4: IF A <> 1 THEN PLAY "GG": A = 1
    IF ZID < 400 AND ZID > 300 THEN BAR = 14: IF A <> 1 THEN PLAY "C": A = 1
    COLOR 8, BAR
    LOCATE 13, 15: PRINT "HIGH NOON"
    NEXT ZID
    RETURN
112 RESUME NEXT
113 SELECT CASE K$
    CASE "1": CLS : GOSUB 114: GOSUB 111: GOTO 5
    CASE "2": GOTO 119
    CASE "3": GOTO 118
    CASE "4": CLS : GOTO 1000
    CASE CHR$(27): CLS : GOTO 1000
    END SELECT
    GOTO 110
114 COLOR 6, 14
    LOCATE 3, 12: PRINT "-= HIGH NOON =-"
    COLOR 8, 14
    LOCATE 6, 5: INPUT "Right player "; NAM1$
    LOCATE 8, 5: INPUT "Left player "; NAM2$
    CLS
    RETURN
115 'High Score
    OPEN "TOCKE.DAT" FOR INPUT AS #1
    INPUT #1, IME1$
    INPUT #1, HIGH1
    INPUT #1, IME2$
    INPUT #1, HIGH2
    INPUT #1, IME3$
    INPUT #1, HIGH3
    INPUT #1, IME4$
    INPUT #1, HIGH4
    INPUT #1, IME5$
    INPUT #1, HIGH5
    CLOSE #1
    IF TOC1 > HIGH1 THEN HIGH5 = HIGH4: HIGH4 = HIGH3: HIGH3 = HIGH2: HIGH2 = HIGH1: HIGH1 = TOC1: IME5$ = IME4$: IME4$ = IME3$: IME3$ = IME2$: IME2$ = IME1$: IME1$ = NAM1$: GOTO 116
    IF TOC1 > HIGH2 THEN HIGH5 = HIGH4: HIGH4 = HIGH3: HIGH3 = HIGH2: HIGH2 = TOC1: IME5$ = IME4$: IME4$ = IME3$: IME3$ = IME2$: IME2$ = NAM1$: GOTO 116
    IF TOC1 > HIGH3 THEN HIGH5 = HIGH4: HIGH4 = HIGH3: HIGH3 = TOC1: IME5$ = IME4$: IME4$ = IME3$: IME3$ = NAM1$: GOTO 116
    IF TOC1 > HIGH4 THEN HIGH5 = HIGH4: HIGH4 = TOC1: IME5$ = IME4$: IME4$ = NAM1$: GOTO 116
    IF TOC1 > HIGH5 THEN HIGH5 = TOC1: IME5$ = NAM1$: GOTO 116
116 IF TOC2 > HIGH1 THEN HIGH5 = HIGH4: HIGH4 = HIGH3: HIGH3 = HIGH2: HIGH2 = HIGH1: HIGH1 = TOC2: IME5$ = IME4$: IME4$ = IME3$: IME3$ = IME2$: IME2$ = IME1$: IME1$ = NAM2$: GOTO 117
    IF TOC2 > HIGH2 THEN HIGH5 = HIGH4: HIGH4 = HIGH3: HIGH3 = HIGH2: HIGH2 = TOC2: IME5$ = IME4$: IME4$ = IME3$: IME3$ = IME2$: IME2$ = NAM2$: GOTO 117
    IF TOC2 > HIGH3 THEN HIGH5 = HIGH4: HIGH4 = HIGH3: HIGH3 = TOC2: IME5$ = IME4$: IME4$ = IME3$: IME3$ = NAM2$: GOTO 117
    IF TOC2 > HIGH4 THEN HIGH5 = HIGH4: HIGH4 = TOC2: IME5$ = IME4$: IME4$ = NAM2$: GOTO 117
    IF TOC2 > HIGH5 THEN HIGH5 = TOC2: IME5$ = NAM2$: GOTO 117
117 OPEN "TOCKE.DAT" FOR OUTPUT AS #1
    PRINT #1, IME1$
    PRINT #1, HIGH1
    PRINT #1, IME2$
    PRINT #1, HIGH2
    PRINT #1, IME3$
    PRINT #1, HIGH3
    PRINT #1, IME4$
    PRINT #1, HIGH4
    PRINT #1, IME5$
    PRINT #1, HIGH5
    CLOSE #1
118 CLS
    OPEN "TOCKE.DAT" FOR INPUT AS #1
    INPUT #1, IME1$
    INPUT #1, HIGH1
    INPUT #1, IME2$
    INPUT #1, HIGH2
    INPUT #1, IME3$
    INPUT #1, HIGH3
    INPUT #1, IME4$
    INPUT #1, HIGH4
    INPUT #1, IME5$
    INPUT #1, HIGH5
    CLOSE #1
    COLOR 6, 14: LOCATE 2, 8: PRINT " -= BEST OF THE BEST =- "
    COLOR 8
    PRINT
    PRINT
    LOCATE 6, 5: PRINT " .........................."; HIGH1
    LOCATE 9, 5: PRINT " .........................."; HIGH2
    LOCATE 12, 5: PRINT " .........................."; HIGH3
    LOCATE 15, 5: PRINT " .........................."; HIGH4
    LOCATE 18, 5: PRINT " .........................."; HIGH5
    LOCATE 6, 5: PRINT IME1$
    LOCATE 9, 5: PRINT IME2$
    LOCATE 12, 5: PRINT IME3$
    LOCATE 15, 5: PRINT IME4$
    LOCATE 18, 5: PRINT IME5$
   
    PLAY "L10": PLAY "O1": PLAY "FGECADEF"
    WHILE INKEY$ = "": WEND
    CLS
    GOTO 110
119 CLS
    COLOR 6, 14
    LOCATE 3, 15: PRINT " -= KEYS =-"
    COLOR 8, 14
    LOCATE 6, 5: PRINT "          Left          Right"
    LOCATE 8, 5: PRINT "Up          q             8      "
    LOCATE 10, 5: PRINT "Down        a             2      "
    LOCATE 12, 5: PRINT "Shoot       y             0      "
    WHILE INKEY$ = "": WEND
    CLS
    GOTO 110
121 IF Y2 + 16 > 176 THEN Y2 = Y2 - 16
    IF Y2 < 45 THEN Y2 = Y2 + 16
    RETURN
1000 CLS
     DEF SEG = 0: POKE 1047, KeyFlags: DEF SEG
     COLOR 6, 14
     PRINT
     PRINT
     PRINT
     PRINT
     PRINT "     This is a PC version of a game"
     PRINT
     PRINT "        written long time ago for"
     PRINT
     PRINT "          Sinclair ZX Spectrum"
     PRINT
     COLOR 8
     PRINT "                  -=- "
     PRINT
     PRINT "           Copyright (C) 1997"
     PRINT
     PRINT "              Crt Brezovar"
     PRINT
     PRINT
     PRINT
     PRINT
     COLOR 1
     PRINT " Send any coments to:"
     PRINT
     PRINT " E-Mail: Crtus@slovenia.crosswinds.net"
     WHILE INKEY$ = "": WEND
     CLS : END

