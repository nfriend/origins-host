DECLARE SUB seconds ()
DECLARE SUB hours ()
DECLARE SUB minutes ()
COMMON SHARED wherehour, whereminute, wheresecond, hour, minute, second
CLS
SCREEN 12
LET hhour = VAL(MID$(TIME$, 1, 2))
LET mminute = VAL(MID$(TIME$, 4, 5))
LET ssecond = VAL(MID$(TIME$, 7, 8))
IF hhour > 12 THEN LET hhour = hhour - 12

CIRCLE (320, 238), 200, 14
CIRCLE (320, 238), 230, 14
PAINT (320, 20), 14, 14
LOCATE 4, 40
PRINT "12"
LOCATE 27, 41
PRINT "6"
LOCATE 15, 64
PRINT "3"
LOCATE 15, 18
PRINT "9"
LOCATE 10, 60
PRINT "2"
LOCATE 6, 52
PRINT "1"
LOCATE 25, 52
PRINT "5"
LOCATE 21, 60
PRINT "4"
LOCATE 21, 22
PRINT "8"
LOCATE 25, 31
PRINT "7"
LOCATE 10, 21
PRINT "10"
LOCATE 6, 29
PRINT "11"
LOCATE 1, 1

DO UNTIL f$ <> ""
f$ = INKEY$

whereminute = 6.29
wheresecond = 6.29


hours
LOCATE 1, 1

        FOR rrf = 1 TO 130
        IF second > 16 OR second < 15 THEN CIRCLE (320, 238), rrf, 0, wheresecond + .1046666666666667#, wheresecond + .1046666666666667#
        IF second = 16 THEN CIRCLE (320, 238), rrf, 0, 0, 0
        IF second = 15 THEN CIRCLE (320, 238), rrf, 0, .1046666666666667#, .1046666666666667#
        IF second = 0 THEN CIRCLE (320, 238), rrf, 0, 1.684665, 1.684665
        NEXT rrf
     
     
        FOR rrie = 1 TO 150
        IF whereminute + .01 > 6.28 THEN LET whereminute = 0
        IF minute = 15 AND second < 16 AND second > 0 THEN CIRCLE (320, 238), rrie, 0, 0, 0
        CIRCLE (320, 238), rrie, 0, whereminute + .01, whereminute + .01'.01
        NEXT rrie
  
  
        FOR rri = 1 TO 100
        IF wherehour + .01 > 6.28 THEN LET wherehour = 0
        IF hour = 3 AND minute < 16 AND minute > 0 THEN CIRCLE (320, 238), rri, 0, 0, 0
        CIRCLE (320, 238), rri, 0, wherehour + .01, wherehour + .01'.01
        NEXT rri
       
       
       
        FOR rrf = 1 TO 130
        IF second > 16 OR second < 15 THEN CIRCLE (320, 238), rrf, 10, wheresecond, wheresecond  '.1046666666666667#
        IF second = 15 THEN CIRCLE (320, 238), rrf, 10, 0, 0
        IF second = 16 THEN CIRCLE (320, 238), rrf, 10, 6.185333333333333#, 6.185333333333333#
        NEXT rrf
       
        FOR rrie = 1 TO 150
        CIRCLE (320, 238), rrie, 12, whereminute, whereminute
        NEXT rrie
     
        FOR rri = 1 TO 100
        CIRCLE (320, 238), rri, 9, wherehour, wherehour
        NEXT rri

LOOP

DO WHILE INKEY$ = ""
LOOP

SUB hours

CIRCLE (320, 238), 10, 14
CIRCLE (320, 238), 4, 14
PAINT (320, 238), 14, 14


LET hour = VAL(MID$(TIME$, 1, 2))
LET minute = VAL(MID$(TIME$, 4, 5))
LET second = VAL(MID$(TIME$, 7, 8))

IF hour > 12 THEN LET hour = hour - 12
                                     
SELECT CASE hour

CASE 1
        LET wherehour = 1.046666667#
CASE 2
        LET wherehour = .52333
CASE 3
        LET wherehour = 6.29
CASE 4
        LET wherehour = 5.75666665#
CASE 5
        LET wherehour = 5.23333332#
CASE 6
        LET wherehour = 4.70999999#
CASE 7
        LET wherehour = 4.18666666#
CASE 8
        LET wherehour = 3.66333333#
CASE 9
        LET wherehour = 3.14
CASE 10
        LET wherehour = 2.61666666#
CASE 11
        LET wherehour = 2.09333333#
CASE 12
        LET wherehour = 1.57

END SELECT

DO UNTIL re = minute
wherehour = wherehour - 8.722222222222221D-03
IF wherehour < 0 THEN LET wherehour = 6.29
LET re = re + 1
LOOP

minutes

END SUB

SUB minutes
   

whereminute = 1.57
DO UNTIL ry = minute
        LET whereminute = whereminute - .1046666666666667#
        LET ry = ry + 1
IF whereminute < 0 THEN LET whereminute = 6.29
LOOP

DO UNTIL rye = second
        whereminute = whereminute - 1.744444444444445D-03
        IF whereminute < 0 THEN LET whereminute = 6.29
        LET rye = rye + 1
LOOP
IF whereminute < 0 THEN LET whereminute = 6.29

seconds
END SUB

SUB seconds
wheresecond = 6.29
SELECT CASE second
CASE 0 TO 14
        wheresecond = 1.57
        DO UNTIL rrg = second
                LET wheresecond = wheresecond - .1046666666666667#
                LET rrg = rrg + 1
        LOOP
CASE 15
        LET wheresecond = 6.29
CASE IS > 16
        rrg = 15
        DO UNTIL rrg = second
                LET wheresecond = wheresecond - .1046666666666667#
                LET rrg = rrg + 1
        LOOP
END SELECT

END SUB

