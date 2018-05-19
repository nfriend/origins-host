DECLARE SUB keeper ()
CLS
OPTION BASE 1

DIM SHARED existname$(100)

COMMON SHARED name$, career$


OPEN "./save/CAREER/NAMES.TXT" FOR INPUT AS #1

y = 1

DO UNTIL EOF(1)
INPUT #1, existname$(y)
y = y + 1
LOOP

CLOSE

askname:

LINE INPUT "What is your name?  ", name$
LET name$ = UCASE$(name$)

g = 1

DO UNTIL existname$(g) = ""
IF name$ = existname$(g) THEN
        PRINT "Sorry, but the name you chose has already been used. Overwrite?  Y/N";
        INPUT ""; yn$
        IF yn$ = "y" OR yn$ = "Y" THEN LET overwrite$ = "y": GOTO writename
        IF yn$ = "n" OR yn$ = "N" THEN GOTO askname
END IF
g = g + 1
LOOP

writename:
OPEN "./save/CAREER/" + name$ + ".txt" FOR OUTPUT AS #1
PRINT #1, name$

IF overwrite$ <> "y" THEN
        OPEN "./save/CAREER/NAMES.TXT" FOR APPEND AS #2
        PRINT #2, name$
END IF

CLOSE


SUB keeper
RANDOMIZE TIMER
choices = INT(RND * 10) + 5

END SUB

SUB start
CLS
PRINT "What would you like to do?"
PRINT
PRINT "     (1)  Shop Keeper"
PRINT "     (2)  Janitor"
PRINT "     (3)  Construction Worker"
PRINT "     (4)  Carpenter"

INPUT "", career$

SELECT CASE career$
CASE "1"
        LET job$ = "Shop Keeper"
        keeper
CASE "2"
        LET job$ = "Janitor"
        'janitor
CASE "3"
        LET job$ = "Construction Worker"
        'worker
CASE "4"
        LET job$ = "Carpenter"
        'carpenter
END SELECT



END SUB

