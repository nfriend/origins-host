CLS
SCREEN 12
SLEEP 3

LET f = 90

LET x = 320
LET y = 240


DO UNTIL r$ = "q"
r$ = INKEY$

IF r$ = "4" THEN LET f = f - 10
IF r$ = "6" THEN LET f = f + 10
LET d = f * (3.141592654# / 180)
'FOR i = 1 TO 50
LET b = SIN(d)
LET a = COS(d)
LET x = x + a
LET y = y + b
PSET (x, y)
FOR u = 1 TO 10
NEXT u
'NEXT i
LOOP

