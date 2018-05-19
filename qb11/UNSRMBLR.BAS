DECLARE SUB unscrambler ()
COMMON SHARED a$
COMMON SHARED p$
CLS

DIM SHARED y$(1000)

filetop:
INPUT "File name? ", file$

IF LEN(file$) > 8 OR LEN(file$) = 0 THEN PRINT "Sorry, but your file name cannot be greater and 8 or less than 1.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO filetop

files$ = "./save/SCRAMBLR/" + file$ + ".txt"

r = 0

'ON ERROR GOTO wrong

OPEN files$ FOR INPUT AS #1

DO UNTIL l$ = "a"
        INPUT #1, l$
        PRINT l$
        LET a$ = a$ + l$
LOOP
INPUT "1", d$
DO UNTIL r$ = "b"
        INPUT #1, r$
        PRINT r$
        p$ = p$ + r$
LOOP
r = 0
INPUT "2", d$
DO UNTIL EOF(1)
        INPUT #1, y$(r)
        PRINT y$(r)
        r = r + 1
LOOP
CLOSE
INPUT "3", d$
unscrambler

wrong:
PRINT "Sorry, but the file you are trying to open does not exist."
PRINT "You must resart this program."
END

SUB unscrambler

DIM r$(1000)

CLS

d = LEN(a$) + ASC(p$)
e = LEN(p$) + ASC(a$)
p = 0
DO UNTIL y$(p) = ""
PRINT y$(p)
p = p + 1
LOOP
f = f + (d + e)

u = 0
DO UNTIL y$(u) = ""
        RANDOMIZE f
        f = f + (d + e)
        w = INT(RND * 100) + 1
        PRINT w
        PRINT y$(u)
        INPUT "", k$
        PRINT CHR$(ASC(y$(u) - w))
        u = u + 1
LOOP


END SUB

