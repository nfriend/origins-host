CLS
t = 14
f = 100
g = 100
DIM x(60)
DIM y(60)
DIM z(60)
SCREEN 9
    FOR i = 1 TO 60
    RANDOMIZE TIMER
    x(i) = INT(RND * 640) + 0
    y(i) = INT(RND * 346) + 0
    z(i) = INT(RND * 60) + 0
    NEXT i
top:
DO
u$ = INKEY$
IF u$ = "5" THEN LET g = g - 1: GOTO circler
IF u$ = "2" THEN LET g = g + 1: GOTO circler
IF u$ = "1" THEN LET f = f - 1: GOTO circler
IF u$ = "3" THEN LET f = f + 1: GOTO circler
IF u$ = " " THEN EXIT DO
IF u$ = "q" THEN END
CIRCLE (f, g), 1, 9
LOOP
PAINT (f, g), 9, 14

circler:
FOR y = 1 TO 60
CIRCLE (x(y), y(y)), z(y), t
NEXT y
GOTO top

