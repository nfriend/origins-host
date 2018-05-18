DECLARE SUB linedone ()
DECLARE SUB rotate ()
DECLARE SUB lose ()
DECLARE SUB main ()
DECLARE SUB graphics ()
DECLARE SUB rand ()

COMMON SHARED l$, r$, u$, d$, blocktype, blockcount, time, counter, position, blocknumber, t

CLS

'dimensions - 20 x 13

OPTION BASE 1

DIM SHARED blocks(290)  'blocks already on the ground
DIM SHARED b(10)  'the positions of the blocks currently dropping



PRINT "Please calibrate the keys:"

PRINT "Press left arrow key (move left):"
DO UNTIL l$ <> ""
LET l$ = INKEY$
LOOP

PRINT "Press right arrow key (move right):"
DO UNTIL r$ <> ""
LET r$ = INKEY$
LOOP

PRINT "Press down arrow key (drop block):"
DO UNTIL d$ <> ""
LET d$ = INKEY$
LOOP

PRINT "Press up arrow key (toggle display next block):"
DO UNTIL u$ <> ""
LET u$ = INKEY$
LOOP

rand

SUB graphics

CLS

COLOR 12
FOR r = 1 TO 20
LOCATE r, 28
PRINT CHR$(186)
NEXT r
FOR r = 1 TO 20
LOCATE r, 56
PRINT CHR$(186)
NEXT r

LOCATE 21, 28
PRINT STRING$(28, CHR$(205))
LOCATE 21, 28
PRINT CHR$(200)
LOCATE 21, 56
PRINT CHR$(188)
COLOR 15


FOR i = 1 TO 260
IF blocks(i) <> 1 THEN GOTO finished

LET counter = 0

tempb = i
DO UNTIL tempb < 1
LET tempb = tempb - 20
LET counter = counter + 1
LOOP
LET x = (counter * 2) + 28

LET y = (i - ((counter - 1) * 20))

LOCATE y, x
PRINT CHR$(219)
LOCATE y, x + 1
PRINT CHR$(219)

finished:
NEXT i

counter = 0

FOR i = 1 TO blockcount

tempb = b(i)
DO UNTIL tempb < 1
LET tempb = tempb - 20
LET counter = counter + 1
LOOP
LET x = (counter * 2) + 28

LET y = ((b(i)) - ((counter - 1) * 20))

LOCATE y, x
PRINT CHR$(219)
LOCATE y, x + 1
PRINT CHR$(219)

LET counter = 0
NEXT i

END SUB

SUB linedone

FOR i = 1 TO 13
LET x = (i * 2) + 28

COLOR 12
LOCATE t, x
PRINT CHR$(219)
LOCATE t, x + 1
PRINT CHR$(219)
NEXT i
FOR w = 1 TO 60000
NEXT w

FOR i = 1 TO 13
LET x = (i * 2) + 28

COLOR 9
LOCATE t, x
PRINT CHR$(219)
LOCATE t, x + 1
PRINT CHR$(219)
NEXT i
FOR w = 1 TO 60000
NEXT w


FOR i = 0 TO 12
LET blocks(t + (i * 20)) = 0
NEXT i

FOR i = (t - 1) TO 1 STEP -1
        FOR p = 0 TO 12
                IF blocks(i + (p * 20)) = 1 THEN
                        LET blocks(i + (p * 20)) = 0
                        LET blocks(1 + (i + (p * 20))) = 1
                END IF
        NEXT p
NEXT i

graphics

END SUB

SUB lose
PRINT "You lose!"
END
END SUB

SUB main

top:
graphics
LET time = 0

DO UNTIL time = 500
LET time = time + 1

LET y$ = INKEY$

IF y$ = l$ THEN GOTO left
IF y$ = r$ THEN GOTO right
'IF y$ = u$ THEN GOTO up
IF y$ = d$ THEN GOTO down
IF UCASE$(y$) = "Q" THEN END

IF UCASE$(y$) = "P" THEN
                DO WHILE INKEY$ = ""
                LOOP
                GOTO done
END IF

IF y$ = CHR$(32) THEN rotate: GOTO done
IF y$ = "" THEN GOTO done



left:
FOR i = 1 TO blockcount
IF b(i) - 20 < 1 THEN GOTO done
IF blocks(b(i) - 20) = 1 THEN GOTO done
NEXT i

FOR i = 1 TO blockcount
LET b(i) = b(i) - 20
NEXT i
graphics
GOTO done


right:
FOR i = 1 TO blockcount
IF b(i) + 20 > 260 THEN GOTO done
IF blocks(b(i) + 20) = 1 THEN GOTO done
NEXT i

FOR i = 1 TO blockcount
LET b(i) = b(i) + 20
NEXT i
graphics
GOTO done


down:
FOR i = 1 TO blockcount
        IF blocks(b(i) + 1) = 1 THEN GOTO done
NEXT i

FOR i = 1 TO blockcount
        IF b(i) = 20 OR b(i) = 40 OR b(i) = 60 OR b(i) = 80 OR b(i) = 100 OR b(i) = 120 OR b(i) = 140 OR b(i) = 160 OR b(i) = 180 OR b(i) = 200 OR b(i) = 260 OR b(i) = 220 OR b(i) = 240 THEN
        FOR t = 1 TO blockcount
        LET blocks(b(t)) = 1
        NEXT t
        LET abc = 1
        END IF
IF abc = 1 THEN LET abc = 0: GOTO complete
NEXT i

FOR i = 1 TO blockcount
LET b(i) = b(i) + 1
NEXT i

graphics



done:
LET time = time + 1
FOR t = 1 TO 20
        LET linefinished = 1
        FOR u = 0 TO 12
                IF blocks(t + (u * 20)) <> 1 THEN LET linefinished = 0
        NEXT u
IF linefinished = 1 THEN linedone

NEXT t
LOOP

FOR i = 1 TO blockcount
        IF (blocks(b(i) + 1) = 1) OR (b(i) = 20 OR b(i) = 40 OR b(i) = 60 OR b(i) = 80 OR b(i) = 100 OR b(i) = 120 OR b(i) = 140 OR b(i) = 160 OR b(i) = 180 OR b(i) = 200 OR b(i) = 260 OR b(i) = 220 OR b(i) = 240) THEN
                FOR t = 1 TO blockcount
                LET blocks(b(t)) = 1
                NEXT t
                GOTO complete
        END IF
NEXT i
'IF i = blockcount AND finish = 1 THEN GOTO complete

FOR i = 1 TO blockcount
LET b(i) = b(i) + 1
NEXT i

graphics
GOTO top

complete:
END SUB

'this sub chooses a block section to drop
'
SUB rand

DO

RANDOMIZE TIMER
blocknumber = INT(RND * 7) + 1

IF blocknumber = 1 THEN LET blockcount = 4: LET b(1) = 121: LET b(2) = 102: LET b(3) = 122: LET b(4) = 142:     'block = 010
                                                                                                                '        111

IF blocknumber = 2 THEN LET blockcount = 4: LET b(1) = 121: LET b(2) = 122: LET b(3) = 102: LET b(4) = 103:     'block = 010
                                                                                                                '        110
                                                                                                                '        100

IF blocknumber = 3 THEN LET blockcount = 4: LET b(1) = 121: LET b(2) = 122: LET b(3) = 142: LET b(4) = 143:     'block = 010
                                                                                                                '        011
                                                                                                                '        001

IF blocknumber = 4 THEN LET blockcount = 4: LET b(1) = 101: LET b(2) = 121: LET b(3) = 102: LET b(4) = 122:     'block = 11
                                                                                                                '        11

IF blocknumber = 5 THEN LET blockcount = 4: LET b(1) = 141: LET b(2) = 142: LET b(3) = 122: LET b(4) = 102:     'block = 001
                                                                                                                '        111

IF blocknumber = 6 THEN LET blockcount = 4: LET b(1) = 101: LET b(2) = 102: LET b(3) = 122: LET b(4) = 142:     'block = 100
                                                                                                                '        111

IF blocknumber = 7 THEN LET blockcount = 4: LET b(1) = 101: LET b(2) = 121: LET b(3) = 141: LET b(4) = 161:     'block = 1111
                                                                                                        
graphics
FOR i = 1 TO blockcount
IF blocks(b(i) + 1) = 1 THEN lose
NEXT i

LET position = 1
main

LOOP

END SUB

SUB rotate
'everything rotates clockwise
IF (b(1) = 1) - (counter - 1 * 20) = 1 THEN GOTO doner


IF blocknumber = 1 THEN
        IF position = 1 THEN
                IF blocks(b(2) - 2) = 1 OR b(2) - 2 < 1 OR (b(2) - 2) > 260 THEN GOTO doner
                IF blocks(b(3) - 21) = 1 OR b(3) - 21 < 1 OR (b(3) - 21) > 260 THEN GOTO doner
                IF blocks(b(4) - 40) = 1 OR b(4) - 40 < 1 OR (b(4) - 40) > 260 THEN GOTO doner
                LET b(2) = b(2) - 2
                LET b(3) = b(3) - 21
                LET b(4) = b(4) - 40
                LET position = 2
                GOTO doner
        END IF

        IF position = 2 THEN
                IF blocks(b(2) + 40) = 1 OR (b(2) + 40) < 1 OR (b(2) + 40) > 260 THEN GOTO doner
                IF blocks(b(3) + 19) = 1 OR (b(3) + 19) < 1 OR (b(3) + 19) > 260 THEN GOTO doner
                IF blocks(b(4) - 2) = 1 OR (b(4) - 2) < 1 OR (b(4) - 2) > 260 THEN GOTO doner
                LET b(2) = b(2) + 40
                LET b(3) = b(3) + 19
                LET b(4) = b(4) - 2
                LET position = 3
                GOTO doner
        END IF
       
        IF position = 3 THEN
                IF blocks(b(2) + 2) = 1 OR (b(2) + 2) < 1 OR (b(2) + 2) > 260 THEN GOTO doner
                IF blocks(b(3) + 21) = 1 OR (b(3) + 21) < 1 OR (b(3) + 21) > 260 THEN GOTO doner
                IF blocks(b(4) + 40) = 1 OR (b(4) + 40) < 1 OR (b(4) + 40) > 260 THEN GOTO doner
                LET b(2) = b(2) + 2
                LET b(3) = b(3) + 21
                LET b(4) = b(4) + 40
                LET position = 4
                GOTO doner
        END IF
                
        IF position = 4 THEN
                IF blocks(b(2) - 40) = 1 OR (b(2) - 40) < 1 OR (b(2) - 40) > 260 THEN GOTO doner
                IF blocks(b(3) - 19) = 1 OR (b(3) - 19) < 1 OR (b(3) - 19) > 260 THEN GOTO doner
                IF blocks(b(4) + 2) = 1 OR (b(4) + 2) < 1 OR (b(4) + 2) > 260 THEN GOTO doner
                LET b(2) = b(2) - 40
                LET b(3) = b(3) - 19
                LET b(4) = b(4) + 2
                LET position = 1
                GOTO doner
        END IF
END IF


IF blocknumber = 2 THEN
        IF position = 1 THEN
                IF blocks(b(1) + 21) = 1 OR b(1) + 21 < 1 OR b(1) + 21 > 260 THEN GOTO doner
                IF blocks(b(3) + 19) = 1 OR b(3) + 19 < 1 OR b(3) + 19 > 260 THEN GOTO doner
                IF blocks(b(4) - 2) = 1 OR b(4) - 2 < 1 OR b(4) - 2 > 260 THEN GOTO doner
                LET b(1) = b(1) + 21
                LET b(3) = b(3) + 19
                LET b(4) = b(4) - 2
                LET position = 2
                GOTO doner
        END IF
       
        IF position = 2 THEN
                IF blocks(b(1) - 21) = 1 OR b(1) - 21 < 1 OR b(1) - 21 > 260 THEN GOTO doner
                IF blocks(b(3) - 19) = 1 OR b(3) - 19 < 1 OR b(3) - 19 > 260 THEN GOTO doner
                IF blocks(b(4) + 2) = 1 OR b(4) + 2 < 1 OR b(4) + 2 > 260 THEN GOTO doner
                LET b(1) = b(1) - 21
                LET b(3) = b(3) - 19
                LET b(4) = b(4) + 2
                LET position = 1
                GOTO doner
        END IF
END IF

IF blocknumber = 3 THEN
        IF position = 1 THEN
                IF b(1) - 19 < 1 OR b(1) - 19 > 260 THEN GOTO doner
                IF b(3) - 21 < 1 OR b(3) - 21 > 260 THEN GOTO doner
                IF b(4) - 2 < 1 OR b(4) - 2 > 260 THEN GOTO doner
                IF blocks(b(1) - 19) = 1 THEN GOTO doner
                IF blocks(b(3) - 21) = 1 THEN GOTO doner
                IF blocks(b(4) - 2) = 1 THEN GOTO doner
                LET b(1) = b(1) - 19
                LET b(3) = b(3) - 21
                LET b(4) = b(4) - 2
                LET position = 2
                GOTO doner
        END IF
      
        IF position = 2 THEN
                IF b(1) + 19 < 1 OR b(1) + 19 > 260 THEN GOTO doner
                IF b(3) + 21 < 1 OR b(3) + 21 > 260 THEN GOTO doner
                IF b(4) + 2 < 1 OR b(4) + 2 > 260 THEN GOTO doner
                IF blocks(b(1) + 19) = 1 THEN GOTO doner
                IF blocks(b(3) + 21) = 1 THEN GOTO doner
                IF blocks(b(4) + 2) = 1 THEN GOTO doner
                LET b(1) = b(1) + 19
                LET b(3) = b(3) + 21
                LET b(4) = b(4) + 2
                LET position = 1
                GOTO doner
        END IF
END IF


IF blocknumber = 5 THEN
        IF position = 1 THEN
                IF b(1) + 2 < 1 OR b(1) + 2 > 260 THEN GOTO doner
                IF b(2) - 19 < 1 OR b(2) - 19 > 260 THEN GOTO doner
                IF b(4) + 19 < 1 OR b(4) + 19 > 260 THEN GOTO doner
                IF blocks(b(1) + 2) = 1 THEN GOTO doner
                IF blocks(b(2) - 19) = 1 THEN GOTO doner
                IF blocks(b(4) + 19) = 1 THEN GOTO doner
                LET b(1) = b(1) + 2
                LET b(2) = b(2) - 19
                LET b(4) = b(4) + 19
                LET position = 2
                GOTO doner
        END IF

        IF position = 2 THEN
                IF b(1) - 20 < 1 OR b(1) - 20 > 260 THEN GOTO doner
                IF b(2) - 21 < 1 OR b(2) - 21 > 260 THEN GOTO doner
                IF b(4) + 21 < 1 OR b(4) + 21 > 260 THEN GOTO doner
                IF blocks(b(1) - 20) = 1 THEN GOTO doner
                IF blocks(b(2) - 21) = 1 THEN GOTO doner
                IF blocks(b(4) + 21) = 1 THEN GOTO doner
                LET b(1) = b(2) - 20
                LET b(2) = b(2) - 21
                LET b(4) = b(4) + 21
                LET position = 3
                GOTO doner
        END IF
      
        IF position = 3 THEN
                IF b(1) - 2 < 1 OR b(1) - 2 > 260 THEN GOTO doner
                IF b(2) + 19 < 1 OR b(2) + 19 > 260 THEN GOTO doner
                IF b(2) + 19 < 1 OR b(2) + 19 > 260 THEN GOTO doner
                IF blocks(b(1) - 2) = 1 THEN GOTO doner
                IF blocks(b(2) + 19) = 1 THEN GOTO doner
                IF blocks(b(4) - 19) = 1 THEN GOTO doner
                LET b(1) = b(1) - 2
                LET b(2) = b(2) + 19
                LET b(4) = b(4) - 19
                LET position = 4
                GOTO doner
        END IF
               
        IF position = 4 THEN
                IF b(1) + 40 < 1 OR b(1) + 40 > 260 THEN GOTO doner
                IF b(2) + 21 < 1 OR b(2) + 21 > 260 THEN GOTO doner
                IF b(4) - 21 < 1 OR b(4) - 21 > 260 THEN GOTO doner
                IF blocks(b(1) + 40) = 1 THEN GOTO doner
                IF blocks(b(2) + 21) = 1 THEN GOTO doner
                IF blocks(b(4) - 21) = 1 THEN GOTO doner
                LET b(1) = b(1) + 40
                LET b(2) = b(2) + 21
                LET b(4) = b(4) - 21
                LET position = 1
                GOTO doner
        END IF
END IF

IF blocknumber = 6 THEN
        IF position = 1 THEN
                IF b(1) + 40 < 1 OR b(1) + 40 > 260 THEN GOTO doner
                IF b(2) + 19 < 1 OR b(2) + 19 > 260 THEN GOTO doner
                IF b(4) - 19 < 1 OR b(4) - 19 > 260 THEN GOTO doner
                IF blocks(b(1) + 40) = 1 THEN GOTO doner
                IF blocks(b(2) + 19) = 1 THEN GOTO doner
                IF blocks(b(4) - 19) = 1 THEN GOTO doner
                LET b(1) = b(1) + 40
                LET b(2) = b(2) + 19
                LET b(4) = b(4) - 19
                LET position = 2
                GOTO doner
        END IF

        IF position = 2 THEN
                IF b(1) + 2 < 1 OR b(1) + 2 > 260 THEN GOTO doner
                IF b(2) + 21 < 1 OR b(2) + 21 > 260 THEN GOTO doner
                IF b(4) - 21 < 1 OR b(4) - 21 > 260 THEN GOTO doner
                IF blocks(b(1) + 2) = 1 THEN GOTO doner
                IF blocks(b(2) + 21) = 1 THEN GOTO doner
                IF blocks(b(4) - 21) = 1 THEN GOTO doner
                LET b(1) = b(1) + 2
                LET b(2) = b(2) + 21
                LET b(4) = b(4) - 21
                LET position = 3
                GOTO doner
        END IF
     
        IF position = 3 THEN
                IF b(1) - 40 < 1 OR b(1) - 40 > 260 THEN GOTO doner
                IF b(2) - 19 < 1 OR b(2) - 19 > 260 THEN GOTO doner
                IF b(4) + 19 < 1 OR b(4) + 19 > 260 THEN GOTO doner
                IF blocks(b(1) - 40) = 1 THEN GOTO doner
                IF blocks(b(2) - 19) = 1 THEN GOTO doner
                IF blocks(b(4) + 19) = 1 THEN GOTO doner
                LET b(1) = b(1) - 40
                LET b(2) = b(2) - 19
                LET b(4) = b(4) + 19
                LET position = 4
                GOTO doner
        END IF
              
        IF position = 4 THEN
                IF b(1) - 2 < 1 OR b(1) - 2 > 260 THEN GOTO doner
                IF b(2) - 21 < 1 OR b(2) - 21 > 260 THEN GOTO doner
                IF b(4) + 21 < 1 OR b(4) + 21 > 260 THEN GOTO doner
                IF blocks(b(1) - 2) = 1 THEN GOTO doner
                IF blocks(b(2) - 21) = 1 THEN GOTO doner
                IF blocks(b(4) + 21) = 1 THEN GOTO doner
                LET b(1) = b(1) - 2
                LET b(2) = b(2) - 21
                LET b(4) = b(4) + 21
                LET position = 1
                GOTO doner
        END IF
END IF


IF blocknumber = 7 THEN
        IF position = 1 THEN
                IF b(1) + 19 < 1 OR b(1) + 19 > 260 THEN GOTO doner
                IF b(3) - 19 < 1 OR b(3) - 19 > 260 THEN GOTO doner
                IF b(4) - 38 < 1 OR b(4) - 38 > 260 THEN GOTO doner
                IF blocks(b(1) + 19) = 1 THEN GOTO doner
                IF blocks(b(3) - 19) = 1 THEN GOTO doner
                IF blocks(b(4) - 38) = 1 THEN GOTO doner
                LET b(1) = b(1) + 19
                LET b(3) = b(3) - 19
                LET b(4) = b(4) - 38
                LET position = 2
                GOTO doner
        END IF
     
        IF position = 2 THEN
                IF b(1) - 19 < 1 OR b(1) - 19 > 260 THEN GOTO doner
                IF b(3) + 19 < 1 OR b(3) + 19 > 260 THEN GOTO doner
                IF b(4) + 38 < 1 OR b(4) + 38 > 260 THEN GOTO doner
                IF blocks(b(1) - 19) = 1 THEN GOTO doner
                IF blocks(b(3) + 19) = 1 THEN GOTO doner
                IF blocks(b(4) + 38) = 1 THEN GOTO doner
                LET b(1) = b(1) - 19
                LET b(3) = b(3) + 19
                LET b(4) = b(4) + 38
                LET position = 1
                GOTO doner
        END IF
END IF


GOTO nographics

doner:
graphics
nographics:
END SUB

