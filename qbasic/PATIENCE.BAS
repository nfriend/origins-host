CLS
LOCATE 10, 20
COLOR 12
BEEP
PRINT "Welcome to PATIENCE v. 1.0"
COLOR 15
SLEEP 2
CLS
PRINT "This game will test your patience.  See how long you can hold the 'q' button!"
PRINT "Press and hold 'q' for as long as you can handle!"
PRINT "Time starts when you press 'q'"

DO UNTIL UCASE$(i$) = "Q"
i$ = INKEY$
LOOP

LET startime = TIMER

LET i$ = "q"

DO

IF second >= 3 THEN LET abc = 1
IF UCASE$(i$) <> "Q" AND abc = 1 THEN EXIT DO

IF startime > TIMER THEN LET startime = TIMER
IF TIMER >= startime + 1 THEN LET second = second + 1: LET startime = TIMER
IF second = 60 THEN LET second = 0: LET minute = minute + 1
IF minute = 60 THEN LET minute = 0: LET hour = hour + 1
IF hour = 25 THEN LET day = day + 1: LET hour = 0
IF day = 8 THEN LET week = week + 1: LET day = 0
IF week = 53 THEN LET year = year + 1: LET week = 0
IF year = 100 THEN LET century = century + 1: LET year = 0
IF century = 10 THEN EXIT DO

LOCATE 5, 10
PRINT "Seconds:     "; second
LOCATE 7, 10
PRINT "Minutes:     "; minute
LOCATE 9, 10
PRINT "Hours:       "; hour
LOCATE 11, 10
PRINT "Days:        "; day
LOCATE 13, 10
PRINT "Weeks:       "; week
LOCATE 15, 10
PRINT "Years:       "; year
LOCATE 17, 10
PRINT "Centuries:   "; century
temp = TIMER
LET i$ = "a"
DO UNTIL i$ = "q"
i$ = INKEY$
IF TIMER >= temp + 1 THEN EXIT DO
LOOP
IF i$ = "a" THEN EXIT DO
LOOP


done:

CLS

DIM highscores(11)
DIM highname$(11)
DIM s(11)
DIM m(11)
DIM h(11)
DIM d(11)
DIM w(11)
DIM y(11)
DIM c(11)


IF century > 0 THEN
LET score = century * 100: LET score = score * 52: LET score = score * 7: LET score = score * 24: LET score = score * 360 + second
GOTO ready
END IF

IF year > 0 THEN
LET score = year * 52: LET score = score * 7: LET score = score * 24: LET score = score * 360 + second
GOTO ready
END IF


IF week > 0 THEN
LET score = week * 7: LET score = score * 24: LET score = score * 360 + second
GOTO ready
END IF

IF day > 0 THEN
LET score = day * 24: LET score = score * 360 + second
GOTO ready
END IF

IF hour > 0 THEN
LET score = hour * 360
GOTO ready
END IF

IF minute > 0 THEN LET score = minute * 60 + second: GOTO ready
IF second > 0 THEN LET score = second

ready:
LOCATE 1, 2
PRINT "Your score: "; score
CLOSE
OPEN "./save/patience.txt" FOR INPUT AS #1

FOR i = 1 TO 9
        INPUT #1, highname$(i)
        INPUT #1, highscores(i)
INPUT #1, s(i)
INPUT #1, m(i)
INPUT #1, h(i)
INPUT #1, d(i)
INPUT #1, w(i)
INPUT #1, y(i)
INPUT #1, c(i)

NEXT i

INPUT #1, highname$(10)
INPUT #1, highscores(10)
INPUT #1, s(10)
INPUT #1, m(10)
INPUT #1, h(10)
INPUT #1, d(10)
INPUT #1, w(10)
INPUT #1, y(10)
INPUT #1, c(10)

IF score > highscores(10) THEN GOTO madehiscore


GOTO printhi

madehiscore:

LOCATE 4, 4
PRINT "You made the high score!"
LOCATE 5, 4
INPUT "Please type in your name: ", name$
CLS
CLOSE
OPEN "./save/patience.txt" FOR OUTPUT AS #1
u = 1
DO UNTIL highscores(u) < score
PRINT #1, highname$(u)
PRINT #1, highscores(u)
PRINT #1, s(u)
PRINT #1, m(u)
PRINT #1, h(u)
PRINT #1, d(u)
PRINT #1, w(u)
PRINT #1, y(u)
PRINT #1, c(u)
LET u = u + 1
LOOP

PRINT #1, name$
PRINT #1, score
PRINT #1, second
PRINT #1, minute
PRINT #1, hour
PRINT #1, day
PRINT #1, week
PRINT #1, year
PRINT #1, century

DO UNTIL u = 10
PRINT #1, highname$(u)
PRINT #1, highscores(u)
PRINT #1, s(u)
PRINT #1, m(u)
PRINT #1, h(u)
PRINT #1, d(u)
PRINT #1, w(u)
PRINT #1, y(u)
PRINT #1, c(u)
u = u + 1
LOOP

printhi:
CLOSE

OPEN "./save/patience.txt" FOR INPUT AS #1

y = 5
yy = 5
LOCATE 2, 10: PRINT "HIGHSCORES:"
LOCATE 3, 10: PRINT STRING$(11, CHR$(205)) 'or 240

FOR i = 1 TO 10
        IF yy - 4 = 1 OR yy - 4 = 3 OR yy - 4 = 5 OR yy - 4 = 7 OR yy - 4 = 9 THEN COLOR 12
        IF yy - 4 = 2 OR yy - 4 = 4 OR yy - 4 = 6 OR yy - 4 = 8 OR yy - 4 = 10 THEN COLOR 9
        LOCATE y, 1
        PRINT yy - 4
        IF yy - 4 < 10 THEN LOCATE y, 3: PRINT "."
        IF yy - 4 = 10 THEN LOCATE y, 4: PRINT "."
        LOCATE y, 6
        PRINT STRING$(20, ".")
        INPUT #1, a$
        LOCATE y, 6
        PRINT a$;
        INPUT #1, a
        LOCATE y, 26
        INPUT #1, a
        PRINT a; " seconds, ";
        INPUT #1, a
        PRINT a; " minutes, ";
        INPUT #1, a
        PRINT a; " hours, ";
        INPUT #1, a
        PRINT a; " days, "
        LOCATE y + 1, 26
        INPUT #1, a
        PRINT a; " weeks, ";
        INPUT #1, a
        PRINT a; " years, ";
        INPUT #1, a
        PRINT a; " centuries, ";
        yy = yy + 1
        y = y + 2
NEXT i


CLOSE

END






