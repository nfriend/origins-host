CLS
PRINT "Welcome to Stress Reliever 1.0"
PRINT
INPUT "What is the person's name that you are mad at?  ", person$
LET p$ = UCASE$(person$)
IF p$ = "NATHAN" THEN CLS : END
IF p$ = "NATHAN FRIEND" THEN CLS : END
IF p$ = "NATHAN F" THEN CLS : END
IF p$ = "FRIEND" THEN CLS : END
IF p$ = "N. FRIEND" THEN CLS : END
IF p$ = "NATHAN A. FRIEND" THEN CLS : END
IF p$ = "NATHAN ANDREW FRIEND" THEN CLS : END
IF p$ = "NF" THEN CLS : END
IF p$ = "N. A. FRIEND" THEN CLS : END
IF p$ = "N FRIEND" THEN CLS : END
IF p$ = "N A FRIEND" THEN CLS : END
IF p$ = "NAF" THEN CLS : END
IF p$ = "N" THEN CLS : END

'FOR i = 1 TO 50
'IF MID$(p$, i, i) = "N" THEN LET m = m + 1
'IF MID$(p$, i, i) = "A" THEN LET m = m + 1
'IF MID$(p$, i, i) = "F" THEN LET m = m + 1
'NEXT i

IF m >= 3 THEN CLS : END



LET locater = LEN(person$) / 2

CLS

COLOR 4
FOR i = 7 TO 16
LOCATE i, 23
PRINT STRING$(12, CHR$(219))
NEXT i


COLOR 1
FOR i = 7 TO 16
LOCATE i, 46
PRINT STRING$(12, CHR$(219))
NEXT i

LOCATE 11, 29 - locater
COLOR 0, 4
PRINT person$

LOCATE 11, 50
COLOR 0, 1
PRINT "You"
          
top:     
DO WHILE i$ <> CHR$(27)
IF hit = 20 THEN GOTO hitter
i$ = INKEY$
IF i$ <> "" AND i$ <> CHR$(27) THEN GOTO upper
'IF i$ = "a" OR i$ = "A" THEN GOTO lower
LOOP

COLOR 12
IF i$ = CHR$(27) THEN END

upper:
LET hit = hit + 1
FOR u = 46 TO 35 STEP -1
        COLOR 1
        LOCATE 8, u
        PRINT CHR$(219)
        FOR y = 1 TO 5000
        NEXT y
NEXT u

FOR u = 35 TO 45
        COLOR 0
        LOCATE 8, u
        PRINT CHR$(219)
        FOR y = 1 TO 5000
        NEXT y
NEXT u

GOTO top

hitter:

LET n = 7

FOR m = 1 TO 50


LET nn = nn + 1
IF nn = 10 THEN LET n = n + 1

FOR h = 16 TO 7 STEP -1
        RANDOMIZE TIMER
        d = INT(RND * 2) + 1
       
        IF d = 1 THEN
                FOR g = 23 TO 35
                        RANDOMIZE TIMER
                s = INT(RND * m) + 1
                j = INT(RND * 3) + 1
                IF j = 1 THEN LET l$ = CHR$(176)
                IF j = 2 THEN LET l$ = CHR$(177)
                IF j = 3 THEN LET l$ = CHR$(178)
                IF s = 1 THEN LET c = 4
                IF s = 2 THEN LET c = 14
                IF s = 3 THEN LET c = 12
                IF s = 4 THEN LET c = 6
                IF s = 5 THEN LET c = 0
                IF s > 4 AND s < 101 THEN LET c = 0

                COLOR c, 0, 0
                LOCATE h, g
                PRINT l$
        
                NEXT g
        END IF
       
        IF d = 2 THEN
                FOR g = 22 TO 36
                        RANDOMIZE TIMER
                        s = INT(RND * m) + 1
                        j = INT(RND * 3) + 1
                        IF j = 1 THEN LET l$ = CHR$(176)
                        IF j = 2 THEN LET l$ = CHR$(177)
                        IF j = 3 THEN LET l$ = CHR$(178)
                        IF s = 1 THEN LET c = 4
                        IF s = 2 THEN LET c = 14
                        IF s = 3 THEN LET c = 6
                        IF s = 4 THEN LET c = 12
                        IF s > 4 AND s < 101 THEN LET c = 0
                       
                        COLOR c, 0, 0
                        LOCATE h, g
                        PRINT l$
        
                NEXT g
        
        END IF

               
                FOR g = 25 TO 33
                        RANDOMIZE TIMER
                        s = INT(RND * m) + 1
                        j = INT(RND * 3) + 1
                        IF j = 1 THEN LET l$ = CHR$(176)
                        IF j = 2 THEN LET l$ = CHR$(177)
                        IF j = 3 THEN LET l$ = CHR$(178)
                        IF s = 1 THEN LET c = 4
                        IF s = 2 THEN LET c = 14
                        IF s = 3 THEN LET c = 6
                        IF s = 4 THEN LET c = 12
                        IF s > 4 AND s < 101 THEN LET c = 0
                       
                        COLOR c, 0, 0
                        LOCATE 6, g
                        PRINT l$
       
                NEXT g
        
                FOR g = 27 TO 30
                        RANDOMIZE TIMER
                        s = INT(RND * m) + 1
                        j = INT(RND * 3) + 1
                        IF j = 1 THEN LET l$ = CHR$(176)
                        IF j = 2 THEN LET l$ = CHR$(177)
                        IF j = 3 THEN LET l$ = CHR$(178)
                        IF s = 1 THEN LET c = 4
                        IF s = 2 THEN LET c = 14
                        IF s = 3 THEN LET c = 6
                        IF s = 4 THEN LET c = 12
                        IF s > 4 AND s < 101 THEN LET c = 0

                        COLOR c, 0, 0
                        LOCATE 5, g
                        PRINT l$
      
                NEXT g



NEXT h

NEXT m

