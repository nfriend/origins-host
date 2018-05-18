
'READ THIS BEFORE YOU START THIS DRAWING PROGRAM!!
'YOU MUST HAVE NUM LOCK ON IN ORDER FOR THIS PROGRAM TO FUNCTION PROPERLY!
'PUSH SHIFT+F5 TO START THIS PROGRAM.


top: CLS
SCREEN 9
COLOR 12
PRINT "This is a drawing program.  Make sure that Num Lock is on."
PRINT "Use the numberpad to move.  Pushing c will change colors, and b will change yourbackground color.  After pushing it, type in your number.  You will not be able to see it, but it is there.  q will quit, r will start totally over, t will     erase your screen, and s will change your circle size.  After you have pushed s,type in your number for size of circle.  The same thing goes for i, or          increment.  Push 5 to enter or exit the eraser.  To fill in a object ( it must  be totaly inclosed ) press p and type in the nuber of the color you want.": a = 30
PRINT
COLOR 15
topss: PRINT "Now you can choose what size of circle you want to draw with. 4 = smaller,      6 = bigger, any key = done.  Push any key when you are ready to start."
starttop:
j$ = INKEY$
IF j$ <> "" THEN GOTO subtops
IF j$ = "" THEN GOTO starttop
subtops:
a = 30
tops: 'IF a = -1 THEN GOTO badcircle
'IF a = 1500 THEN GOTO bbadcircle
CIRCLE (320, 163), a
PRINT "Your circle size is "; a; "."
CLS
h$ = INKEY$
IF h$ = "6" THEN GOTO bigger
IF h$ = "4" THEN GOTO smaller
IF h$ = "" THEN CIRCLE (320, 163), a: PRINT "Your circle size is", a, ".": GOTO tops
IF h$ <> "" OR h$ <> "6" OR h$ <> "4" THEN GOTO ccolor
'IF h$ = "q" THEN GOTO ccolor

smaller:
a = a - 1
IF a < 0 THEN LET a = a + 1
CIRCLE (320, 163), a
GOTO tops

bigger:
a = a + 1
IF a > 9999 THEN LET a = a - 1
CIRCLE (320, 163), a
GOTO tops

ccolor:
d = 320
e = 167
'INPUT "What color would you like? 0 = black, 1 = dark blue, 2 = green, 3 = turquoise,  4 = red, 5 = purple, 6 = orange, 7 = light gray, 8 = gray, 9 = bright blue,     10 = bright green,  11 = light blue, 12 = bright red, 13 = bright purple,       14 = yellow, 15 = white.", c
PRINT "You may now pick you circle color.  You have a number of choices.  To go forward1 circle color, push 6.  4 is backwards.  Your circle color will be displayed.  Press any key exept 4 and 6 when you have your desired circle color on the      screen.  After have picked you circle color you will go directly to the         background picker.  It is the same as this circle picker.  Press any key to     continue..."
backstart:
iy$ = INKEY$
IF iy$ = "" THEN GOTO backstart
IF iy$ <> "" THEN c = 1: CLS : GOTO nexts
nexts:
CIRCLE (320, 173), 50, c
bak = 1
u$ = INKEY$
IF u$ = "6" THEN GOTO morec
IF u$ = "4" THEN GOTO lessc
IF u$ = "" THEN GOTO nexts
IF u$ <> "" OR u$ <> "4" OR u$ <> "6" THEN CLS : GOTO subbaktop
GOTO nexts

morec:
c = c + 1
IF c > 15 THEN c = c - 1
CIRCLE (320, 173), 50, c: GOTO nexts

lessc:
c = c - 1
IF c < 0 THEN c = c + 1
CIRCLE (320, 173), 50, c: GOTO nexts

subbaktop:
COLOR 0, bak
baktop:
PRINT "Your background number is", bak, "."
u$ = INKEY$
IF u$ = "6" THEN GOTO more
IF u$ = "4" THEN GOTO less
IF u$ = "" THEN GOTO baktop
IF u$ <> "" OR u$ <> "6" OR u$ <> "4" THEN GOTO increm


COLOR 0, 0: INPUT "Would you like to print out a color code sheet? y = yes, n = no  ", y$
IF y$ = "n" OR y$ = "N" THEN : GOTO increm
IF y$ = "y" OR y$ = "Y" THEN INPUT "Are you sure you want to print out a color code sheet?", printout$: GOTO printout
increm: COLOR 15, 0: INPUT "How many pixels would you like your circle to move at a time? ", inc
drawtops: CLS : COLOR 0, bak
drawtop:
'COLOR 0, bak
k$ = INKEY$
IF k$ = "1" THEN LET d = d - inc: e = e + inc: CIRCLE (d, e), a, c: GOTO drawtop
IF k$ = "2" THEN LET e = e + inc: CIRCLE (d, e), a, c: GOTO drawtop
IF k$ = "3" THEN LET d = d + inc: e = e + inc: CIRCLE (d, e), a, c: GOTO drawtop
IF k$ = "4" THEN LET d = d - inc: CIRCLE (d, e), a, c: GOTO drawtop
IF k$ = "5" THEN GOTO eraser
IF k$ = "6" THEN LET d = d + inc: CIRCLE (d, e), a, c: GOTO drawtop
IF k$ = "7" THEN LET d = d - inc: e = e - inc: CIRCLE (d, e), a, c: GOTO drawtop
IF k$ = "8" THEN LET e = e - inc: CIRCLE (d, e), a, c: GOTO drawtop
IF k$ = "9" THEN LET d = d + inc: e = e - inc: CIRCLE (d, e), a, c: GOTO drawtop
IF k$ = "q" OR k$ = "Q" THEN COLOR 15: END
IF k$ = "t" OR k$ = "T" THEN GOTO drawtops
IF k$ = "r" OR k$ = "R" THEN GOTO top
IF k$ = "b" OR k$ = "B" THEN GOTO backd
IF k$ = "p" OR k$ = "P" THEN GOTO filler
COLOR 0: IF k$ = "i" OR k$ = "I" THEN INPUT "", inc: GOTO drawtop
COLOR 0: IF k$ = "s" OR k$ = "S" THEN INPUT "", a: GOTO drawtop
COLOR 0: IF k$ = "c" OR k$ = "C" THEN INPUT "", c: GOTO drawtop
'IF k$ <> "1" OR k$ <> "2" OR k$ <> "3" OR k$ <> "4" OR k$ <> "5" OR k$ <> "6" OR k$ <> "7" OR k$ <> "8" OR k$ <> "9" OR k$ <> "q" OR k$ <> "Q" OR k$ <> "r" OR k$ <> "R" OR k$ <> "t" OR k$ <> "T" OR k$ <> "S" OR k$ <> "s" OR k$ <> "C" OR k$ <> "c" OR k$ <> "" OR k$ = "b" OR k$ = "B" THEN GOTO drawtop
IF k$ = "" THEN GOTO drawtop


eraser:
k$ = INKEY$
IF k$ = "1" THEN LET d = d - inc: e = e + inc: LET dd = d + inc: LET ee = e - inc: CIRCLE (dd, ee), a, 0: CIRCLE (d, e), a, c: GOTO eraser
IF k$ = "2" THEN LET e = e + inc:  LET ee = e - inc: CIRCLE (d, ee), a, 0: CIRCLE (d, e), a, c: GOTO eraser
IF k$ = "3" THEN LET d = d + inc: e = e + inc:   LET dd = d - inc: LET ee = e - inc: CIRCLE (dd, ee), a, 0: CIRCLE (d, e), a, c: GOTO eraser
IF k$ = "4" THEN LET d = d - inc: CIRCLE (d, e), a, c:  LET dd = d + inc: CIRCLE (dd, e), a, 0: CIRCLE (d, e), a, c: GOTO eraser
IF k$ = "5" THEN CIRCLE (d, e), a, 0: GOTO drawtop
IF k$ = "6" THEN LET d = d + inc: CIRCLE (d, e), a, c:  LET dd = d - inc: CIRCLE (dd, e), a, 0: CIRCLE (d, e), a, c: GOTO eraser
IF k$ = "7" THEN LET d = d - inc: e = e - inc: CIRCLE (d, e), a, c:  LET dd = d + inc: LET ee = e + inc: CIRCLE (dd, ee), a, 0: CIRCLE (d, e), a, c: GOTO eraser
IF k$ = "8" THEN LET e = e - inc:  LET ee = e + inc: CIRCLE (d, ee), a, 0: CIRCLE (d, e), a, c: GOTO eraser
IF k$ = "9" THEN LET d = d + inc: e = e - inc:   LET dd = d - inc: LET ee = e + inc: CIRCLE (dd, ee), a, 0: CIRCLE (d, e), a, c: GOTO eraser
IF k$ = "q" OR k$ = "Q" THEN COLOR 15: END
IF k$ = "t" OR k$ = "T" THEN GOTO eraser
IF k$ = "r" OR k$ = "R" THEN GOTO top
COLOR 0: IF k$ = "b" OR k$ = "B" THEN CIRCLE (d, e), a, 0: INPUT "", bak
COLOR 0: IF k$ = "i" OR k$ = "I" THEN CIRCLE (d, e), a, 0: INPUT "", inc: GOTO drawtop
COLOR 0: IF k$ = "s" OR k$ = "S" THEN CIRCLE (d, e), a, 0: INPUT "", a: GOTO eraser
COLOR 0: IF k$ = "c" OR k$ = "C" THEN CIRCLE (d, e), a, 0: INPUT "", c: GOTO eraser
IF k$ <> "1" OR k$ <> "2" OR k$ <> "3" OR k$ <> "4" OR k$ <> "5" OR k$ <> "6" OR k$ <> "7" OR k$ <> "8" OR k$ <> "9" OR k$ <> "q" OR k$ <> "Q" OR k$ <> "r" OR k$ <> "R" OR k$ <> "t" OR k$ <> "T" OR k$ <> "S" OR k$ <> "s" OR k$ <> "C" OR k$ <> "c" OR k$ <> "" OR k$ = "b" OR k$ = "B" THEN GOTO eraser
IF k$ = "" THEN GOTO eraser

printout:
IF printout$ = "Y" OR printout$ = "y" OR printout$ = "Yes" OR printout$ = "yes" OR printout$ = "YES" THEN GOTO nextprint
IF printout$ = "N" OR printout$ = "n" OR printout$ = "No" OR printout$ = "no" OR printout$ = "NO" THEN GOTO increm
nextprint: LPRINT "1 = black, 2 = green, 3 = turquoise, 4 = red, 5 = purple, 6 = orange,           7 = light gray, 8 = gray, 9 = bright blue, 10 = bright green,  11 = light blue,           12 = bright red, 13 = bright purple, 14 = yellow, 15 = white."
GOTO increm

backd:
INPUT "", bak
COLOR 0, bak
GOTO drawtop


more:
bak = bak + 1
IF bak > 63 THEN bak = bak - 1: COLOR 0, bak: GOTO baktop
IF bak < 63 THEN bak = bak + 1: COLOR 0, bak: GOTO baktop
GOTO baktop

less:
bak = bak - 1
IF bak < 0 THEN bak = bak + 1: COLOR 0, bak: GOTO baktop
IF bak > 0 THEN bak = bak - 1: COLOR 0, bak: GOTO baktop
GOTO baktop

filler:
COLOR 0
INPUT painter
PAINT (d, e), painter, c
GOTO drawtops

