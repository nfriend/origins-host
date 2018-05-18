'This program written by Nathan Friend in March and April of 2006

'Press ALT+ENTER to switch between full screen and windowed (run full screen)
'To run this program, press SHIFT+F5
'To exit click File, Exit or press ALT and then go down to Exit
















DECLARE SUB startgame2 ()
DECLARE SUB endgame ()
DECLARE SUB highscoressub ()
DECLARE SUB controls ()
DECLARE SUB loadgame ()
DECLARE SUB savegame ()
DECLARE SUB menu ()
DECLARE SUB startgame ()
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

COMMON SHARED l$, r$, u$, d$, blocktype, blockcount, time, counter, position, blocknumber, t, direction$, nextblocknumber, nextblockcount, settime, fromline, multiplier, rotatekey$, toggle, notgame, noload, justload, fromgame, sounds, notbeenletgo
COMMON SHARED score, extra, lines

SCREEN 12
SCREEN 0
SLEEP 3

CLS
LET toggle = 1
LET sounds = 1
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
DIM SHARED saved$(125)
DIM SHARED highname$(10)
DIM SHARED highscores(10)
DIM SHARED highlines(10)

LET settime = 75000
RANDOMIZE TIMER
nextblocknumber = INT(RND * 7) + 1
startgame


controls
CLS
rand

SUB controls
CLS
LOCATE 3, 5
PRINT "Please calibrate the keys:"
LET l$ = ""
LET r$ = ""
LET d$ = ""
LET u$ = ""
LET rotatekey$ = ""
LOCATE 5, 7
PRINT "Press a key for left"
DO UNTIL l$ <> ""
LET l$ = INKEY$
LOOP
PLAY "<"
IF sounds = 1 THEN PLAY "t250l8d"
LOCATE 6, 7
PRINT "Press a key for right"
DO UNTIL r$ <> ""
LET r$ = INKEY$
LOOP
IF sounds = 1 THEN PLAY "t250l8f+"
LOCATE 7, 7
PRINT "Press a key for down"
DO UNTIL d$ <> ""
LET d$ = INKEY$
LOOP
IF sounds = 1 THEN PLAY "t250l8a"
LOCATE 8, 7
PRINT "Press a key for toggle show next block"
DO UNTIL u$ <> ""
LET u$ = INKEY$
LOOP
IF sounds = 1 THEN PLAY "t250l8>d<"
LOCATE 9, 7
PRINT "Press a key for rotate"
DO UNTIL rotatekey$ <> ""
LET rotatekey$ = INKEY$
LOOP
IF sounds = 1 THEN PLAY "t250l8>>d<"

END SUB

SUB endgame
topofend:
CLS
LOCATE 5, 5
PRINT "End Game"
LOCATE 7, 7
PRINT "(1) Cancel"
LOCATE 9, 7
PRINT "(2) Quit"
LOCATE 11, 7
PRINT "(3) New Game"
LOCATE 13, 5
PRINT "What would you like to do";
INPUT ""; ender
IF sounds = 1 THEN SOUND 880, 1
SELECT CASE ender
CASE 2
        CLS
        LOCATE 5, 5
        PRINT "Your game is not saved.  Would you like to save it now";
        INPUT saver$
        IF sounds = 1 THEN SOUND 880, 1
        IF UCASE$(MID$(saver$, 1, 1)) = "N" THEN highscoressub: END
        savegame
        IF noload = 1 THEN LET noload = 0: GOTO topofend
        highscoressub
        END
CASE 3
        CLS
        LOCATE 5, 5
        PRINT "Your game is not saved.  Would you like to save it now";
        INPUT saver$
        IF sounds = 1 THEN SOUND 880, 1
        IF UCASE$(MID$(saver$, 1, 1)) = "N" THEN GOTO startnew
        savegame
        IF noload = 1 THEN LET noload = 0: GOTO topofend
startnew:
        ERASE blocks
        ERASE b
        ERASE nb
        ERASE saved$
        LET blocktype = 0
        LET blockcount = 0
        LET time = 0
        LET counter = 0
        LET position = 0
        LET blocknumber = 0
        LET t = 0
        LET nextblocknumber = 0
        LET nextblockcount = 0
        LET settime = 0
        LET toggle = 0
        LET fromline = 0
        LET multiplier = 0
        LET score = 0
        LET extra = 0
        LET lines = 0
        LET justload = 0
        LET noload = 0
        LET fromgame = 0
        LET notgame = 0
       
        LET settime = 75000
        startgame2
       
        CLS
        RANDOMIZE TIMER
        nextblocknumber = INT(RND * 7) + 1

        rand



CASE ELSE
END SELECT
END SUB

SUB graphics
COLOR 15
LOCATE 2, 10
PRINT "Score:"
LOCATE 3, 12 - (LEN(score) / 2)
PRINT score
LOCATE 5, 10
PRINT "Lines:"
LOCATE 6, 12 - (LEN(lines) / 2)
PRINT lines
LOCATE 2, 65
PRINT "Next piece:"
LOCATE 10, 59
PRINT "Press ESCAPE to Pause"
LOCATE 12, 61
PRINT "Press 's' to Turn"
IF sounds = 1 THEN LOCATE 13, 65: PRINT "Sound Off"
IF sounds = 0 THEN LOCATE 13, 65: PRINT "Sound On "



COLOR 12
FOR r = 1 TO 20
LOCATE r, 29
PRINT CHR$(186)
NEXT r
FOR r = 1 TO 20
LOCATE r, 56
PRINT CHR$(186)
NEXT r

LOCATE 21, 29
PRINT STRING$(28, CHR$(205))
LOCATE 21, 29
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

SUB highscoressub
hightop:
CLS
IF fromgame = 1 THEN
LOCATE 2, 2
PRINT "Your score: "; score
END IF
OPEN "c:/work/nathan/qbasic~1/save/tetris/hiscores.txt" FOR INPUT AS #1

FOR i = 1 TO 10
INPUT #1, highname$(i)
INPUT #1, highscores(i)
INPUT #1, highlines(i)
NEXT i

CLOSE


IF score > highscores(10) AND fromgame = 1 THEN
        LOCATE 4, 4: PRINT "Congratulations!  You made the top 10 list!"
        LOCATE 6, 4: INPUT "Please type in your name: ", name$
        IF LEN(name$) < 0 THEN GOTO hightop
        IF LEN(name$) > 20 THEN
                PRINT "Your name cannot exceed 20 characters."
                PRINT "Press any key to continue..."
                DO WHILE INKEY$ = ""
                LOOP
                GOTO hightop
        END IF
            
       
        FOR i = 10 TO 1 STEP -1
        IF i = 1 THEN LET highscores(i) = score: LET highname$(i) = name$: LET highlines(i) = lines
        IF i <> 1 THEN
                IF score > highscores(i) THEN LET highscores(i) = highscores(i - 1): LET highname$(i) = highname$(i - 1): LET highlines(i) = highlines(i - 1)
                
        END IF
        IF score < highscores(i) THEN LET highscores(i) = score: LET highname$(i) = name$: LET highlines(i) = lines: EXIT FOR
        NEXT i
       
        OPEN "c:/work/nathan/qbasic~1/save/tetris/hiscores.txt" FOR OUTPUT AS #1
        FOR y = 1 TO 10
        PRINT #1, highname$(y)
        PRINT #1, highscores(y)
        PRINT #1, highlines(y)
        NEXT y
END IF

LOCATE 8, 10
PRINT "NAME:"
LOCATE 8, 32
PRINT "SCORE:"
LOCATE 8, 54
PRINT "LINES:"

LET k = 0
FOR e = 10 TO 19
LET k = k + 1
LOCATE e, 10
PRINT STRING$(46, ".")
LOCATE e, 10
PRINT highname$(k)
LOCATE e, 32
PRINT highscores(k)
LOCATE e, 54
PRINT highlines(k)
NEXT e

LET fromgame = 0
END SUB

SUB linedone

IF (lines + 1) / 1000 = CINT(lines / 1000) AND sounds = 1 THEN PLAY "t250l8<df+a>df+a>d<": GOTO sounddone
IF (lines + 1) / 100 = CINT(lines / 100) AND sounds = 1 THEN PLAY "t250l8df+a>d<": GOTO sounddone
IF (lines + 1) / 10 = CINT(lines / 10) AND sounds = 1 THEN PLAY "t250l8df+a": GOTO sounddone
IF sounds = 1 THEN PLAY "t250l8df+"
sounddone:

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
LET score = score + ((9 + extra) * multiplier)
LET lines = lines + 1
LET settime = settime - 500
IF settime < 8500 THEN LET settime = 8500
zeroblocks
graphics
rr$ = INKEY$
END SUB

SUB loadgame
printtop:
CLS
LOCATE 2, 2
PRINT "Here are a list of games:"
OPEN "c:/work/nathan/qbasic~1/save/tetris/ttrsnams.txt" FOR INPUT AS #1

LET u = 0
DO UNTIL EOF(1)
LET u = u + 1
INPUT #1, saved$(u)
LOOP
CLOSE

LET column = 3
t = 1
DO UNTIL saved$(t) = ""

        LET column = column + 1

        FOR i = 4 TO 64 STEP 10
                LOCATE column, i
                PRINT saved$(t)
                t = t + 1
        NEXT i

LOOP

LOCATE column + 2, 2
INPUT "Which game would you like to open? (type in 'cancel' to cancel)  ", whichgame$
IF sounds = 1 THEN SOUND 880, 1
IF UCASE$(whichgame$) = "CANCEL" THEN LET noload = 1: GOTO endload

t = 1
DO UNTIL saved$(t) = ""
IF UCASE$(whichgame$) = saved$(t) THEN GOTO checkedout
LET t = t + 1
LOOP

LOCATE column + 4, 4
PRINT "Sorry, but there is no game called '"; whichgame$; "'."
LOCATE column + 5, 4
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
IF sounds = 1 THEN SOUND 880, 0
GOTO printtop

checkedout:
OPEN "c:/work/nathan/qbasic~1/save/tetris/" + whichgame$ + ".txt" FOR INPUT AS #1




FOR i = 1 TO 260
INPUT #1, blocks(i)
NEXT i

INPUT #1, blockcount

FOR i = 1 TO blockcount
INPUT #1, b(i)
NEXT i

INPUT #1, score
INPUT #1, extra
INPUT #1, lines
INPUT #1, settime
INPUT #1, time
INPUT #1, position
INPUT #1, blockcount
INPUT #1, blocknumber
INPUT #1, nextblockcount
INPUT #1, nextblocknumber

CLOSE
endload:
CLS
LET justload = 1
END SUB

SUB lose
CLS
PLAY "t200"
PLAY "<l2cl4cmll2fffl2cl4fmll2aaa>"
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
SLEEP 2
COLOR 15
LOCATE 15, 26
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
LET fromgame = 1
highscoressub

LOCATE 22, 5
INPUT "Would you like to play again?  ", playagain$

IF UCASE$(MID$(playagain$, 1, 1)) = "N" THEN END

ready:

ERASE blocks
ERASE b
ERASE nb
ERASE saved$
LET blocktype = 0
LET blockcount = 0
LET time = 0
LET counter = 0
LET position = 0
LET blocknumber = 0
LET t = 0
LET nextblocknumber = 0
LET nextblockcount = 0
LET settime = 0
LET toggle = 0
LET fromline = 0
LET multiplier = 0
LET score = 0
LET extra = 0
LET lines = 0
LET justload = 0
LET noload = 0
LET fromgame = 0
LET notgame = 0

LET settime = 75000
RANDOMIZE TIMER
nextblocknumber = INT(RND * 7) + 1
startgame2


CLS
rand

END SUB

SUB main

top:
graphics
LET time = 0

DO UNTIL time = settime
LET y$ = INKEY$

IF y$ = d$ AND notbeenletgo = 1 THEN GOTO done
LET notbeenletgo = 0

IF y$ = l$ THEN GOTO left
IF y$ = r$ THEN GOTO right
IF UCASE$(y$) = "S" THEN
        
        IF sounds = 1 THEN LOCATE 13, 65: PRINT "Sound On ": LET sounds = 0: GOTO done
        IF sounds = 0 THEN LOCATE 13, 65: PRINT "Sound Off": LET sounds = 1: GOTO done
END IF

IF y$ = u$ THEN
        IF toggle = 0 THEN LET toggle = 1: nextblock: IF sounds = 1 THEN PLAY "<t250l32g>": GOTO done
        IF toggle = 1 THEN
                COLOR 0
                FOR n = 5 TO 7
                LOCATE n, 67
                PRINT STRING$(8, 219)
                NEXT n
                LET toggle = 0
                PLAY "<t250l32g>"
                GOTO done
        END IF
END IF

IF y$ = d$ THEN GOTO down
IF y$ = CHR$(27) THEN menu: graphics
IF y$ = rotatekey$ THEN
        IF blocknumber = 4 THEN GOTO done
        rotate
        IF sounds = 1 THEN PLAY "<t250l32a>"
        GOTO done
END IF

IF UCASE$(y$) <> "S" AND y$ <> l$ AND y$ <> r$ AND y$ <> d$ AND y$ <> u$ AND y$ <> CHR$(27) AND y$ <> rotatekey$ THEN GOTO done



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
IF sounds = 1 THEN PLAY "<t250l32c>"
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
IF sounds = 1 THEN PLAY "<t250l32e>"
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
IF sounds = 1 THEN PLAY "<t250l32f+>"


done:
LET time = time + 1
LOOP



FOR t = 1 TO blockcount
        IF (blocks(b(t) + 1) = 1) OR (b(t) = 20 OR b(t) = 40 OR b(t) = 60 OR b(t) = 80 OR b(t) = 100 OR b(t) = 120 OR b(t) = 140 OR b(t) = 160 OR b(t) = 180 OR b(t) = 200 OR b(t) = 260 OR b(t) = 220 OR b(t) = 240) THEN
                FOR i = 1 TO blockcount
                LET blocks(b(i)) = 1
                NEXT i
                GOTO complete
        END IF
NEXT t
IF sounds = 1 THEN PLAY "<t250l32d>"
zerographics
FOR i = 1 TO blockcount
LET b(i) = b(i) + 1
NEXT i

graphics
GOTO top

complete:
END SUB

SUB menu
menutop:
CLS
LOCATE 2, 5
PRINT "Game Paused"
LOCATE 5, 7
PRINT "(1) Continue"
LOCATE 7, 7
PRINT "(2) End Game"
LOCATE 9, 7
PRINT "(3) Save Game"
LOCATE 11, 7
PRINT "(4) Load Game"
LOCATE 13, 7
PRINT "(5) Redefine Keys"
IF sounds = 0 THEN LOCATE 15, 7: PRINT "(6) Turn Sound On "
IF sounds = 1 THEN LOCATE 15, 7: PRINT "(6) Turn Sound Off"
LOCATE 17, 5
PRINT "What would you like to do";
INPUT ""; nowhat
IF sounds = 1 AND nowhat <> 6 THEN SOUND 880, 1
IF sounds = 0 AND nowhat = 6 THEN SOUND 880, 1
SELECT CASE nowhat
CASE 1
        GOTO menudone
CASE 2
        endgame
        GOTO menutop
CASE 3
        savegame
GOTO menutop
CASE 4
        loadgame
GOTO menutop
CASE 5
        controls
GOTO menutop
CASE 6
        IF sounds = 1 THEN LOCATE 19, 15: PRINT "Sounds Off": SLEEP 1: LET sounds = 0: GOTO menutop
        IF sounds = 0 THEN LOCATE 19, 15: PRINT "Sounds On": SLEEP 1: LET sounds = 1: GOTO menutop

CASE ELSE
        GOTO menutop

END SELECT

menudone:
CLS
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
IF justload = 1 THEN LET justload = 0: GOTO skip
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
                                                                                                       
skip:
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
        LET multiplier = multiplier + 1
        GOTO topofline
END IF
LET time = 0
NEXT t
IF multiplier = 0 AND sounds = 1 THEN PLAY "<<<t250l64dd-cd-dd-cd-d>>>"
LET multiplier = 0

IF toggle = 1 THEN nextblock
graphics
FOR i = 1 TO 241 STEP 20
IF blocks(i) = 1 THEN lose
NEXT i

LET position = 1
IF INKEY$ = d$ THEN LET notbeenletgo = 1
main

LOOP

END SUB

SUB rotate
zerographics

'everything rotates clockwise
'FOR t = 1 TO blockcount
'IF b(t) = 20 OR b(t) = 40 OR b(t) = 60 OR b(t) = 80 OR b(t) = 100 OR b(t) = 120 OR b(t) = 140 OR b(t) = 160 OR b(t) = 180 OR b(t) = 200 OR b(t) = 220 OR b(t) = 240 OR b(t) = 260 THEN GOTO nographics
'NEXT t

IF blocknumber = 4 THEN GOTO nographics

IF blocknumber = 1 THEN
        IF position = 1 THEN
                FOR t = 20 TO 260 STEP 20
                IF b(3) = t THEN GOTO doner
                NEXT t
                IF b(1) - ((counter - 1) * 20) = 1 THEN GOTO doner
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
                FOR t = 20 TO 260 STEP 20
                IF b(2) = t THEN GOTO doner
                NEXT t
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
                FOR t = 20 TO 260 STEP 20
                IF b(2) = t THEN GOTO doner
                NEXT t
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
                FOR t = 20 TO 260 STEP 20
                IF b(3) = t THEN GOTO doner
                NEXT t
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
                FOR t = 20 TO 260 STEP 20
                IF b(3) = t THEN GOTO doner
                NEXT t
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
        FOR t = 1 TO 241 STEP 20
                IF b(2) = t THEN GOTO doner
        NEXT t
        FOR t = 19 TO 259 STEP 20
                IF b(2) = t THEN GOTO doner
        NEXT t
        FOR t = 20 TO 260 STEP 20
                IF b(2) = t THEN GOTO doner
        NEXT t
        IF position = 1 THEN
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

SUB savegame
savetop:
CLOSE
CLS
LOCATE 3, 2
PRINT "(Type in 'back' to go back to the menu)"
LOCATE 2, 2
INPUT "Please type in a name for your game:  ", gamename$
IF sounds = 1 THEN SOUND 880, 1
IF UCASE$(gamename$) = "CANCEL" THEN
        SOUND 440, 3
        SOUND 880, 1
        LOCATE 4, 4
        PRINT "     Wow!  You just typed in the only word in the whole English language        (except, of course, for any words that are more than 8 letters) that is not     allowed to be a name of a game.  You see, I use the word 'cancel' in the        loadgame sub so that if anyone needs to cancel (because they either didn't want to load a new game or decided that there wasn't any game that they had saved    previously and they didn't really feel like opening up"
        LOCATE 9, 56
        PRINT "someone else's file because they might mess something up and then that person   would get angered and so on... you know how it goes)  they can get out of the   loadgame screen.  So, if you saved a game called 'cancel' then the computer     (they aren't to bright) would think that you actually don't want to load a game instead of trying to load the game called 'cancel.'  Even if you could load the game named 'cancel,' people would never be able to exit out of the loadgame     screen because then everytime"
        LOCATE 15, 31
        PRINT "someone wanted to get out of the loadgame screen, they would accidentally load  your game that you had named 'cancel,' messing you up completely and ruining    your game."
        PRINT
        PRINT "So, basically don't name your game 'cancel.'"
        PRINT
        PRINT "Press any key to continue...  (Wow, I just spent way to much time on that)"
        DO WHILE INKEY$ = ""
        LOOP
        GOTO savetop
END IF
IF UCASE$(gamename$) = "BACK" THEN LET noload = 1: GOTO endsave
IF LEN(gamename$) < 1 OR LEN(gamename$) > 8 THEN
        LOCATE 4, 4
        PRINT "Sorry, but your name must be no less than 1 character long and no longer than"
        LOCATE 5, 4
        PRINT "8 characters."
        LOCATE 7, 4
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        GOTO savetop
END IF

OPEN "c:/work/nathan/qbasic~1/save/tetris/ttrsnams.txt" FOR INPUT AS #1
LET gamename$ = UCASE$(gamename$)
DO UNTIL EOF(1)
INPUT #1, a$
IF gamename$ = a$ THEN
        LOCATE 5, 4
        PRINT gamename$; " is already a saved game.  Overwrite";
        INPUT overwrite$
        IF sounds = 1 THEN SOUND 880, 1
        IF UCASE$(MID$(overwrite$, 1, 1)) = "Y" THEN LET overwrite = 1
        IF UCASE$(MID$(overwrite$, 1, 1)) = "N" THEN GOTO savetop
END IF
IF overwrite = 1 THEN CLS : EXIT DO
LOOP

CLOSE

IF overwrite = 1 THEN GOTO endofname

OPEN "c:/work/nathan/qbasic~1/save/tetris/ttrsnams.txt" FOR APPEND AS #1
PRINT #1, gamename$
CLOSE

endofname:

OPEN "c:/work/nathan/qbasic~1/save/tetris/" + gamename$ + ".txt" FOR OUTPUT AS #1

FOR i = 1 TO 260
PRINT #1, blocks(i)
NEXT i

PRINT #1, blockcount

FOR i = 1 TO blockcount
PRINT #1, b(i)
NEXT i

PRINT #1, score
PRINT #1, extra
PRINT #1, lines
PRINT #1, settime
PRINT #1, time
PRINT #1, position
PRINT #1, blockcount
PRINT #1, blocknumber
PRINT #1, nextblockcount
PRINT #1, nextblocknumber

CLOSE
LOCATE 5, 5
PRINT "Game saved"
SLEEP 2
endsave:
CLS
END SUB

SUB startgame

CLS

LET music1$ = "mbmst200l4c<l8ga-l8b-l16>c<b-l8a-g"
LET music2$ = "l4fp32l8fa-l4>c<"
LET music3$ = "l8b-a-l4gp32l8ga-l4b->c<a-fl2fp16"

PLAY music1$
PLAY music2$
PLAY music3$

COLOR 12

LOCATE 13, 1
PRINT "!"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 1
PRINT "S!"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 1
PRINT "IS!"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 1
PRINT "RIS!"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 1
PRINT "TRIS!"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 1
PRINT "ETRIS!"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 1
PRINT "TETRIS!"
FOR d = 1 TO 10000
NEXT d

FOR i = 1 TO 36
LOCATE 13, i
PRINT " TETRIS!"
FOR d = 1 TO 10000
NEXT d
NEXT i

FOR ii = 1 TO 300000
NEXT ii

COLOR 9
LOCATE 13, i
PRINT "TETRIS!"

FOR ii = 1 TO 300000
NEXT ii


FOR i = 36 TO 73
LOCATE 13, i
PRINT " TETRIS!"
FOR d = 1 TO 10000
NEXT d
NEXT i

LOCATE 13, 74
PRINT " TETRIS"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 75
PRINT " TETRI"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 76
PRINT " TETR"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 77
PRINT " TET"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 78
PRINT " TE"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 79
PRINT " T"
FOR d = 1 TO 10000
NEXT d

LOCATE 13, 80
PRINT " "
FOR d = 1 TO 12000
NEXT d

COLOR 15
LOCATE 13, 36
PRINT "TETRIS!"
FOR d = 1 TO 90000
NEXT d
COLOR 0
LOCATE 13, 36
PRINT "TETRIS!"
FOR d = 1 TO 85000
NEXT d
COLOR 15
LOCATE 13, 36
PRINT "TETRIS!"
FOR d = 1 TO 270000
NEXT d

asktop:
CLS
LOCATE 3, 10
PRINT "Welcome to"; : COLOR 12: PRINT " Tetris"; : COLOR 15: PRINT "!"
LOCATE 5, 13
PRINT "(1) Start a New Game"
LOCATE 6, 13
PRINT "(2) Load a Game"
LOCATE 7, 13
PRINT "(3) View the Highscores"
LOCATE 8, 13
IF sounds = 0 THEN LOCATE 8, 13: PRINT "(4) Turn Sound On "
IF sounds = 1 THEN LOCATE 8, 13: PRINT "(4) Turn Sound Off"
LOCATE 9, 13
PRINT "(5) Exit"
LOCATE 11, 10
PRINT "What would you like to do?  ";
INPUT "", choice
IF sounds = 0 AND choice = 4 THEN SOUND 880, 1
IF sounds = 1 AND choice <> 4 THEN SOUND 880, 1
IF choice < 1 OR choice > 5 THEN GOTO asktop

SELECT CASE choice
CASE 1
        CLS
        GOTO ends
CASE 2
        LET noload = 0
        loadgame
        IF noload = 1 THEN GOTO asktop
        menu
CASE 3
        LET notgame = 1
        highscoressub
        LET notgame = 0
        LOCATE 22, 5
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        IF sounds = 1 THEN SOUND 880, 1
        CLS
        GOTO asktop
CASE 4
        IF sounds = 1 THEN LOCATE 13, 15: PRINT "Sounds Off": SLEEP 1: LET sounds = 0: GOTO asktop
        IF sounds = 0 THEN LOCATE 13, 15: PRINT "Sounds On": SLEEP 1: LET sounds = 1: GOTO asktop
CASE 5
        LET notgame = 1
        highscoressub
        END
END SELECT


ends:
END SUB

SUB startgame2
asktop2:
CLS
LOCATE 3, 10
PRINT "Welcome to"; : COLOR 12: PRINT " Tetris"; : COLOR 15: PRINT "!"
LOCATE 5, 13
PRINT "(1) Start a New Game"
LOCATE 6, 13
PRINT "(2) Load a Game"
LOCATE 7, 13
PRINT "(3) View the Highscores"
LOCATE 8, 13
IF sounds = 0 THEN LOCATE 8, 13: PRINT "(4) Turn Sound On "
IF sounds = 1 THEN LOCATE 8, 13: PRINT "(4) Turn Sound Off"
LOCATE 9, 13
PRINT "(5) Exit"
LOCATE 11, 10
PRINT "What would you like to do";
INPUT ""; choice
IF choice < 1 OR choice > 5 THEN GOTO asktop2
IF sounds = 0 AND choice = 4 THEN SOUND 880, 1
IF sounds = 1 AND choice <> 4 THEN SOUND 880, 1
SELECT CASE choice
CASE 1
        CLS
        GOTO ends2
CASE 2
        loadgame
        menu
CASE 3
        LET notgame = 1
        highscoressub
        LET notgame = 0
        LOCATE 22, 5
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        CLS
        GOTO asktop2
CASE 4
        IF sounds = 1 THEN LOCATE 13, 15: PRINT "Sounds Off": SLEEP 1: LET sounds = 0: GOTO asktop2
        IF sounds = 0 THEN LOCATE 13, 15: PRINT "Sounds On": SLEEP 1: LET sounds = 1: GOTO asktop2
CASE 5
        LET notgame = 1
        highscoressub
        END
END SELECT


ends2:

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

