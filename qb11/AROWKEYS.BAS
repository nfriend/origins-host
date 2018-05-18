CLS
PRINT "Please set the keys how you would like:"
PRINT "Press a key for up:"
DO WHILE up$ = ""
LET up$ = INKEY$
LOOP

PRINT "Press a key for down:"
DO WHILE down$ = ""
LET down$ = INKEY$
LOOP

PRINT "Press a key for left:"
DO WHILE left1$ = ""
LET left1$ = INKEY$
LOOP

PRINT "Press a key for right:"
DO WHILE right1$ = ""
LET right1$ = INKEY$
LOOP

SCREEN 12
LET x = 320
LET y = 240
CIRCLE (x, y), 10, 14

DO
LET i$ = INKEY$
IF i$ = up$ THEN CIRCLE (x, y), 10, 0: LET y = y - 10: CIRCLE (x, y), 10, 14
IF i$ = down$ THEN CIRCLE (x, y), 10, 0: LET y = y + 10: CIRCLE (x, y), 10, 14
IF i$ = left1$ THEN CIRCLE (x, y), 10, 0: LET x = x - 10: CIRCLE (x, y), 10, 14
IF i$ = right1$ THEN CIRCLE (x, y), 10, 0: LET x = x + 10: CIRCLE (x, y), 10, 14
IF i$ = "q" OR i$ = "Q" THEN END
LOOP

