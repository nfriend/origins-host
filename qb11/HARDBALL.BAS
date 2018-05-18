SCREEN 12
SLEEP 3
CLS


LET x1 = 100
LET y1 = 110
LET x2 = 120
LET y2 = 130

xinterval = 1
yinterval = 1
paddle1 = 285
paddle2 = 355
LINE (paddle1, 470)-(paddle2, 480), 12, BF
DO
LOCATE 1, 1: PRINT "Score:"; score; "      "
LINE (paddle1, 470)-(paddle2, 480), 12, BF
LINE (x1, y1)-(x2, y2), 0, BF
LET x1 = x1 + xinterval
LET x2 = x2 + xinterval
LET y1 = y1 + yinterval
LET y2 = y2 + yinterval

LINE (x1, y1)-(x2, y2), 9, BF

FOR i = 1 TO (2500 - (50 * hit))
NEXT i

IF x1 = 0 THEN LET xinterval = xinterval * -1

IF x2 = 640 THEN LET xinterval = xinterval * -1

IF y1 = 0 THEN LET yinterval = yinterval * -1

IF y2 = 470 AND ((x1 + x2) / 2 < paddle1 OR (x1 + x2) / 2 > paddle2) THEN EXIT DO
IF y2 = 470 AND ((x1 + x2) / 2 >= paddle1 AND (x1 + x2) / 2 <= paddle2) THEN LET yinterval = yinterval * -1: LET hit = hit + 1: LET score = score + ((hit - 1) + 10)

y$ = INKEY$

IF y$ = "1" THEN
        LINE (paddle1, 470)-(paddle2, 480), 0, BF
        IF paddle1 - (10 + (hit * .2)) < 0 THEN
                LET paddle1 = 0: LET paddle2 = 70
        ELSE
                LET paddle1 = paddle1 - (10 + (hit * .2))
                LET paddle2 = paddle2 - (10 + (hit * .2))
        END IF
       
        LINE (paddle1, 470)-(paddle2, 480), 12, BF
END IF

IF y$ = "3" THEN
        LINE (paddle1, 470)-(paddle2, 480), 0, BF
       
        IF paddle2 + (10 + (hit * .2)) > 680 THEN
                LET paddle2 = 680: LET paddle1 = 610
        ELSE
                LET paddle1 = paddle1 + (10 + (hit * .2))
                LET paddle2 = paddle2 + (10 + (hit * .2))
        END IF
       
        LINE (paddle1, 470)-(paddle2, 480), 12, BF
END IF

IF y$ = "q" THEN END
LOOP

END

