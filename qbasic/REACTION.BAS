'Added in 2018 to allow for CPU time adjustment
'All timer loops will be multiplied by this factor
LET timeFactor = 0.0135

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
sleeptime = INT(RND * 3000000 * timeFactor) + (1000000 * timeFactor)

FOR i = 1 TO sleeptime
NEXT i

LET timestart = TIMER
COLOR , 12
FOR i = 1 TO 10000 * timeFactor
NEXT i
COLOR 15, 0

LET time = -10000 * timeFactor
DO WHILE INKEY$ = ""
LET time = time + 1
LOOP

LET timefinal = TIMER - timestart

PRINT
PRINT "   Reaction time (seconds) :    "; timefinal
END

