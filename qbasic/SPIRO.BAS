'Added in 2018 to allow for CPU time adjustment
'All timer loops will be multiplied by this factor
LET timeFactor = 0.0135

CLS
SCREEN 12
SLEEP 3
PI = 3.141592654#
g = PI / 180

INPUT "Inner wheel size?        ", iner
INPUT "Outerwheel size?         ", outr
INPUT "Hole number? (1 - 50)    ", holenum
INPUT "Color?                   ", colors

CLS
LET final = iner + outr

FOR i = 1 TO 1800
LET y = COS(i * g) * final
LET x = SIN(i * g) * final
LET a = COS(i * g * 3.2) * holenum
LET b = SIN(i * g * 3.2) * holenum
PSET (x + 320 + a, y + 240 + b), colors
FOR k = 1 TO 1000 * timeFactor
NEXT k
NEXT i

END

FOR i = 1 TO 1800
LET y = COS(i * g) * 160
LET x = SIN(i * g) * 160
LET a = COS(i * g * 3.2) * 40
LET b = SIN(i * g * 3.2) * 40
PSET (x + 320 + a, y + 240 + b), 12
FOR k = 1 TO 1000 * timeFactor
NEXT k
NEXT i

FOR i = 1 TO 4000
LET y = COS(i * g) * 40
LET x = SIN(i * g) * 40
LET a = COS(i * g * 2.9) * 10
LET b = SIN(i * g * 2.9) * 10
PSET (x + 320 + a, y + 240 + b), 14
FOR k = 1 TO 1000 * timeFactor
NEXT k
NEXT i


FOR i = 1 TO 6400
LET y = COS(i * g) * 80
LET x = SIN(i * g) * 80
LET a = COS(i * g * 4.7) * 20
LET b = SIN(i * g * 4.7) * 20
PSET (x + 320 + a, y + 240 + b), 9
FOR k = 1 TO 1000 * timeFactor
NEXT k
NEXT i

