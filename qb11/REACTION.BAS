CLS
SCREEN 9
PRINT
PRINT "   Press SPACE when the screen flashes red."
PRINT "   Press any key to continue..."
SLEEP .5
CLS
i$ = INKEY$
SLEEP 3
RANDOMIZE TIMER
sleeptime = INT(RND * 3000000) + 1000000

FOR i = 1 TO sleeptime
NEXT i

LET timestart = TIMER
COLOR , 12
FOR i = 1 TO 10000
NEXT i
COLOR 15, 0

LET time = -10000
DO WHILE INKEY$ = ""
LET time = time + 1
LOOP

LET timefinal = TIMER - timestart

PRINT
PRINT "   Reaction time (seconds) :    "; timefinal
END

