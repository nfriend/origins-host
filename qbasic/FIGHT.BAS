CLS
SCREEN 12
PALETTE 12, 63
COLOR 0
FOR i = 10 TO 18
LOCATE i, 25
COLOR 9
PRINT STRING$(10, CHR$(219))
NEXT i

FOR i = 10 TO 18
LOCATE i, 44
COLOR 12
PRINT STRING$(10, CHR$(219))
NEXT i

edu = 35
agi = 7
str = 7

eedu = 35
eagi = 7
estr = 7

ehealth = eedu
health = edu

DO UNTIL ehealth = 0 OR health = 0
        t$ = INKEY$
        IF t$ = "a" OR t$ = "A" THEN
                FOR u = 44 TO 35 STEP -1
                LOCATE 15, u
                COLOR 12
                PRINT CHR$(219)
                FOR i = 1 TO 100 'will be replace by time
                NEXT i
                NEXT u
                RANDOMIZE TIMER
                block = INT(RND * agi + 10) + 1
                SELECT CASE block
                        CASE 1 TO 10
                        LET edu = edu - 1
                        IF edu = 0 THEN GOTO win
                        CASE IS > 11
                END SELECT
        END IF
       
        IF t$ = "s" OR t$ = "S" THEN
                FOR u = 44 TO 25 STEP -1
                LOCATE 15, u
                COLOR 12
                PRINT CHR$(219)
                FOR i = 1 TO 100 'will be replace by time
                NEXT i
                NEXT u
                RANDOMIZE TIMER
                block = INT(RND * agi + 10) + 1
                SELECT CASE block
                        CASE 1 TO 10
                        LET edu = edu - 1
                        IF edu = 0 THEN GOTO win
                        CASE IS > 11
                END SELECT
        END IF

        IF t$ = "q" OR t$ = "Q" THEN
                FOR u = 44 TO 25 STEP -1
                LOCATE 15, u
                COLOR 12
                PRINT CHR$(219)
                FOR i = 1 TO 100 'will be replace by time
                NEXT i
                NEXT u
                RANDOMIZE TIMER
                block = INT(RND * agi + 10) + 1
                SELECT CASE block
                        CASE 1 TO 10
                        LET edu = edu - 1
                        IF edu = 0 THEN GOTO win
                        CASE IS > 11
                END SELECT
        END IF

        IF t$ = "w" OR t$ = "W" THEN
                FOR u = 44 TO 25 STEP -1
                LOCATE 15, u
                COLOR 12
                PRINT CHR$(219)
                FOR i = 1 TO 100 'will be replace by time
                NEXT i
                NEXT u
                RANDOMIZE TIMER
                block = INT(RND * agi + 10) + 1
                SELECT CASE block
                        CASE 1 TO 10
                        LET edu = edu - 1
                        IF edu = 0 THEN GOTO win
                        CASE IS > 11
                END SELECT
        END IF
       


LOOP

win:
PRINT "You won!"
END

