DECLARE SUB makeblocks ()
COMMON SHARED x1, y1, x2, y2, xinterval, yinterval, hit, score, paddle1, paddle2, y$, block1, block2, block3, block4, block5
DECLARE SUB blocks ()
DIM SHARED block(25)
SCREEN 12
SLEEP 3
CLS





block(5) = 10
block(10) = 9
block(15) = 9
block(20) = 10
block(25) = 10

LET x1 = 200
LET y1 = 110
LET x2 = 220
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

blocks

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

SUB blocks

'LINE (290, 90)-(350, 110), block(5), BF
'       1   2     3    4       5
makeblocks
       
        FOR i = 1 TO 25 STEP 5
        IF ((y1 = block(i + 3) OR y2 = block(i + 1)) AND ((x1 + x2) / 2 >= block(i) AND (x1 + x2) / 2 <= block(i + 2))) AND block(i + 4) <> 0 THEN
                LET block(i + 4) = 0
                LET score = score + (50 + hit)
                LET yinterval = yinterval * -1
                GOTO blockhit
        END IF
        NEXT i
       
        FOR i = 1 TO 25 STEP 5
        IF ((x1 = block(i + 3) OR x2 = block(i + 1)) AND ((y1 + y2) / 2 >= block(i + 1) AND (y1 + y2) / 2 <= block(i + 3))) AND block(i + 4) <> 0 THEN
                LET block(i + 4) = 0
                LET score = score + (50 + hit)
                LET xinterval = xinterval * -1
                GOTO blockhit
        END IF
        NEXT i
       


blockhit:
IF block(5) = 0 AND block(10) = 0 AND block(15) = 0 AND block(20) = 0 AND block(25) = 0 THEN
        LOCATE 13, 40
        PRINT "YOU WIN!"
        r$ = INKEY$
        END
END IF

END SUB

SUB makeblocks
LINE (290, 90)-(350, 110), block(5), BF
LINE (230, 90)-(290, 110), block(10), BF
LINE (350, 90)-(410, 110), block(15), BF
LINE (170, 90)-(230, 110), block(20), BF
LINE (410, 90)-(470, 110), block(25), BF

block(1) = 290: block(2) = 90: block(3) = 350: block(4) = 110
block(6) = 230: block(7) = 90: block(8) = 290: block(9) = 110
block(11) = 350: block(12) = 90: block(13) = 410: block(14) = 110
block(16) = 170: block(17) = 90: block(18) = 230: block(19) = 110
block(21) = 410: block(22) = 90: block(23) = 470: block(24) = 110


END SUB

