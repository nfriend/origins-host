DECLARE SUB inputer ()
DECLARE SUB options ()
DECLARE SUB backgroundcolor ()
DECLARE SUB colors ()
'       PRESS SHIFT+F5 TO BEGIN THIS PROGRAM

DECLARE SUB increments ()
DECLARE SUB circlesize ()

COMMON SHARED circles, incs, w, l, colr, bakc, tempcolor, changer, filename$, eraser

w = 320
l = 175


SCREEN 9
PRINT "What would you like to do?"
LOCATE 3, 3: PRINT "(1)   Start a new drawing"
LOCATE 5, 3: PRINT "(2)   View a drawing"
LOCATE 7, 3: PRINT "(3)   Edit a drawing"
DO WHILE n$ = ""
n$ = INKEY$
LOOP
IF n$ = "1" THEN GOTO top
IF n$ = "2" THEN
        OPEN "./save/DRAWINGS/names.txt" FOR INPUT AS #1
        LOCATE 3, 1
        DO UNTIL EOF(1)
        INPUT #1, a$
        PRINT a$,
        IF EOF(1) THEN EXIT DO
        INPUT #1, a$
        PRINT a$,
        IF EOF(1) THEN EXIT DO
        INPUT #1, a$
        PRINT a$
        IF EOF(1) THEN EXIT DO
        LOOP

LOCATE 1, 1
INPUT "Filename?  ", filename$
CLOSE
OPEN "./save/DRAWINGS/names.txt" FOR INPUT AS #1
DO UNTIL EOF(1)
input #1


OPEN "./save/DRAWINGS/" + filename$ + ".txt" FOR INPUT AS #1: CLS : LET eraser = 5: inputer: DO WHILE INKEY$ = "": LOOP: STOP
IF n$ = "3" THEN INPUT "Filename?  ", filename$: OPEN "./save/DRAWINGS/" + filename$ + ".txt" FOR INPUT AS #1: CLS : LET eraser = 5: inputer: LET tempcolor = colr * 4 + 4: GOTO here



top:
INPUT "What would you like to call this drawing?  ", filename$
IF LEN(filename$) = 0 THEN CLS : PRINT "You must type something in.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO top
IF LEN(filename$) > 8 THEN CLS : PRINT "Sorry, but your filename cannot be great then 8 characters.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO top

circlesize
increments
colors

backgroundcolor
OPEN "./save/DRAWINGS/" + filename$ + ".txt" FOR OUTPUT AS #1
PRINT #1, circles
PRINT #1, incs
PRINT #1, colr
PRINT #1, bakc
CLS
GOTO there
here:
OPEN "./save/DRAWINGS/" + filename$ + ".txt" FOR APPEND AS #1
there:
eraser = 5
DO WHILE i$ <> CHR$(27)
i$ = INKEY$
IF i$ = "4" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w - incs
        IF w < 0 - circles - 1 THEN LET w = w + incs
        IF eraser = 1 THEN CIRCLE (w + incs, l), circles, 0
        CIRCLE (w, l), circles, colr
PRINT #1, i$
END IF
IF i$ = "6" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w + incs
        IF w > circles + 640 THEN LET w = w - incs
        IF eraser = 1 THEN CIRCLE (w - incs, l), circles, 0
        CIRCLE (w, l), circles, colr
PRINT #1, i$
END IF
IF i$ = "2" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET l = l + incs
        IF l > circles + 350 THEN LET l = l - incs
        IF eraser = 1 THEN CIRCLE (w, l - incs), circles, 0
        CIRCLE (w, l), circles, colr
PRINT #1, i$
END IF
IF i$ = "8" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET l = l - incs
        IF l < 0 - circles THEN LET l = l + incs
        IF eraser = 1 THEN CIRCLE (w, l + incs), circles, 0
        CIRCLE (w, l), circles, colr
PRINT #1, i$
END IF
IF i$ = "1" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w - incs
        LET l = l + incs
        IF w < -1 - circles OR l > 350 + circles THEN LET w = w + incs: LET l = l - incs
        IF tempe <> 1 AND eraser = 1 THEN CIRCLE (w + incs, l - incs), circles, 0
        CIRCLE (w, l), circles, colr:
PRINT #1, i$
END IF
IF i$ = "3" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w + incs
        LET l = l + incs
        IF w > circles + 640 OR l > 350 + circles THEN LET w = w - incs: LET l = l - incs: LET tempe = 1
        IF tempe <> 1 AND eraser = 1 THEN CIRCLE (w - incs, l - incs), circles, 0
        CIRCLE (w, l), circles, colr:
PRINT #1, i$
END IF
IF i$ = "7" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w - incs
        LET l = l - incs
        IF w < 0 - circles - 5 OR l < 0 - circles THEN LET w = w + incs: LET l = l + incs
        IF tempe <> 1 AND eraser = 1 THEN CIRCLE (w + incs, l + incs), circles, 0
        CIRCLE (w, l), circles, colr:
PRINT #1, i$
END IF
IF i$ = "9" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w + incs
        LET l = l - incs
        IF w > circles + 640 OR l < 0 - circles THEN LET w = w - incs: LET l = l + incs
        IF tempe <> 1 AND eraser = 1 THEN CIRCLE (w - incs, l + incs), circles, 0
        CIRCLE (w, l), circles, colr:
PRINT #1, i$
END IF

IF i$ = CHR$(13) THEN LET eraser = eraser + 1: PRINT #1, i$

IF i$ = "o" OR i$ = "O" THEN options
'CIRCLE (w, l), circles, colr
LOOP

CLOSE

SUB backgroundcolor
COLOR 15, 0
CLS
COLOR 14
LOCATE 1, 1
PRINT "Use 6 to move to the next color.  Use 4 to move to the previous one."

IF changer <> 1 THEN LET bakc = 1
COLOR , 1
DO UNTIL w$ = CHR$(13)

w$ = INKEY$

IF w$ = "6" THEN
        LET bakc = bakc + 1
        LOCATE 1, 1
        PRINT "Use 6 to move to the next color.  Use 4 to move to the previous one."
        LOCATE 2, 1
        PRINT "Screen color: "; bakc
        IF bakc = 64 THEN LET bakc = bakc - 1
        COLOR 14, bakc
END IF

IF w$ = "4" THEN
        LET bakc = bakc - 1
        LOCATE 1, 1
        PRINT "Use 6 to move to the next color.  Use 4 to move to the previous one."
        LOCATE 2, 1
        PRINT "Screen color: "; bakc
        IF bakc = -1 THEN LET bakc = bakc + 1
        COLOR 14, bakc
END IF


IF w$ = CHR$(13) THEN EXIT DO

LOOP

COLOR , bakc

END SUB

SUB circlesize
CLS
COLOR 15, 0
IF changer <> 1 THEN LET circles = 30

LOCATE 1, 1




DO UNTIL y$ = CHR$(13)
        LOCATE 1, 1
        PRINT "Press 4 to decrease the size          Press 6 to increase the size."
        LOCATE 2, 1
        PRINT "Circle size:"; circles; "   "
        y$ = INKEY$
        IF y$ = "4" THEN CIRCLE (320, 175), circles, 0: LET circles = circles - 1: IF circles = -1 THEN LET circles = circles + 1:
        IF y$ = "6" THEN CIRCLE (320, 175), circles, 0: LET circles = circles + 1: IF circles = 401 THEN LET circles = circles - 1:
        CIRCLE (320, 175), circles, 15
LOOP

END SUB

3 SUB colors
CLS
COLOR 15, 0
PRINT "Please choose a color.  Use 4 to move left, and use 6 to move right."
FOR i = 8 TO 80 STEP 4
LOCATE 12, i
COLOR tempcolors
tempcolors = tempcolors + 1
PRINT CHR$(219)
IF tempcolors = 16 THEN EXIT FOR
NEXT i



IF changer <> 1 THEN LET tempcolor = 12
       
        COLOR 15
        LOCATE 11, tempcolor - 1
        PRINT CHR$(218)
        LOCATE 11, tempcolor
        PRINT CHR$(196)
        LOCATE 11, tempcolor + 1
        PRINT CHR$(191)
        LOCATE 12, tempcolor - 1
        PRINT CHR$(179)
        LOCATE 12, tempcolor + 1
        PRINT CHR$(179)
        LOCATE 13, tempcolor - 1
        PRINT CHR$(192)
        LOCATE 13, tempcolor
        PRINT CHR$(196)
        LOCATE 13, tempcolor + 1
        PRINT CHR$(217)
truecolor = 1

DO UNTIL d$ = CHR$(13)
d$ = INKEY$
IF d$ = "6" THEN
        COLOR 0
        LOCATE 11, tempcolor - 1
        PRINT CHR$(218)
        LOCATE 11, tempcolor
        PRINT CHR$(196)
        LOCATE 11, tempcolor + 1
        PRINT CHR$(191)
        LOCATE 12, tempcolor - 1
        PRINT CHR$(179)
        LOCATE 12, tempcolor + 1
        PRINT CHR$(179)
        LOCATE 13, tempcolor - 1
        PRINT CHR$(192)
        LOCATE 13, tempcolor
        PRINT CHR$(196)
        LOCATE 13, tempcolor + 1
        PRINT CHR$(217)
        IF tempcolor <> 68 THEN LET tempcolor = tempcolor + 4: LET colr = colr + 1
        COLOR 15
        LOCATE 11, tempcolor - 1
        PRINT CHR$(218)
        LOCATE 11, tempcolor
        PRINT CHR$(196)
        LOCATE 11, tempcolor + 1
        PRINT CHR$(191)
        LOCATE 12, tempcolor - 1
        PRINT CHR$(179)
        LOCATE 12, tempcolor + 1
        PRINT CHR$(179)
        LOCATE 13, tempcolor - 1
        PRINT CHR$(192)
        LOCATE 13, tempcolor
        PRINT CHR$(196)
        LOCATE 13, tempcolor + 1
        PRINT CHR$(217)

END IF
IF d$ = "4" THEN
        COLOR 0
        LOCATE 11, tempcolor - 1
        PRINT CHR$(218)
        LOCATE 11, tempcolor
        PRINT CHR$(196)
        LOCATE 11, tempcolor + 1
        PRINT CHR$(191)
        LOCATE 12, tempcolor - 1
        PRINT CHR$(179)
        LOCATE 12, tempcolor + 1
        PRINT CHR$(179)
        LOCATE 13, tempcolor - 1
        PRINT CHR$(192)
        LOCATE 13, tempcolor
        PRINT CHR$(196)
        LOCATE 13, tempcolor + 1
        PRINT CHR$(217)
        IF tempcolor <> 8 THEN LET tempcolor = tempcolor - 4: LET colr = colr - 1
        COLOR 15
        LOCATE 11, tempcolor - 1
        PRINT CHR$(218)
        LOCATE 11, tempcolor
        PRINT CHR$(196)
        LOCATE 11, tempcolor + 1
        PRINT CHR$(191)
        LOCATE 12, tempcolor - 1
        PRINT CHR$(179)
        LOCATE 12, tempcolor + 1
        PRINT CHR$(179)
        LOCATE 13, tempcolor - 1
        PRINT CHR$(192)
        LOCATE 13, tempcolor
        PRINT CHR$(196)
        LOCATE 13, tempcolor + 1
        PRINT CHR$(217)
END IF



LOOP

LET colr = colr + 1
END SUB

SUB increments
CLS
COLOR 15, 0
LOCATE 1, 1
COLOR 15
PRINT "Use 6 to increase the increment size between the circles.  Use 4 to decrease it."
IF changer <> 1 THEN LET incs = 5
DO UNTIL t$ = CHR$(13)
t$ = INKEY$
IF t$ = "4" THEN CIRCLE (circles + incs, 175), circles, 0: LET incs = incs - 1: IF incs = 0 THEN LET incs = incs + 1
IF t$ = "6" THEN CIRCLE (circles + incs, 175), circles, 0: LET incs = incs + 1: IF incs = 425 THEN LET incs = incs - 1
CIRCLE (circles, 175), circles, 9
CIRCLE (circles + incs, 175), circles, 12
LOOP
END SUB

SUB inputer
CLOSE
OPEN "./save/DRAWINGS/" + filename$ + ".txt" FOR INPUT AS #1
INPUT #1, circles
INPUT #1, incs
INPUT #1, colr
INPUT #1, bakc

DO UNTIL EOF(1)
INPUT #1, i$
IF i$ = "4" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w - incs
        IF w < circles THEN LET w = w + incs
        IF eraser = 1 THEN CIRCLE (w + incs, l), circles, 0
        CIRCLE (w, l), circles, colr
END IF
IF i$ = "6" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w + incs
        IF w > circles + 640 THEN LET w = w - incs
        IF eraser = 1 THEN CIRCLE (w - incs, l), circles, 0
        CIRCLE (w, l), circles, colr
END IF
IF i$ = "2" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET l = l + incs
        IF l > circles + 350 THEN LET l = l - incs
        IF eraser = 1 THEN CIRCLE (w, l - incs), circles, 0
        CIRCLE (w, l), circles, colr
END IF
IF i$ = "8" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET l = l - incs
        IF l < circles THEN LET l = l + incs
        IF eraser = 1 THEN CIRCLE (w, l + incs), circles, 0
        CIRCLE (w, l), circles, colr
END IF
IF i$ = "1" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w - incs
        LET l = l + incs
        IF w < circles OR l > 350 + circles THEN LET w = w - incs: LET l = l + incs
        IF eraser = 1 THEN CIRCLE (w + incs, l - incs), circles, 0
        CIRCLE (w, l), circles, colr:
END IF
IF i$ = "3" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w + incs
        LET l = l + incs
        IF w > circles + 640 OR l > 350 + circles THEN LET w = w - incs: LET l = l - incs
        IF eraser = 1 THEN CIRCLE (w - incs, l - incs), circles, 0
        CIRCLE (w, l), circles, colr:
END IF
IF i$ = "7" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w - incs
        LET l = l - incs
        IF w < circles OR l < circles THEN LET w = w + incs: LET l = l + incs
        IF eraser = 1 THEN CIRCLE (w + incs, l + incs), circles, 0
        CIRCLE (w, l), circles, colr:
END IF
IF i$ = "9" THEN
        IF eraser / 2 = CINT(eraser / 2) THEN CIRCLE (w, l), circles, 0
        LET w = w + incs
        LET l = l - incs
        IF w > circles + 640 OR l < circles THEN LET w = w + incs: LET l = l - incs
        IF eraser = 1 THEN CIRCLE (w - incs, l + incs), circles, 0
        CIRCLE (w, l), circles, colr:
END IF

IF i$ = CHR$(13) THEN LET eraser = eraser + 1: PRINT #1, i$

IF i$ = "CHANGE" THEN
        INPUT #1, g$
        IF g$ = "bakc" THEN INPUT #1, bakc
        IF g$ = "circles" THEN INPUT #1, circles
        IF g$ = "colr" THEN INPUT #1, colr: colr = colr - 1
        IF g$ = "incs" THEN INPUT #1, incs
END IF

LOOP
COLOR , bakc
CLOSE


END SUB

SUB options
CLS
PRINT "What would you like to do?"
LOCATE 3, 3
PRINT "(1)  Change the size of your circle"
LOCATE 5, 3
PRINT "(2)  Change how far your circle goes each time you press a button"
LOCATE 7, 3
PRINT "(3)  Change your circle's color"
LOCATE 9, 3
PRINT "(4)  Change your background color"
LOCATE 11, 3
PRINT "(5)  Cancel"
DO WHILE u$ = ""
u$ = INKEY$
LOOP
LET changer = 1

IF u$ = "1" OR u$ = "2" OR u$ = "3" OR u$ = "4" THEN PRINT #1, "CHANGE"

IF u$ = "1" THEN
        circlesize
        PRINT #1, "circles"
        PRINT #1, circles
        CLOSE
        LET w = 320
        LET l = 175
        CLS
        inputer
        OPEN "./save/DRAWINGS/" + filename$ + ".txt" FOR APPEND AS #1
END IF
IF u$ = "2" THEN
        increments
        PRINT #1, "incs"
        PRINT #1, incs
        CLOSE
        LET w = 320
        LET l = 175
        CLS
        inputer
        OPEN "./save/DRAWINGS/" + filename$ + ".txt" FOR APPEND AS #1
END IF
IF u$ = "3" THEN
        colors
        PRINT #1, "colr"
        PRINT #1, colr
        CLOSE
        LET w = 320
        LET l = 175
        CLS
        inputer
        OPEN "./save/DRAWINGS/" + filename$ + ".txt" FOR APPEND AS #1
END IF
IF u$ = "4" THEN
        backgroundcolor
        PRINT #1, "bakc"
        PRINT #1, bakc
        CLOSE
        LET w = 320
        LET l = 175
        CLS
        inputer
        OPEN "./save/DRAWINGS/" + filename$ + ".txt" FOR APPEND AS #1
END IF

END SUB

