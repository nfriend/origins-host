DECLARE SUB scrambler ()
COMMON SHARED p$
COMMON SHARED a$
CLS

LINE INPUT "Username?  ", un$
OPEN "c:/Qsave/a.txt" FOR OUTPUT AS #1
PRINT #1, un$
CLOSE

top:
CLS
CLEAR

PRINT "Password?  ";

DO UNTIL i$ = CHR$(13)
        i$ = INKEY$
        IF i$ <> "" AND i$ <> CHR$(13) THEN LET p$ = p$ + i$: PRINT "*";
LOOP

PRINT
PRINT "Please confirm your password:  ";


DO UNTIL d$ = CHR$(13)
        d$ = INKEY$
        IF d$ <> "" AND d$ <> CHR$(13) THEN LET p2$ = p2$ + d$: PRINT "*";
LOOP

CLS
OPEN "c:/Qsave/a.txt" FOR INPUT AS #1
LINE INPUT #1, a$
CLOSE

IF p2$ = p$ THEN PRINT "Your passwords matched.": SLEEP 3: scrambler
IF p2$ <> p$ THEN PRINT "Your two passwords did not match.  Press any key to continue...": DO WHILE INKEY$ = "": LOOP: GOTO top

KILL "c:/Qsave/a.txt"

SUB scrambler

DIM r$(1000)

CLS

d = LEN(a$) + ASC(p$)
e = LEN(p$) + ASC(a$)

filename:

INPUT "File name?  ", file$

IF LEN(file$) = 0 OR LEN(file$) > 8 THEN PRINT "You name may not be greater than 8 characters or smaller than 0.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO filename

PRINT "Message?"
i = 0
DO UNTIL y$ = CHR$(13)
        y$ = INKEY$
        IF y$ <> "" AND y$ <> CHR$(13) THEN LET r$(i) = y$: LET i = i + 1: PRINT y$;
        IF i = 1000 THEN EXIT DO
LOOP

f = f + (d + e)

u = 0

files$ = "c:/QSAVE/SCRAMBLR/" + file$ + ".txt"

OPEN files$ FOR OUTPUT AS #1
ff = 0
FOR i = 1 TO LEN(a$)
        ff = ff + 1
        PRINT #1, ASC(MID$(a$, ff, 1))
NEXT

PRINT #1, "a"

ff = 0
FOR i = 1 TO LEN(p$)
        ff = ff + 1
        PRINT #1, ASC(MID$(p$, ff, 1))
NEXT
PRINT #1, "b"

DO UNTIL r$(u) = ""
        RANDOMIZE f
        f = f + (d + e)
        w = INT(RND * 100) + 1
        PRINT #1, ASC(r$(u)) + w: u = u + 1
LOOP
PRINT #1, "c"
CLOSE

END SUB

