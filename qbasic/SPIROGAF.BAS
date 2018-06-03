'Added in 2018 to allow for CPU time adjustment
'All timer loops will be multiplied by this factor
LET timeFactor = 0.0135

CLS
SCREEN 12

RANDOMIZE TIMER
c = INT(RND * 15) + 1

INPUT "Wheel Size?  ", wheel
PRINT "Hole Number? (1 - "; wheel; ")  ";
INPUT "", hole


p = 3.141592654# / 180

pi = 3.141592654#

a = 360

LET wheel = wheel / (2 * pi)

LET round = 105 / wheel


'PRINT round
'END

DO UNTIL f$ = "q" OR f$ = "Q"
f$ = INKEY$
g = g + 1
LET y = SIN(g * p) * (105 / (2 * pi)) + (wheel / 2)
LET x = COS(g * p) * (105 / (2 * pi)) + (wheel / 2)'105 - (wheel / 2)
LET a = SIN(g * p * round) * hole
LET b = COS(g * p * round) * hole
LET x = x + a + 320
LET y = y + b + 240
PSET (x, y), c
IF g = a THEN LET h = h + 1: LOCATE 3, 3: PRINT h: a = a + 360
FOR i = 1 TO 1000 * timeFactor
NEXT i
LOOP

