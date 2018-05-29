DECLARE SUB repeat ()
DECLARE SUB subrepeat ()
CLS

SCREEN 9

DIM SHARED what(1 TO 15000)

l = 173
w = 320

r = 1

top:

t$ = INKEY$
IF t$ = "5" THEN GOTO up
IF t$ = "2" THEN GOTO down
IF t$ = "1" THEN GOTO left
IF t$ = "3" THEN GOTO right
IF t$ = "q" THEN repeat
IF t$ = "" THEN GOTO top
GOTO top

up:
LET what(r) = 5
LET r = r + 1
LET l = l - 1
CIRCLE (w, l), 1, 9
GOTO top

down:
LET what(r) = 2
LET r = r + 1
LET l = l + 1
CIRCLE (w, l), 1, 9
GOTO top

left:
LET what(r) = 1
LET r = r + 1
LET w = w - 1
CIRCLE (w, l), 1, 9
GOTO top

right:
LET what(r) = 3
LET r = r + 1
LET w = w + 1
CIRCLE (w, l), 1, 9
GOTO top









SUB repeat

o = 320
g = 173

r = 1


DO UNTIL what(r) = 0
FOR i = 1 TO 35
NEXT i
IF what(r) = 5 THEN LET g = g - 1: CIRCLE (o, g), 1, 14
IF what(r) = 2 THEN LET g = g + 1: CIRCLE (o, g), 1, 14
IF what(r) = 1 THEN LET o = o - 1: CIRCLE (o, g), 1, 14
IF what(r) = 3 THEN LET o = o + 1: CIRCLE (o, g), 1, 14
LET r = r + 1
LOOP

subrepeat

END SUB



SUB subrepeat
o = 320
g = 173

r = 1


DO UNTIL what(r) = 0
FOR i = 1 TO 35
NEXT i
IF what(r) = 5 THEN LET g = g - 1: CIRCLE (o, g), 1, 9
IF what(r) = 2 THEN LET g = g + 1: CIRCLE (o, g), 1, 9
IF what(r) = 1 THEN LET o = o - 1: CIRCLE (o, g), 1, 9
IF what(r) = 3 THEN LET o = o + 1: CIRCLE (o, g), 1, 9
LET r = r + 1
LOOP



END SUB

