DECLARE SUB lose ()
DECLARE SUB win ()
DECLARE SUB one ()
DECLARE SUB again ()
DECLARE SUB start ()
COMMON SHARED colors, colors1, colors2
COMMON SHARED c, cc, ccc
COMMON SHARED vv1$, vv2$, vv3$
start

SUB again
SLEEP 1
CLS
topp:
COLOR 15
LOCATE 15, 30
INPUT "Would you like to play again?  Y/N   ", yn$
IF yn$ = "Y" OR yn$ = "y" THEN start
IF yn$ = "N" OR yn$ = "n" THEN END
CLS
GOTO topp
END SUB

SUB lose

CLS
COLOR
COLOR 15
music$ = "<l4cl8cl1fl4cl8fl1a"
PRINT "Sorry, you lost."
PRINT "The correct combination was ";
COLOR colors
PRINT vv1$;
PRINT " ";
COLOR colors1
PRINT vv2$;
PRINT " ";
COLOR colors2
PRINT vv3$;
COLOR 15
PRINT "."
PLAY music$
PRINT
PRINT
COLOR 15
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
again
END SUB

SUB one
column = 15
CLS
RANDOMIZE TIMER
ccolors = INT(RND * 6) + 1
ccolors1 = INT(RND * 6) + 1
ccolors2 = INT(RND * 6) + 1

IF ccolors = 1 THEN LET colors = 12: LET vv1$ = "R": LET red = red + 1
IF ccolors = 2 THEN LET colors = 6: LET vv1$ = "O": LET orange = orange + 1
IF ccolors = 3 THEN LET colors = 14: LET vv1$ = "Y": LET yellow = yellow + 1
IF ccolors = 4 THEN LET colors = 10: LET vv1$ = "G": LET green = green + 1
IF ccolors = 5 THEN LET colors = 9: LET vv1$ = "B": LET blue = blue + 1
IF ccolors = 6 THEN LET colors = 5: LET vv1$ = "P": LET purple = purple + 1
                                                    
IF ccolors1 = 1 THEN LET colors1 = 12: LET vv2$ = "R": LET red = red + 1
IF ccolors1 = 2 THEN LET colors1 = 6: LET vv2$ = "O": LET orange = orange + 1
IF ccolors1 = 3 THEN LET colors1 = 14: LET vv2$ = "Y": LET yellow = yellow + 1
IF ccolors1 = 4 THEN LET colors1 = 10: LET vv2$ = "G": LET green = green + 1
IF ccolors1 = 5 THEN LET colors1 = 9: LET vv2$ = "B": LET blue = blue + 1
IF ccolors1 = 6 THEN LET colors1 = 5: LET vv2$ = "P": LET purple = purple + 1
                                             
IF ccolors2 = 1 THEN LET colors2 = 12: LET vv3$ = "R": LET red = red + 1
IF ccolors2 = 2 THEN LET colors2 = 6: LET vv3$ = "O": LET orange = orange + 1
IF ccolors2 = 3 THEN LET colors2 = 14: LET vv3$ = "Y": LET yellow = yellow + 1
IF ccolors2 = 4 THEN LET colors2 = 10: LET vv3$ = "G": LET green = green + 1
IF ccolors2 = 5 THEN LET colors2 = 9: LET vv3$ = "B": LET blue = blue + 1
IF ccolors2 = 6 THEN LET colors2 = 5: LET vv3$ = "P": LET purple = purple + 1


LET pred = pred + 1
LET porange = porange + 1
LET pyellow = pyellow + 1
LET pgreen = pgreen + 1
LET pblue = pblue + 1
LET ppurple = ppurple + 1





colors = 14
colors1 = 10
colors2 = 14
PRINT colors, colors1, colors2

COLOR 15
PRINT "To use the chart below, type in the letter which has the desired color."
PRINT
PRINT
LOCATE , 17
COLOR 12: PRINT "R       ";
COLOR 6: PRINT "O       ";
COLOR 14: PRINT "Y       ";
COLOR 10: PRINT "G       ";
COLOR 9: PRINT "B       ";
COLOR 5: PRINT "P       "
PRINT
PRINT
PRINT
COLOR 15
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS


PRINT
PRINT
PRINT
LOCATE , 17
COLOR 12: PRINT "R       ";
COLOR 6: PRINT "O       ";
COLOR 14: PRINT "Y       ";
COLOR 10: PRINT "G       ";
COLOR 9: PRINT "B       ";
COLOR 5: PRINT "P       "
PRINT
PRINT


numone:
IF chances = 10 THEN lose
COLOR 15
LOCATE 7, 1
PRINT "First color?"

DO WHILE y$ = ""
y$ = INKEY$
LOOP

SELECT CASE y$

CASE "r", "R"
LOCATE column, 37
COLOR 12: PRINT "R": LET c = 12: LET v$ = "R": LET pred = pred + 1

CASE "o", "O"
LOCATE column, 37
COLOR 6: PRINT "O": LET c = 6: LET v$ = "O": LET porange = porange + 1

CASE "y", "Y"
LOCATE column, 37
COLOR 14: PRINT "Y": LET c = 14: LET v$ = "Y": LET pyellow = pyellow + 1
                                 
CASE "g", "G"
LOCATE column, 37
COLOR 10: PRINT "G": LET c = 10: LET v$ = "G": LET pgreen = pgreen + 1

CASE "b", "B"
LOCATE column, 37
COLOR 9: PRINT "B": LET c = 9: LET v$ = "B": LET pblue = pblue + 1

CASE "p", "P"
LOCATE column, 37
COLOR 5: PRINT "P": LET c = 5: LET v$ = "P": LET ppurple = ppurple + 1

CASE ELSE
y$ = ""
GOTO numone
END SELECT

numtwo:
COLOR 15
LOCATE 7, 1
PRINT "Second color?    "

DO WHILE yy$ = ""
yy$ = INKEY$
LOOP

SELECT CASE yy$

CASE "r", "R"
LOCATE column, 40
COLOR 12: PRINT "R": LET cc = 12: LET vv$ = "R": LET pred = pred + 1

CASE "o", "O"
LOCATE column, 40
COLOR 6: PRINT "O": LET cc = 6: LET vv$ = "O": LET porange = porange + 1

CASE "y", "Y"
LOCATE column, 40
COLOR 14: PRINT "Y": LET cc = 14: LET vv$ = "Y": LET pyellow = pyellow + 1

CASE "g", "G"
LOCATE column, 40
COLOR 10: PRINT "G": LET cc = 10: LET vv$ = "G": LET pgreen = pgreen + 1

CASE "b", "B"
LOCATE column, 40
COLOR 9: PRINT "B": LET cc = 9: LET vv$ = "B": LET pblue = pblue + 1

CASE "p", "P"
LOCATE column, 40
COLOR 5: PRINT "P": LET cc = 5: LET vv$ = "P": LET ppurple = ppurple + 1

CASE ELSE
yy$ = ""
GOTO numtwo
END SELECT

numthree:
COLOR 15
LOCATE 7, 1
PRINT "Third color?       "

DO WHILE yyy$ = ""
yyy$ = INKEY$
LOOP

SELECT CASE yyy$

CASE "r", "R"
LOCATE column, 43
COLOR 12: PRINT "R": LET ccc = 12: LET vvv$ = "R": LET pred = pred + 1

CASE "o", "O"
LOCATE column, 43
COLOR 6: PRINT "O": LET ccc = 6: LET vvv$ = "O": LET porange = porange + 1

CASE "y", "Y"
LOCATE column, 43
COLOR 14: PRINT "Y": LET ccc = 14: LET vvv$ = "Y": LET pyellow = pyellow + 1

CASE "g", "G"
LOCATE column, 43
COLOR 10: PRINT "G": LET ccc = 10: LET vvv$ = "G": LET pgreen = pgreen + 1

CASE "b", "B"
LOCATE column, 43
COLOR 9: PRINT "B": LET ccc = 9: LET vvv$ = "B": LET pblue = pblue + 1

CASE "p", "P"
LOCATE column, 43
COLOR 5: PRINT "P": LET ccc = 5: LET vvv$ = "P": LET ppurple = ppurple + 1

CASE ELSE
yyy$ = ""
GOTO numthree
END SELECT

'PRINT c, cc, ccc

chances = chances + 1


IF c = colors THEN LET c1 = 2
IF cc = colors2 THEN LET c2 = 2
IF ccc = colors3 THEN LET c3 = 2

IF pred = red AND pred = 3 THEN LET c1 = 2: LET c2 = 2: LET c3 = 2: GOTO done
IF porange = orange AND porange = 3 THEN LET c1 = 2: LET c2 = 2: LET c3 = 2: GOTO done
IF pyellow = yellow AND pyellow = 3 THEN LET c1 = 2: LET c2 = 2: LET c3 = 2: GOTO done
IF pgreen = green AND pgreen = 3 THEN LET c1 = 2: LET c2 = 2: LET c3 = 2: GOTO done
IF pblue = blue AND pblue = 3 THEN LET c1 = 2: LET c2 = 2: LET c3 = 2: GOTO done
IF ppurple = purple AND ppurple = 3 THEN LET c1 = 2: LET c2 = 2: LET c3 = 2: GOTO done


IF colors = cc THEN LET c1 = 1
IF colors = ccc THEN LET c1 = 1
if colors2 = c then let c2 =


done:
RANDOMIZE TIMER
order = INT(RND * 6) + 1
SELECT CASE order

CASE 1
LOCATE column, 15
IF one1 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF one1 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF one1 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF two2 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF two2 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF two2 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF three3 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF three3 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF three3 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";

CASE 2
LOCATE column, 15
IF two2 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF two2 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF two2 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF one1 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF one1 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF one1 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF three3 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF three3 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF three3 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";

CASE 3
LOCATE column, 15
IF three3 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF three3 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF three3 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF one1 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF one1 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF one1 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF two2 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF two2 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF two2 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";

CASE 4
LOCATE column, 15
IF three3 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF three3 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF three3 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF two2 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF two2 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF two2 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF one1 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF one1 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF one1 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";

CASE 5
LOCATE column, 15
IF two2 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF two2 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF two2 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF three3 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF three3 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF three3 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF one1 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF one1 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF one1 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";

CASE 6
LOCATE column, 15
IF one1 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF one1 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF one1 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF three3 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF three3 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF three3 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";
IF two2 = 1 THEN COLOR 15: PRINT CHR$(254) + " ";
IF two2 = 2 THEN COLOR 12: PRINT CHR$(254) + " ";
IF two2 = 0 THEN COLOR 0: PRINT CHR$(254) + " ";

END SELECT

y$ = ""
yy$ = ""
yyy$ = ""

one1 = 0
two2 = 0
three3 = 0

c1 = 0
c2 = 0

column = column + 1

GOTO numone

END SUB

SUB start

CLS
chances = 0
SCREEN 12
SLEEP 2
LOCATE 12, 17
PRINT "Welcome to MASTERMIND";
COLOR 12
PRINT " EXPERT"
PALETTE 12, 63
SLEEP 3
CLS
top:
COLOR 15
LOCATE 16, 30
PRINT "1 player or 2?   ";
COLOR 12
INPUT "", ot$
PALETTE 12, 63

SELECT CASE ot$

CASE "1", "one", "ONE", "One"
one

CASE "2", "two", "TWO", "Two"
'two

CASE ELSE
CLS
GOTO top
END SELECT


END SUB

SUB win
CLS

music$ = "t 200 l4cfl8agl2f"
LOCATE 6, 33
COLOR 9
PRINT "CONGRATULATIONS!!!"
LOCATE 15, 37
COLOR 12
PRINT "YOU WIN!!!"
PLAY music$
COLOR 0
again
END SUB

