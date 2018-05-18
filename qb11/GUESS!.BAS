CLS
INPUT "This is a guessing game. You have 5 chances to guess the correct number between 0 and 5.  Push any key when ready.", f$
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
COLOR 15
PRINT "            Fatal error.  Internal virus installing...": SLEEP 4: SOUND 1000, 1: PRINT "Install complete."
SLEEP 1

CLS
PRINT
PRINT
PRINT
PRINT
c = 17
h = 0
top:
RANDOMIZE TIMER
a = INT(RND * 254) + 1
c = INT(RND * 30) + 1
ss = INT(RND * 2000) + 37
SOUND ss, 1
c = c + 1
h = h + 1
COLOR c
PRINT CHR$(a); " ";
IF h = 255 THEN GOTO ending
IF c = 30 THEN LET c = 17
GOTO top

ending:
CLS
COLOR 15
PRINT "Have a nice day!"
COLOR 0
END

