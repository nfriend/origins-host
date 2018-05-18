  CLS : SCREEN 7
  ON ERROR GOTO 3970
  DEF SEG = 0
  KeyFlags = PEEK(1047)
  IF (KeyFlags AND 32) = 0 THEN POKE 1047, KeyFlags OR 32
  GOTO 3900
0 GOSUB 110
  IF BOOM = 1 THEN PLAY "L64": PLAY "ACG": GOTO 10
  IF LVL > 1 THEN GOSUB 4000: CO = 10
  IF LVL > 2 THEN GOSUB 5000: CO = 10
  IF LVL > 3 THEN GOSUB 6000: CO = 10
  IF LVL > 4 THEN GOSUB 7000: CO = 10
  IF LVL > 5 THEN GOSUB 8000: CO = 15
  IF LVL > 6 THEN CO = 15
  IF LVL = 1 THEN CO = 5
  IF MID = 1 THEN RESTORE 6: IF MID = 3 THEN RESTORE 8: IF MID = 2 THEN RESTORE 7
  K$ = INKEY$
  SELECT CASE K$
     CASE "4": LINE (X + 1, Y + 1)-(X + 19, Y + 16), 0, BF: X = X - 15: RESTORE 4
     CASE "6": LINE (X + 1, Y + 1)-(X + 19, Y + 16), 0, BF: X = X + 15: RESTORE 5
     CASE "8": IF POINT(X + 8, Y - 3) = 0 THEN TOC = TOC + 50: ZUM = 1: PLAY "L20": PLAY "GFE": LINE (X + 1, Y + 1)-(X + 19, Y + 16), 0, BF: Y = Y - 20: RESTORE 3 ELSE BOOM = 1
     CASE "I", "i": GOTO 9500
     CASE "P", "p": WHILE INKEY$ = "": WEND
     CASE "": IF MID = 1 THEN RESTORE 6: IF MID = 3 THEN RESTORE 8: IF MID = 2 THEN RESTORE 7
  END SELECT
10 PLAY "L64": PLAY "C"
   IF POINT(X, Y + 8) <> 0 OR POINT(X + 20, Y + 8) <> 0 THEN COLOR 14, 15: BOOM = 1: COLOR 14, 0
   IF BOOM = 1 AND Y = 175 THEN GOSUB 9000: TIM = TIM + 1: RESTORE 1
   IF BOOM = 1 AND Y <> 175 THEN GOSUB 9000: RESTORE 2: TIM = TIM + 1
   IF TIM = 7 AND Y = 175 THEN TIM = 0: BOOM = 0: ZIV = ZIV - 1: TOC = TOC - 40
   IF TIM = 7 AND Y <> 175 THEN TIM = 0: BOOM = 0
   IF Y <> 175 AND ZUM = 0 AND X > 21 AND X < 244 AND POINT(X + 8, Y + 17) = 0 THEN LINE (X + 1, Y + 1)-(X + 19, Y + 16), 0, BF: TOC = TOC - 20: LET Y = Y + 20: BOOM = 1
   IF ZIV < 0 THEN GOTO 3100
   IF X < 20 THEN X = 245
   IF X > 245 THEN X = 20
   IF Y < 5 THEN TOC = TOC + 1000: KON = 1
   IF Y > 175 THEN Y = 175
   FOR A = 1 TO 16
   FOR B = 1 TO 19
   READ SLI
   PSET (B + X, A + Y), SLI
   NEXT B, A: LET MID = MID + 1: IF MID > 3 THEN MID = 1
   LOCATE 3, 35: COLOR 15, 0: PRINT "SCORE"
   LOCATE 4, 34: PRINT TOC
   LOCATE 6, 35: PRINT "LIVES"
   LOCATE 7, 36: PRINT ZIV
   LOCATE 9, 35: PRINT "LEVEL"
   LOCATE 10, 36: PRINT LVL
   IF KON = 1 THEN GOTO 3000
   GOTO 0
1 DATA 0, 0, 15, 15, 0, 0, 0, 0, 15, 15, 15, 0, 0, 0, 0, 15, 15, 0, 0
  DATA 15, 15, 15, 15, 0, 0, 0, 15, 15, 15, 15, 15, 0, 0, 0, 15, 15, 15, 15
  DATA 0, 0, 0, 15, 15, 0, 0, 15, 0, 15, 0, 15, 0, 0, 15, 15, 0, 0, 0
  DATA 0, 0, 0, 0, 15, 15, 0, 15, 15, 15, 15, 15, 0, 15, 15, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 15, 15, 0, 0, 15, 15, 15, 0, 0, 15, 15, 0, 0, 0, 0
  DATA 0, 0, 0, 15, 15, 0, 0, 0, 0, 15, 0, 0, 0, 0, 15, 15, 0, 0, 0
  DATA 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15
  DATA 0, 0, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

2 DATA 0, 0, 0, 15, 15, 15, 15, 0, 0, 15, 15, 15, 0, 0, 15, 15, 0, 0, 0
  DATA 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0
  DATA 15, 4, 15, 4, 15, 4, 4, 4, 15, 4, 15, 15, 15, 4, 4, 4, 15, 15, 0
  DATA 15, 4, 15, 4, 15, 4, 15, 15, 15, 4, 15, 15, 15, 4, 15, 4, 15, 15, 0
  DATA 15, 4, 4, 4, 15, 4, 4, 15, 15, 4, 15, 15, 15, 4, 4, 4, 15, 0, 0
  DATA 0, 4, 15, 4, 15, 4, 15, 15, 15, 4, 15, 15, 15, 4, 15, 15, 0, 0, 0
  DATA 0, 4, 15, 4, 15, 4, 4, 4, 15, 4, 4, 4, 15, 4, 15, 0, 0, 0, 0
  DATA 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 15, 15, 15, 0, 0, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 6, 6, 6, 0, 0, 9, 9, 9, 9, 0, 0, 2, 2, 2, 2, 0, 0
  DATA 6, 6, 6, 6, 6, 6, 9, 9, 9, 9, 9, 9, 2, 2, 0, 0, 2, 2, 6

3 DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 0, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 9, 9, 0, 9, 9, 9, 0, 9, 9, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 9, 9, 0, 0, 9, 9, 9, 0, 0, 9, 9, 0, 0, 0, 0
  DATA 0, 0, 0, 6, 6, 0, 0, 0, 9, 9, 9, 0, 0, 0, 6, 6, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0
  DATA 0, 0, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 0, 0

4 DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 6, 6, 6, 0, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 9, 9, 0, 9, 9, 9, 0, 9, 9, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 9, 9, 0, 0, 9, 9, 9, 0, 0, 9, 9, 0, 0, 0, 0
  DATA 0, 0, 0, 6, 6, 0, 0, 0, 9, 9, 9, 0, 0, 0, 6, 6, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 0, 6, 6, 6, 6, 0, 0, 0, 0
  
5 DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 9, 9, 0, 9, 9, 9, 0, 9, 9, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 9, 9, 0, 0, 9, 9, 9, 0, 0, 9, 9, 0, 0, 0, 0
  DATA 0, 0, 0, 6, 6, 0, 0, 0, 9, 9, 9, 0, 0, 0, 6, 6, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 6, 6, 6, 6, 0, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0
  
6 DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 9, 9, 0, 9, 9, 9, 0, 9, 9, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 9, 9, 0, 0, 9, 9, 9, 0, 0, 9, 9, 0, 0, 0, 0
  DATA 0, 0, 0, 6, 6, 0, 0, 0, 9, 9, 9, 0, 0, 0, 6, 6, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0
  DATA 0, 0, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 0, 0
  
7 DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 0, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 9, 9, 0, 9, 9, 9, 0, 9, 9, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 9, 9, 0, 0, 9, 9, 9, 0, 0, 9, 9, 0, 0, 0, 0
  DATA 0, 0, 0, 6, 6, 0, 0, 0, 9, 9, 9, 0, 0, 0, 6, 6, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0
  DATA 0, 0, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 0, 0
  
8 DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 6, 6, 6, 0, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 9, 9, 0, 9, 9, 9, 0, 9, 9, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 9, 9, 0, 0, 9, 9, 9, 0, 0, 9, 9, 0, 0, 0, 0
  DATA 0, 0, 0, 6, 6, 0, 0, 0, 9, 9, 9, 0, 0, 0, 6, 6, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0
  DATA 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0
  DATA 0, 0, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 0, 0
  
100   'Nastavitve
  FOR U = 172 TO 1 STEP -20
  LINE (20, U)-(260, U), 1
  NEXT U
  MID = 1
  KON = 0
  X = 130
  Y = 175
  X1 = 130
  Y1 = 155
  X2 = 90
  Y2 = 135
  X3 = 40
  Y3 = 115
  X4 = 90
  Y4 = 95
  X5 = 110
  Y5 = 55
  CON1 = 0
  CON2 = 0
  CON3 = 0
  CON4 = 0
  CON5 = 0
  U1 = 20
  U2 = 160
  U3 = 50
  U4 = 100
  U5 = 25
  U6 = 55
  U7 = 65
  U8 = 35
  U9 = 85
  CO = 5
  ZIV = 3
  TOC = 0
  ZUM = 0
  LVL = 1
  TIM = 0
  BOOM = 0
  RETURN
110 'Soba
    U1 = U1 + CO
    ZUM = 0
    IF U1 > 251 THEN U1 = 20
    LINE (U1 + 10, 172)-(U1 + 30, 172), 0
    LINE (U1, 172)-(U1 + 10, 172), LVL
    U2 = U2 - CO
    IF U2 < 25 THEN U2 = 260
    LINE (U2 - 10, 152)-(U2 - 30, 152), 0
    LINE (U2, 152)-(U2 - 10, 152), LVL
    U3 = U3 + CO
    IF U3 > 251 THEN U3 = 20
    LINE (U3 + 10, 132)-(U3 + 30, 132), 0
    LINE (U3, 132)-(U3 + 10, 132), LVL
    U4 = U4 - CO
    IF U4 < 25 THEN U4 = 260
    LINE (U4 - 10, 112)-(U4 - 30, 112), 0
    LINE (U4, 112)-(U4 - 10, 112), LVL
    U5 = U5 + CO
    IF U5 > 251 THEN U5 = 20
    LINE (U5 + 10, 92)-(U5 + 30, 92), 0
    LINE (U5, 92)-(U5 + 10, 92), LVL
    U6 = U6 - CO
    IF U6 < 25 THEN U6 = 260
    LINE (U6 - 10, 72)-(U6 - 30, 72), 0
    LINE (U6, 72)-(U6 - 10, 72), LVL
    U7 = U7 + CO
    IF U7 > 251 THEN U7 = 20
    LINE (U7 + 10, 52)-(U7 + 30, 52), 0
    LINE (U7, 52)-(U7 + 10, 52), LVL
    U8 = U8 + CO
    IF U8 > 251 THEN U8 = 20
    LINE (U8 + 10, 32)-(U8 + 30, 32), 0
    LINE (U8, 32)-(U8 + 10, 32), LVL
    U9 = U9 - CO
    IF U9 < 25 THEN U9 = 260
    LINE (U9 - 10, 12)-(U9 - 30, 12), 0
    LINE (U9, 12)-(U9 - 10, 12), LVL
    RETURN
3000 LOCATE 12, 11: COLOR 9, 0: PRINT "*** YOU WIN ***"
     WHILE INKEY$ = "": WEND
     IF LVL = 7 THEN GOTO 3050
     IF LVL < 7 THEN ON LVL GOSUB 3200, 3300, 3400, 3500, 3600, 3700
     IF LVL = 8 THEN TOC = TOC + 2000: GOTO 3800
3050 CLS
     LVL = LVL + 1
     FOR U = 172 TO 1 STEP -20
     LINE (20, U)-(260, U), LVL
     NEXT U
     X = 130
     Y = 175
     KON = 0
     GOTO 0
3100 LOCATE 12, 11: COLOR 9, 0: PRINT "*** GAME OVER ***"
     PLAY "L20": PLAY "O3": PLAY "T50": PLAY "D": PLAY "P50": PLAY "D": PLAY "P50": PLAY "DD": PLAY "P50": PLAY "F": PLAY "P50": PLAY "EE DD C#D"
     WHILE INKEY$ = "": WEND: GOTO 3960
3200 CLS
     LOCATE 11, 13: COLOR 14, 0: PRINT "LEVEL 1 COMPLETED"
     LOCATE 13, 5: COLOR 9, 0: PRINT "Jumpin' here and jumpin' there"
     LOCATE 14, 7: PRINT "find the exit and be sqare"
     LOCATE 15, 6: PRINT "Searching is the job for you"
     LOCATE 16, 4: PRINT "hurry up before the night is thru"
     LOCATE 18, 18: COLOR 4, 0: PRINT "HA HA HA"
     PLAY "L10": PLAY "O2": PLAY "CDEFAGACFGACGG"
     WHILE INKEY$ = "": WEND
     RETURN
3300 CLS
     LOCATE 11, 13: COLOR 14, 0: PRINT "LEVEL 2 COMPLETED"
     LOCATE 13, 9: COLOR 9, 0: PRINT "Look down and look around"
     LOCATE 14, 5: PRINT "avoid the monsters on the ground"
     LOCATE 15, 7: PRINT "Jumpin' high and jumpin' low"
     LOCATE 16, 8: PRINT "you cannot control the flow"
     LOCATE 18, 18: COLOR 4, 0: PRINT "NO PROBLEM"
     PLAY "L10": PLAY "O2": PLAY "CDEFAGACFGACGG"
     WHILE INKEY$ = "": WEND
     RETURN
3400 CLS
     LOCATE 11, 13: COLOR 14, 0: PRINT "LEVEL 3 COMPLETED"
     LOCATE 13, 5: COLOR 9, 0: PRINT "Jumpin' Jack is quick and bold"
     LOCATE 14, 4: PRINT "all his stories remain untold ..."
     LOCATE 16, 18: COLOR 4, 0: PRINT "IT'S THAT SIMPLE"
     PLAY "L10": PLAY "O2": PLAY "CDEFAGACFGACGG"
     WHILE INKEY$ = "": WEND
     RETURN
3500 CLS
     LOCATE 11, 13: COLOR 14, 0: PRINT "LEVEL 4 COMPLETED"
     LOCATE 13, 5: COLOR 9, 0: PRINT "THE BALLAD OF JUMPIN' JACK:"
     LOCATE 14, 5: PRINT "A daring explorer named Jack ..."
     LOCATE 16, 18: COLOR 4, 0: PRINT "HOT STUFF"
     PLAY "L10": PLAY "O2": PLAY "CDEFAGACFGACGG"
     WHILE INKEY$ = "": WEND
     RETURN
3600 CLS
     LOCATE 11, 13: COLOR 14, 0: PRINT "LEVEL 5 COMPLETED"
     LOCATE 13, 9: COLOR 9, 0: PRINT "Jumpin' Jack is very brave"
     LOCATE 14, 6: PRINT "he takes his secrets to the grave"
     LOCATE 15, 8: PRINT "Funny nature, hands so steady"
     LOCATE 16, 8: PRINT "watch out he's getting ready"
     LOCATE 18, 24: COLOR 4, 0: PRINT "FANCY"
     PLAY "L10": PLAY "O2": PLAY "CDEFAGACFGACGG"
     WHILE INKEY$ = "": WEND
     RETURN
3700 CLS
     LOCATE 11, 13: COLOR 14, 0: PRINT "LEVEL 6 COMPLETED"
     LOCATE 13, 5: COLOR 9, 0: PRINT "FINAL PHRASE:"
     LOCATE 14, 5: PRINT "Don't wonder"
     LOCATE 15, 5: PRINT "JUMP, JUMP, JUMP !!!"
     LOCATE 18, 18: COLOR 4, 0: PRINT "JJJJUUUMMMPPP !!!"
     PLAY "L10": PLAY "O2": PLAY "CDEFAGACFGACGG"
     WHILE INKEY$ = "": WEND
     RETURN
3800 CLS
     LOCATE 11, 13: COLOR 14, 0: PRINT "YOU ARE THE BEST"
     LOCATE 13, 3: COLOR 9, 0: PRINT "Avoiding dangerous traps you finaly"
     LOCATE 14, 4: PRINT "reached the end of all 8 levels."
     LOCATE 15, 2: PRINT "But just when you tought the nightmare"
     LOCATE 16, 3: PRINT "is over you see them coming back ..."
     LOCATE 18, 18: COLOR 4, 0: PRINT "HEELLLPPP !!!"
     PLAY "L10": PLAY "O3": PLAY "FGAGFDDGCCAGF"
     WHILE INKEY$ = "": WEND
     GOTO 3960
3900 'Menu
     OPEN "jj.dat" FOR INPUT AS #1
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
     CLOSE
     COLOR 4, 0
     PRINT
     PRINT
     PRINT
     PRINT "       л л  л л  л лллл л л  л лллл"
     PRINT "       л л  л лллл л  л л лл л л   "
     PRINT "    л  л л  л л  л лллл л л лл л лл"
     PRINT "    лллл лллл л  л л    л л  л лллл"
     PRINT
     COLOR 1, 0
     PRINT "       л лллл лллл л  лл"
     PRINT "       л л  л л    ллл"
     PRINT "    л  л лллл л    л  л"
     PRINT "    лллл л  л лллл л  лл  F L A S H"
     LOCATE 15, 11: COLOR 2, 0: PRINT "By: CRT BREZOVAR"
     LOCATE 17, 17: COLOR 5, 0: PRINT "1996"
     LOCATE 21, 7: COLOR 14, 0: PRINT "Hit any key to continue ..."
     WHILE INKEY$ = "": PLAY "L10": PLAY "O1": PLAY "FGFAFCFDFCFDFG": WEND: PLAY "FGFGAC"
     GOTO 9500
3950 CLS
     LOCATE 2, 4: COLOR 14, 0: PRINT "*** JUMPIN' JACK INSTRUCTIONS ***"
     LOCATE 4, 1: COLOR 3, 0: PRINT "The rules of the game are simple. You"
     LOCATE 5, 1: PRINT " must get to the top floor of the tower "
     LOCATE 6, 1: PRINT "     by jumpin' on the cliffs and "
     LOCATE 7, 1: PRINT " avoiding the holes below. If you fall"
     LOCATE 8, 1: PRINT " down to first floor you will lose one"
     LOCATE 9, 1: PRINT " life. The scoring is also basic, which"
     LOCATE 10, 1: PRINT "  means you get points by jumpin' and"
     LOCATE 11, 1: PRINT "not falling down again and you also get"
     LOCATE 12, 1: PRINT "   bonus for finishing current stage."
     LOCATE 13, 1: PRINT " While playing there will be different"
     LOCATE 14, 1: PRINT "  hazards in the game which you must"
     LOCATE 15, 1: PRINT "   also avoid."
     LOCATE 17, 18: COLOR 2, 0: PRINT "GOOD LUCK"
     WHILE INKEY$ = "": WEND
     GOTO 9500
3960 'High Score
     CLS
     PRINT
     PRINT
     COLOR 4, 0
     PRINT "YOU HAVE THE BEST SCORE:"; TOC
     PRINT
     IF TOC > HIGH1 THEN HIGH5 = HIGH4: HIGH4 = HIGH3: HIGH3 = HIGH2: HIGH2 = HIGH1: HIGH1 = TOC: IME5$ = IME4$: IME4$ = IME3$: IME3$ = IME2$: IME2$ = IME1$: COLOR 14, 0: INPUT "NAME: "; IME1$: GOTO 3965
     IF TOC > HIGH2 THEN HIGH5 = HIGH4: HIGH4 = HIGH3: HIGH3 = HIGH2: HIGH2 = TOC: IME5$ = IME4$: IME4$ = IME3$: IME3$ = IME2$: COLOR 14, 0: INPUT "NAME: "; IME2$: GOTO 3965
     IF TOC > HIGH3 THEN HIGH5 = HIGH4: HIGH4 = HIGH3: HIGH3 = TOC: IME5$ = IME4$: IME4$ = IME3$: COLOR 14, 0: INPUT "NAME: "; IME3$: GOTO 3965
     IF TOC > HIGH4 THEN HIGH5 = HIGH4: HIGH4 = TOC: IME5$ = IME4$: COLOR 14, 0: INPUT "NAME: "; IME4$: GOTO 3965
     IF TOC > HIGH5 THEN HIGH5 = TOC: COLOR 14, 0: INPUT "NAME: "; IME5$: GOTO 3965
3965 OPEN "jj.dat" FOR OUTPUT AS #2
     PRINT #2, IME1$
     PRINT #2, HIGH1
     PRINT #2, IME2$
     PRINT #2, HIGH2
     PRINT #2, IME3$
     PRINT #2, HIGH3
     PRINT #2, IME4$
     PRINT #2, HIGH4
     PRINT #2, IME5$
     PRINT #2, HIGH5
     CLOSE #2
     GOTO 9530
3970 'Napake
     RESUME NEXT
4000 'Sovragi
     CON1 = CON1 + 1: IF CON1 > 1 THEN CON1 = 0
     X1 = X1 - 10
     LINE (X1 + 1, Y1 + 1)-(X1 + 29, Y1 + 16), 0, BF
     IF X1 < 20 THEN X1 = 245: Y1 = Y1 - 20
     IF Y1 < 5 THEN Y1 = 155
     IF CON1 = 0 THEN RESTORE 4002
     IF CON1 = 1 THEN RESTORE 4003
     FOR M = 1 TO 16
     FOR N = 1 TO 19
     READ MON
     PSET (X1 + N, Y1 + M), MON
     NEXT N, M
     GOTO 4004

4002 DATA 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 6, 6, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 3, 3, 3, 3, 3, 3, 3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 3, 3, 3, 3, 3, 3, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 3, 3, 3, 3, 3, 3, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 3, 3, 3, 3, 3, 3, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 3, 3, 3, 3, 3, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 3, 3, 3, 3, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

4003 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 6, 6, 3, 3, 3, 3, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
     DATA 6, 6, 3, 3, 3, 3, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
     DATA 0, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 4, 3, 3, 4, 3, 4, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 4, 4, 4, 4, 4, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 4, 4, 4, 4, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

4004 RESTORE 8
     RETURN
5000 'Sovragi
     CON2 = CON2 + 1: IF CON2 > 1 THEN CON2 = 0
     X2 = X2 - 10
     LINE (X2 + 1, Y2 + 1)-(X2 + 29, Y2 + 16), 0, BF
     IF X2 < 20 THEN X2 = 245: Y2 = Y2 - 20
     IF Y2 < 5 THEN Y2 = 155
     IF CON2 = 0 THEN RESTORE 5002
     IF CON2 = 1 THEN RESTORE 5003
     FOR M = 1 TO 16
     FOR N = 1 TO 19
     READ MON
     PSET (X2 + N, Y2 + M), MON
     NEXT N, M
     GOTO 5004

5002 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0

5003 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0

5004 RESTORE 8
     RETURN
6000 'Sovragi
     CON3 = CON3 + 1: IF CON3 > 1 THEN CON3 = 0
     X3 = X3 - 10
     LINE (X3 + 1, Y3 + 1)-(X3 + 29, Y3 + 16), 0, BF
     IF X3 < 20 THEN X3 = 245: Y3 = Y3 - 20
     IF Y3 < 5 THEN Y3 = 155
     IF CON3 = 0 THEN RESTORE 6002
     IF CON3 = 1 THEN RESTORE 6003
     FOR M = 1 TO 16
     FOR N = 1 TO 19
     READ MON
     PSET (X3 + N, Y3 + M), MON
     NEXT N, M
     GOTO 6004

6002 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 15, 15, 0, 0, 15, 15, 15, 0, 0, 15, 15, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 15, 15, 15, 15, 0, 15, 15, 15, 15, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 15, 0, 15, 0, 15, 0, 15, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

6003 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 15, 15, 0, 0, 15, 15, 15, 0, 0, 15, 15, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 15, 15, 15, 15, 0, 15, 15, 15, 15, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 15, 0, 15, 0, 15, 0, 15, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

6004 RESTORE 8
     RETURN

7000 'Sovragi
     CON4 = CON4 + 1: IF CON4 > 1 THEN CON4 = 0
     X4 = X4 - 10
     LINE (X4 + 1, Y4 + 1)-(X4 + 29, Y4 + 16), 0, BF
     IF X4 < 20 THEN X4 = 245: Y4 = Y4 - 20
     IF Y4 < 5 THEN Y4 = 155
     IF CON4 = 0 THEN RESTORE 7002
     IF CON4 = 1 THEN RESTORE 7003
     FOR M = 1 TO 16
     FOR N = 1 TO 19
     READ MON
     PSET (X4 + N, Y4 + M), MON
     NEXT N, M
     GOTO 7004

7002 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2
     DATA 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 2, 0, 0, 2, 2, 0
     DATA 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 2, 0, 0, 2, 2, 0
     DATA 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 2, 2, 0, 2, 2, 2, 2, 2, 0
     DATA 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
     DATA 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
     DATA 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
     DATA 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
     DATA 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2
     DATA 2, 2, 2, 2, 0, 0, 2, 0, 0, 2, 2, 2, 0, 0, 2, 0, 0, 2, 2
     DATA 2, 2, 0, 2, 0, 0, 2, 0, 0, 2, 2, 2, 0, 0, 2, 0, 0, 2, 2
     DATA 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0
     DATA 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0

7003 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2
     DATA 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 2, 0, 0, 2, 2, 0
     DATA 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 2, 0, 0, 2, 2, 0
     DATA 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 2, 2, 0, 2, 2, 2, 2, 2, 0
     DATA 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
     DATA 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
     DATA 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
     DATA 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
     DATA 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2
     DATA 2, 2, 2, 2, 0, 0, 2, 0, 0, 2, 2, 2, 0, 0, 2, 0, 0, 2, 2
     DATA 2, 2, 0, 2, 0, 0, 2, 0, 0, 2, 2, 2, 0, 0, 2, 0, 0, 2, 2
     DATA 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0
     DATA 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0

7004 RESTORE 8
     RETURN

8000 'Sovragi
     CON5 = CON5 + 1: IF CON5 > 1 THEN CON5 = 0
     X5 = X5 - 10
     LINE (X5 + 1, Y5 + 1)-(X5 + 29, Y5 + 16), 0, BF
     IF X5 < 20 THEN X5 = 245: Y5 = Y5 - 20
     IF Y5 < 5 THEN Y5 = 155
     IF CON5 = 0 THEN RESTORE 8002
     IF CON5 = 1 THEN RESTORE 8003
     FOR M = 1 TO 16
     FOR N = 1 TO 19
     READ MON
     PSET (X5 + N, Y5 + M), MON
     NEXT N, M
     GOTO 8004

8002 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 4, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0
     DATA 0, 0, 0, 4, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0
     DATA 0, 0, 4, 4, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0
     DATA 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0
     DATA 0, 4, 4, 4, 4, 4, 14, 4, 4, 4, 4, 14, 4, 4, 4, 4, 4, 4, 0
     DATA 0, 0, 4, 4, 4, 14, 14, 14, 4, 4, 14, 14, 14, 14, 4, 4, 4, 4, 0
     DATA 0, 0, 0, 4, 4, 4, 14, 14, 14, 14, 14, 14, 14, 14, 14, 4, 4, 0, 0
     DATA 0, 0, 0, 0, 4, 4, 4, 14, 14, 14, 14, 14, 14, 14, 14, 4, 4, 0, 0
     DATA 0, 0, 0, 0, 0, 4, 4, 4, 14, 14, 14, 14, 14, 14, 14, 4, 0, 0, 0
     DATA 0, 0, 0, 0, 4, 4, 4, 14, 14, 14, 14, 14, 14, 14, 4, 4, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 4, 4, 4, 14, 14, 14, 14, 14, 14, 4, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 4, 4, 14, 14, 14, 14, 14, 4, 0, 0, 0, 0, 0

8003 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 4, 0, 0, 0, 4, 4, 4, 0, 0, 0, 4, 0, 0, 0, 0
     DATA 0, 0, 4, 0, 0, 4, 0, 4, 4, 4, 4, 0, 0, 4, 0, 0, 0, 0, 0
     DATA 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 4, 0, 0
     DATA 0, 0, 4, 4, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0
     DATA 0, 0, 4, 4, 0, 4, 4, 14, 4, 4, 4, 4, 14, 4, 4, 4, 0, 0, 0
     DATA 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0
     DATA 0, 4, 4, 4, 4, 4, 14, 4, 4, 4, 4, 14, 4, 4, 4, 4, 4, 4, 0
     DATA 0, 0, 4, 4, 4, 14, 14, 14, 4, 4, 14, 14, 14, 14, 4, 4, 4, 4, 0
     DATA 0, 0, 0, 4, 4, 4, 14, 14, 14, 14, 14, 14, 14, 14, 14, 4, 4, 0, 0
     DATA 0, 0, 0, 0, 4, 4, 4, 14, 14, 14, 14, 14, 14, 14, 14, 4, 4, 0, 0
     DATA 0, 0, 0, 0, 0, 4, 4, 4, 14, 14, 14, 14, 14, 14, 14, 4, 0, 0, 0
     DATA 0, 0, 0, 0, 4, 4, 14, 14, 14, 14, 14, 14, 14, 14, 4, 4, 0, 0, 0
     DATA 0, 0, 0, 4, 4, 14, 14, 14, 14, 14, 14, 14, 14, 14, 4, 0, 0, 0, 0
     DATA 0, 0, 4, 4, 4, 14, 14, 14, 14, 14, 14, 14, 14, 4, 0, 0, 0, 0, 0

8004 RESTORE 8
     RETURN
9000 'Premiki
     IF LVL = 2 OR LVL = 4 OR LVL = 3 THEN GOSUB 4000
     IF LVL = 3 OR LVL = 4 THEN GOSUB 5000
     IF LVL = 4 THEN GOSUB 6000
     IF LVL = 5 OR LVL = 6 THEN GOSUB 7000
     IF LVL >= 6 THEN GOSUB 8000
     RETURN
9500 'Menu
     CLS
     COLOR 4, 0: LOCATE 2, 7: PRINT "*** JUMPIN' JACK MENU ***"
     COLOR 15, 0: LOCATE 5, 4: PRINT "(1) START JUMPIN'"
                  LOCATE 7, 4: PRINT "(2) VIEW INSTRUCTIONS"
                  LOCATE 9, 4: PRINT "(3) HIGH SCORES"
                  LOCATE 11, 4: PRINT "(4) SEE YA'"
9510 A$ = INKEY$
     IF A$ = "1" OR A$ = "2" OR A$ = "3" OR A$ = "4" THEN GOTO 9520 ELSE GOTO 9510
9520 SELECT CASE A$
     CASE "1": CLS : GOSUB 100: GOTO 0
     CASE "2": GOTO 3950
     CASE "3": GOTO 9530
     CASE "4": GOTO 10000
     END SELECT
     GOTO 9520
9530 CLS
     COLOR 15, 0: LOCATE 2, 7: PRINT "*** HIGH SCORES ***"
     COLOR 4, 0
     PRINT
     PRINT
     PRINT "    "; IME1$; " .........."; HIGH1
     COLOR 14, 0
     PRINT
     PRINT "    "; IME2$; " .........."; HIGH2
     PRINT
     PRINT "    "; IME3$; " .........."; HIGH3
     COLOR 2, 0
     PRINT
     PRINT "    "; IME4$; " .........."; HIGH4
     COLOR 1, 0
     PRINT
     PRINT "    "; IME5$; " .........."; HIGH5
     PLAY "L10": PLAY "O1": PLAY "FGECADEF"
     WHILE INKEY$ = "": WEND
     GOTO 9500
10000 DEF SEG = 0: POKE 1047, KeyFlags: DEF SEG
     CLS
     PRINT
     PRINT
     COLOR 4, 0
     PRINT "   DEDICATED TO"
     PRINT
     PRINT
     COLOR 14, 0
     PRINT "   This game was written for my"
     PRINT
     PRINT "   cousin                 . She"
     LOCATE 8, 11: COLOR 9, 0: PRINT "PETRA FLEISCHMAN"
     PRINT
     COLOR 14, 0
     PRINT "   really loved this game."
     PRINT
     PRINT
     PRINT
     COLOR 2, 0
     PRINT "                      C r t"
     WHILE INKEY$ = "": WEND

