'Added in 2018 to allow for CPU time adjustment
'All timer loops will be multiplied by this factor
LET timeFactor = 0.0135

CLS
SCREEN 12
INPUT "Inner Wheel Size?  ", iner
INPUT "Outer Wheel Size?  ", outr
INPUT "Hole Number?       ", holenum
INPUT "Color Number?      ", c

LET finaliner = (iner / 2) - outr

LET h = 3.141592654# / 180

DO UNTIL r$ = "q"
r$ = INKEY$
LET i = i + 1
LET x = COS(i * h) * finaliner
LET y = SIN(i * h) * finaliner
LET a = COS(i * h * 4.2) * iner
LET b = SIN(i * h * 4.2) * iner
PSET ((x + 320 + a), (y + 240 + b)), c
FOR d = 1 TO 3000 * timeFactor
NEXT d
LOOP

