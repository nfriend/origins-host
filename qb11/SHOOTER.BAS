CLS
SCREEN 12
x = 320
y = 240
DO WHILE i$ <> CHR$(27)
'IF shot = 1 THEN u = u + 1
i$ = INKEY$
IF i$ = "1" THEN LET x = x - 1
IF i$ = "3" THEN LET x = x + 1
IF i$ = "5" THEN LET y = y - 1
IF i$ = "2" THEN LET y = y + 1
IF i$ = " " THEN GOSUB shoot

IF shot = 1 AND yy > -11 THEN
        PSET (xx, yy + 10), 0
        LET yy = yy - 1
        PSET (xx, yy), 10
        IF yy <= -1 THEN LET shot = 0
        LET u = 0
END IF

LINE (x - 10, y + 5)-(x + 10, y - 5), 12, BF
LINE (x - 11, y - 6)-(x + 11, y + 6), 0, B
LOOP

END

shoot:
PSET (x, y), 10
LET xx = x
LET yy = y
LET shot = 1
RETURN

