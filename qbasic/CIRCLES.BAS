CLS
CONST PI = 3.141592654#
LET number = (PI / 180)
SCREEN 12
FOR i = 1 TO 360
LET i = i * number
LET x = SIN(i) * 50
LET y = COS(i) * 50
LET x = x + 320
LET y = y + 240
PSET (x, y)
NEXT i

