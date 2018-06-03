'Added in 2018 to allow for CPU time adjustment
'All timer loops will be multiplied by this factor
LET timeFactor = 0.0135

CLS
SCREEN 12
SLEEP 3
PI = 3.141592654#
g = PI / 180

FOR l = 1 TO 10

RANDOMIZE TIMER
f = INT(RND * 5) + 2
c = INT(RND * 9) + 0

colors = INT(RND * 15) + 1

LET c = c * .1
LET w = c + f
LOCATE 1, 1
PRINT w
DO UNTIL (x + 320 + b) = startx AND (y + 240 + a) = starty AND g <> 1
IF g = 1 THEN LET g = 0
FOR i = 1 TO 360 * w STEP .01
LET y = COS(i * g) * 120
LET x = SIN(i * g) * 120
LET a = COS(i * g * 5.1) * 80
LET b = SIN(i * g * 5.1) * 80
PSET (x + 320 + a, y + 240 + b), colors
IF i = 1 THEN LET startx = x + 320 + b: LET starty = y + 240 + a: LET g = 1
FOR k = 1 TO 1000 * timeFactor
NEXT k
NEXT i
LOOP


NEXT l

