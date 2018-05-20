1 CLEAR
PRINT "do you want to find 1.lateral area, 2.total area, 3.volume ,all of right prisms"
INPUT a
IF a = 1 GOTO 10
IF a = 2 GOTO 50
IF a = 3 GOTO 100
GOTO 1
10 PRINT "enter length"
INPUT l
PRINT "enter width"
INPUT w
PRINT "enter height"
INPUT h
la = (l + w) * 2 * h
PRINT la
PRINT "would you like to do another? y/n"
INPUT q$
IF q$ = "y" GOTO 1
IF q$ = "n" GOTO 200

50 PRINT "enter length"
INPUT l
PRINT "enter width"
INPUT w
PRINT "enter height"
INPUT h
ta = ((l + w) * 2 * h) + (l * w) * 2
PRINT ta
PRINT "would you like to do another? y/n"
INPUT q$
IF q$ = "y" GOTO 1
IF q$ = "n" GOTO 200

100 PRINT "enter length"
INPUT l
PRINT "enter width"
INPUT w
PRINT "enter height"
INPUT h
v = l * w * h
PRINT v
PRINT "would you like to do another? y/n"
INPUT q$
IF q$ = "y" GOTO 1
IF q$ = "n" GOTO 200

200 PRINT "bye"

