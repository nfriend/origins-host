CLS
SCREEN 12
SLEEP 5
DO UNTIL u$ = CHR$(27)
u$ = INKEY$
IF u$ <> CHR$(27) AND u$ <> "" THEN
FOR i = 51 TO 60
CIRCLE (320, 230), i, 0, u, u
NEXT i
END IF
IF u$ = "4" THEN LET u = u + .05: IF u = 6.29 THEN LET u = u - .05
IF u$ = "6" THEN LET u = u - .05: IF u = 0 THEN LET u = u + .05
IF u$ = CHR$(27) THEN END
IF u = 6.29 THEN LET u = 6.28
CIRCLE (320, 230), 50, 14
FOR i = 51 TO 60
CIRCLE (320, 230), i, 12, u, u
NEXT i
LOOP

