DECLARE SUB nextblock ()
DECLARE SUB zeroblocks ()
DECLARE SUB rotategraphics ()
DECLARE SUB zerographics ()
DECLARE SUB linedone ()
DECLARE SUB rotate ()
DECLARE SUB lose ()
DECLARE SUB main ()
DECLARE SUB graphics ()
DECLARE SUB rand ()

COMMON SHARED l$, r$, u$, d$, blocktype, blockcount, time, counter, position, blocknumber, t, direction$, nextblocknumber, nextblockcount, settime, toggle, fromline
COMMON SHARED score, extra, lines
CLS
LET toggle = 1
'dimensions - 20 x 13

'This program uses a grid system that starts with 1 in the upper right hand
'corner and numbers down to 20 in the first column
'the next column would then start with block number 21, and so on, until the
'last column starts with 241 and ends with 260
'This program treats each dropping piece as four separate blocks, not as one
'uniform piece
'Rotation is put in by manually telling it how it will look after the
'rotation, not by a formula (Which would probably be better, but I didn't
'feel like changing the whole program to make it work)
'This program is written really sloppily, so good luck trying to change or add
'to it!
OPTION BASE 1

DIM SHARED blocks(290)  'blocks already on the ground
DIM SHARED b(10)  'the positions of the blocks currently dropping
DIM SHARED nb(10) 'the positions of the next block to be dropped

LET settime = 30000
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

PRINT "Press up arrow key (toggle show next block):"
DO UNTIL u$ <> ""
LET u$ = INKEY$
LOOP

CLS
RANDOMIZE TIMER
nextblocknumber = INT(RND * 7) + 1

rand

SUB graphics

COLOR 15
LOCATE 2, 4
PRINT "Score:"
LOCATE 3, 6
PRINT score
LOCATE 5, 4
PRINT "Lines:"
LOCATE 6, 6
PRINT lines
LOCATE 2, 65
PRINT "Next piece:"
LOCATE 10, 60
PRINT "Press 'P' to Pause"
LOCATE 11, 60
PRINT "Press 'Q' to Quit"





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

IF fromline = 0 THEN
FOR i = 1 TO blockcount

tempb = b(i)
DO UNTIL tempb < 1
LET tempb = tempb - 20
LET counter = counter + 1
LOOP
LET x = (counter * 2) + 28

LET y = ((b(i)) - ((counter - 1) * 20))

COLOR 15

LOCATE 1, 1
IF y < 1 OR y > 20 OR x < 1 OR x > 80 THEN PRINT y, x: END
LOCATE y, x
PRINT CHR$(219)
LOCATE y, x + 1
PRINT CHR$(219)

LET counter = 0
NEXT i
END IF
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
LET extra = extra + 1
LET score = score + 9 + extra
LET lines = lines + 1
LET settime = settime - 25
IF settime < 100 THEN LET settime = 100
zeroblocks
graphics

END SUB

SUB lose
CLS
PLAY "t200"
PLAY "<l2cl4cmll2fffl2cl4fmll2aaa"
LOCATE 1, 36
COLOR 12
FOR i = 1 TO 12
FOR t = 1 TO 10000
NEXT t
COLOR 0
IF (i * 3) - 3 > 0 THEN LOCATE i, (i * 3) - 3
IF (i * 3) - 0 < 1 THEN LOCATE i, 1
PRINT "You lost."
COLOR 12
LOCATE i + 1, (i * 3)
PRINT "You lost."
NEXT i
COLOR 0
END

END SUB

SUB main

top:
graphics
LET time = 0

DO UNTIL time = settime

LET y$ = INKEY$

IF y$ = l$ THEN GOTO left
IF y$ = r$ THEN GOTO right
IF y$ = u$ THEN
        IF toggle = 0 THEN LET toggle = 1: nextblock: GOTO done
        IF toggle = 1 THEN
                COLOR 0
                FOR n = 5 TO 7
                LOCATE n, 67
                PRINT STRING$(8, 219)
                NEXT n
                LET toggle = 0: GOTO done
        END IF
END IF

IF y$ = d$ THEN GOTO down
IF UCASE$(y$) = "Q" THEN END

IF UCASE$(y$) = "P" THEN
                DO WHILE INKEY$ = ""
                LOOP
                GOTO done
END IF

IF y$ = CHR$(32) THEN
        IF blocknumber = 4 THEN GOTO done
        rotate
        GOTO done
END IF
IF y$ = "" THEN GOTO done



left:
FOR i = 1 TO blockcount
IF b(i) - 20 < 1 THEN GOTO done
IF blocks(b(i) - 20) = 1 THEN GOTO done
NEXT i

zerographics
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

zerographics
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

zerographics
FOR i = 1 TO blockcount
LET b(i) = b(i) + 1
NEXT i
graphics



done:
LET time = time + 1
LOOP

'FOR t = 1 TO 20
'        FOR f = 0 TO 240 STEP 20
'                LET a = 0
'                IF blocks(t + f) = 0 THEN EXIT FOR
'                LET a = 1
'        NEXT f
'IF a = 1 THEN linedone: LET a = 0
'NEXT t

FOR t = 1 TO blockcount
        IF (blocks(b(t) + 1) = 1) OR (b(t) = 20 OR b(t) = 40 OR b(t) = 60 OR b(t) = 80 OR b(t) = 100 OR b(t) = 120 OR b(t) = 140 OR b(t) = 160 OR b(t) = 180 OR b(t) = 200 OR b(t) = 260 OR b(t) = 220 OR b(t) = 240) THEN
                FOR i = 1 TO blockcount
                LET blocks(b(i)) = 1
                NEXT i
                GOTO complete
        END IF
NEXT t


zerographics
FOR i = 1 TO blockcount
LET b(i) = b(i) + 1
NEXT i

graphics
GOTO top

complete:
END SUB

SUB nextblock
IF nextblocknumber = 1 THEN LET nextblockcount = 4: LET nb(1) = 121: LET nb(2) = 102: LET nb(3) = 122: LET nb(4) = 142:     'block = 010
                                                                                                                '        111

IF nextblocknumber = 2 THEN LET nextblockcount = 4: LET nb(1) = 121: LET nb(2) = 122: LET nb(3) = 102: LET nb(4) = 103:     'block = 010
                                                                                                                '        110
                                                                                                                '        100

IF nextblocknumber = 3 THEN LET nextblockcount = 4: LET nb(1) = 121: LET nb(2) = 122: LET nb(3) = 142: LET nb(4) = 143:     'block = 010
                                                                                                                '        011
                                                                                                                '        001

IF nextblocknumber = 4 THEN LET nextblockcount = 4: LET nb(1) = 101: LET nb(2) = 121: LET nb(3) = 102: LET nb(4) = 122:     'block = 11
                                                                                                                '        11

IF nextblocknumber = 5 THEN LET nextblockcount = 4: LET nb(1) = 141: LET nb(2) = 142: LET nb(3) = 122: LET nb(4) = 102:     'block = 001
                                                                                                                '        111

IF nextblocknumber = 6 THEN LET nextblockcount = 4: LET nb(1) = 101: LET nb(2) = 102: LET nb(3) = 122: LET nb(4) = 142:     'block = 100
                                                                                                                '        111

IF nextblocknumber = 7 THEN LET nextblockcount = 4: LET nb(1) = 101: LET nb(2) = 121: LET nb(3) = 141: LET nb(4) = 161:     'block = 1111

COLOR 0
FOR n = 5 TO 7
LOCATE n, 67
PRINT STRING$(8, 219)
NEXT n


FOR i = 1 TO nextblockcount
counter = 0
tempb = nb(i)
DO UNTIL tempb < 1
LET tempb = tempb - 20
LET counter = counter + 1
LOOP
LET x = (counter * 2) + 55

LET y = (nb(i) - (counter - 1) * 20) + 4

COLOR 15

LOCATE 1, 1
IF y < 1 OR y > 20 OR x < 1 OR x > 80 THEN PRINT y, x: END
LOCATE y, x
PRINT CHR$(219)
LOCATE y, x + 1
PRINT CHR$(219)

LET counter = 0
NEXT i

END SUB

'this sub chooses a block section to drop
'
SUB rand
DO
LET blocknumber = nextblocknumber

RANDOMIZE TIMER
nextblocknumber = INT(RND * 7) + 1

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
                                                                                                        
topofline:
FOR t = 1 TO 20
        FOR f = 0 TO 240 STEP 20
                LET a = 0
                IF blocks(t + f) = 0 THEN EXIT FOR
                LET a = 1
        NEXT f
IF a = 1 THEN
        LET fromline = 1
        linedone
        LET fromline = 0
        LET a = 0
        GOTO topofline
END IF
NEXT t


IF toggle = 1 THEN nextblock
graphics
FOR i = 1 TO 241 STEP 20
IF blocks(i) = 1 THEN lose
NEXT i

LET position = 1
main

LOOP

END SUB

SUB rotate
zerographics

'everything rotates clockwise
FOR t = 1 TO blockcount
IF b(t) = 20 OR b(t) = 40 OR b(t) = 60 OR b(t) = 80 OR b(t) = 100 OR b(t) = 120 OR b(t) = 140 OR b(t) = 160 OR b(t) = 180 OR b(t) = 200 OR b(t) = 220 OR b(t) = 240 OR b(t) = 260 THEN GOTO nographics
NEXT t
IF blocknumber = 4 THEN GOTO nographics

IF blocknumber = 1 THEN
        IF position = 1 THEN
                IF blocks(b(1) + 21) = 1 THEN GOTO doner
                IF blocks(b(2) + 19) = 1 THEN GOTO doner
                IF blocks(b(4) - 19) = 1 THEN GOTO doner
                LET b(1) = b(1) + 21
                LET b(2) = b(2) + 19
                LET b(4) = b(4) - 19
                LET position = 2
                GOTO doner
        END IF

        IF position = 2 THEN
                IF b(4) - 21 < 1 THEN
                        FOR g = 1 TO blockcount
                                LET b(g) = b(g) + 20
                        NEXT g
                END IF
                IF blocks(b(1) - 19) = 1 THEN GOTO doner
                IF blocks(b(2) + 21) = 1 THEN GOTO doner
                IF blocks(b(4) - 21) = 1 THEN GOTO doner
                LET b(1) = b(1) - 19
                LET b(2) = b(2) + 21
                LET b(4) = b(4) - 21
                LET position = 3
                GOTO doner
        END IF
       
        IF position = 3 THEN
                IF blocks(b(1) - 21) = 1 THEN GOTO doner
                IF blocks(b(2) - 19) = 1 THEN GOTO doner
                IF blocks(b(4) + 19) = 1 THEN GOTO doner
                LET b(1) = b(1) - 21
                LET b(2) = b(2) - 19
                LET b(4) = b(4) + 19
                LET position = 4
                GOTO doner
        END IF
                
        IF position = 4 THEN
                IF b(2) + 21 > 260 THEN
                        FOR g = 1 TO blockcount
                                LET b(g) = b(g) - 20
                        NEXT g
                END IF
                IF blocks(b(1) + 19) = 1 THEN GOTO doner
                IF blocks(b(2) - 21) = 1 THEN GOTO doner
                IF blocks(b(4) + 21) = 1 THEN GOTO doner
                LET b(1) = b(1) + 19
                LET b(2) = b(2) - 21
                LET b(4) = b(4) + 21
                LET position = 1
                GOTO doner
        END IF
END IF


IF blocknumber = 2 THEN
        IF position = 1 THEN
                IF b(1) + 21 > 260 THEN
                        FOR g = 1 TO blockcount
                                LET b(g) = b(g) - 20
                        NEXT g
                END IF
                IF blocks(b(1) + 21) = 1 THEN GOTO doner
                IF blocks(b(3) + 19) = 1 THEN GOTO doner
                IF blocks(b(4) - 2) = 1 THEN GOTO doner
                LET b(1) = b(1) + 21
                LET b(3) = b(3) + 19
                LET b(4) = b(4) - 2
                LET position = 2
                GOTO doner
        END IF
       
        IF position = 2 THEN
                IF blocks(b(1) - 21) = 1 THEN GOTO doner
                IF blocks(b(3) - 19) = 1 THEN GOTO doner
                IF blocks(b(4) + 2) = 1 THEN GOTO doner
                LET b(1) = b(1) - 21
                LET b(3) = b(3) - 19
                LET b(4) = b(4) + 2
                LET position = 1
                GOTO doner
        END IF
END IF

IF blocknumber = 3 THEN
        IF position = 1 THEN
                IF b(1) - 19 < 1 THEN
                        FOR g = 1 TO blockcount
                                LET b(g) = b(g) + 20
                        NEXT g
                END IF
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
               
                IF b(2) - 21 < 1 THEN
                        FOR g = 1 TO blockcount
                                LET b(g) = b(g) + 20
                        NEXT g
                END IF
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
               
                IF b(1) + 40 > 260 THEN
                        FOR g = 1 TO blockcount
                                LET b(g) = b(g) - 20
                        NEXT g
                END IF
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
                IF b(4) - 21 < 1 THEN
                        FOR g = 1 TO blockcount
                                LET b(g) = b(g) + 20
                        NEXT g
                END IF
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
                IF b(4) + 21 > 260 THEN
                        FOR g = 1 TO blockcount
                                LET b(g) = b(g) - 20
                        NEXT g
                END IF
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
                FOR e = 1 TO 141 STEP 20
                IF b(1) = e THEN GOTO nographics
                NEXT e
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
                IF b(4) + 38 > 260 THEN
                        FOR g = 1 TO blockcount
                                LET b(g) = b(g) - 40
                        NEXT g
                END IF
                IF b(1) - 19 < 1 THEN
                        FOR g = 1 TO blockcount
                                LET b(g) = b(g) + 20
                        NEXT g
                END IF
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

SUB zeroblocks
FOR i = 1 TO 20
        FOR u = 1 TO 27
                LOCATE i, u + 28
                COLOR 0
                PRINT CHR$(219)
        NEXT u
NEXT i
END SUB

SUB zerographics
FOR i = 1 TO blockcount

tempb = b(i)
DO UNTIL tempb < 1
LET tempb = tempb - 20
LET counter = counter + 1
LOOP
LET x = (counter * 2) + 28

LET y = ((b(i)) - ((counter - 1) * 20))

COLOR 0
        LOCATE y, x
        PRINT CHR$(219)
        LOCATE y, x + 1
        PRINT CHR$(219)

LET counter = 0
NEXT i

END SUB

