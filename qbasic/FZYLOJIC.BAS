'Is an example of fuzzy logic

CLS

INPUT "Target temperature?  ", targettemp
INPUT "Current room temperature?  ", room
PRINT "Season?  "
PRINT
PRINT " (1)  Summer"
PRINT " (2)  Fall"
PRINT " (3)  Winter"
PRINT " (4)  Spring"
LOCATE 3, 9
INPUT "", season

CLS
PRINT "When you would like to quit, press esc."
PRINT
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS
LET errer = room - targettemp
'IF errer <> 0 THEN GOTO correct

DO UNTIL d = 100
RANDOMIZE TIMER
d = INT(RND * 100) + 1
LOOP

correct:
IF season = 1 THEN LET change = 5
IF season = 2 OR season = 4 THEN RANDOMIZE TIMER: change = INT(RND * 3) + -1
IF season = 3 THEN LET change = -5




