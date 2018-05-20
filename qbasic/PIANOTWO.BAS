'Press SHIFT + F5 to start this program

'This program was created to help with note recognition for the piano
'Created by Nathan Friend in July of 2005

                 
















DECLARE SUB pmissed ()
DECLARE SUB problem ()
DECLARE SUB pwrong ()
DECLARE SUB pright ()
DECLARE SUB high ()
DECLARE SUB makeclefs ()
DECLARE SUB quiz ()
COMMON SHARED number, clefs, time, clef, position, wrong, right, missed, percent, realnote$
DIM SHARED trebleposition(17)
DIM SHARED bassposition(20)
CLS
SCREEN 1
SLEEP 2



LOCATE 5, 5
COLOR 15, 0
PRINT "Welcome to PianoHelp V.II"
' plays piano music

PLAY "t150"
PLAY "l8"
PLAY "ML"

PLAY "f < d b- < b- > d b- < < b- > > d b- > f < d b- >"
PLAY "g < e- b- a- e- b- g e- b- > g < e- b-"
PLAY "> c < e- a g- e- a f e- a > c < e- a"
PLAY "> d < f b- < b- > f b- < < b- > > f b- > d < f b-"

asktop:
CLS
LOCATE 4, 5
PRINT "Difficulty?"
LOCATE 6, 8
PRINT "1) Easy   (10 seconds to answer)"
LOCATE 7, 8
PRINT "2) Medium (4 seconds to answer)"
LOCATE 8, 8
PRINT "3) Hard   (2 seconds to answer)"
LOCATE 10, 8
INPUT "", dif$

SELECT CASE dif$
CASE "1"
LET time = 10
CASE "2"
LET time = 4
CASE "3"
LET time = 2
CASE ELSE
GOTO asktop
END SELECT

cleftop:
CLS
LOCATE 2, 1
PRINT "Over what would you liked to be quizzed?"
LOCATE 4, 4
PRINT "1) Bass Clef"
LOCATE 5, 4
PRINT "2) Treble Clef"
LOCATE 6, 4
PRINT "3) Both Clefs"
LOCATE 8, 4
INPUT "", clefs

IF clefs < 1 OR clefs > 3 THEN GOTO cleftop

numbertop:
CLS
LOCATE 5, 5
INPUT "Number of questions?  ", number

CLS
LOCATE 2, 2
PRINT "Directions:"
LOCATE 4, 4
PRINT "  A note will appear on the staff.  You  must type in the correct note within    your time limit."
LOCATE 8, 4
PRINT "Press any key to continue..."

DO WHILE INKEY$ = ""
LOOP

CLS
quizhere:
quiz

endtop:
LOCATE 2, 2
PRINT "What would you like to do?"
LOCATE 4, 4
PRINT "1) Exit"
LOCATE 5, 4
PRINT "2) Take a different test"
LOCATE 6, 4
PRINT "3) Try the test again"
LOCATE 8, 4
INPUT "", enda$

SELECT CASE enda$

CASE "1"
        END

CASE "2"
        right = 0
        missed = 0
        tempnumber = 0
        GOTO asktop

CASE "3"
        right = 0
        missed = 0
        tempnumber = 0
        CLS
        GOTO quizhere

CASE ELSE
        GOTO endtop

END SELECT

SUB high

DIM highscores(11)
DIM highname$(11)

LOCATE 2, 2
IF time = 10 THEN LET hardness = 1
IF time = 4 THEN LET hardness = 2
IF time = 2 THEN LET hardness = 3
score = (right - missed - wrong) * hardness
PRINT "Your score: "; score
CLOSE
OPEN "./musichi/phiscres.txt" FOR INPUT AS #1

FOR i = 1 TO 9
        INPUT #1, highname$(i)
        INPUT #1, highscores(i)
NEXT i

INPUT #1, highname$(10)
INPUT #1, highscores(10)

IF score > highscores(10) THEN GOTO madehiscore


GOTO printhi


madehiscore:

LOCATE 4, 4
PRINT "You made the high score!"
LOCATE 5, 4
INPUT "Please type in your name: ", name$

CLOSE
OPEN "./musichi/phiscres.txt" FOR OUTPUT AS #1
u = 1
DO UNTIL highscores(u) < score
PRINT #1, highname$(u)
PRINT #1, highscores(u)
LET u = u + 1
LOOP

PRINT #1, name$
PRINT #1, score

DO UNTIL u = 10
PRINT #1, highname$(u)
PRINT #1, highscores(u)
u = u + 1
LOOP

printhi:
CLOSE

OPEN "./musichi/phiscres.txt" FOR INPUT AS #1

y = 12

LOCATE 8, 10: PRINT "HIGHSCORES:"
LOCATE 9, 10: PRINT STRING$(11, CHR$(205)) 'or 240

FOR i = 1 TO 10
        LOCATE y, 1
        PRINT y - 11
        IF y - 11 < 10 THEN LOCATE y, 3: PRINT "."
        IF y - 11 = 10 THEN LOCATE y, 4: PRINT "."
        LOCATE y, 6
        PRINT STRING$(20, ".")
        INPUT #1, a$
        LOCATE y, 6
        PRINT a$;
        LOCATE y, 26
        INPUT #1, a
        PRINT a
        y = y + 1
NEXT i


CLOSE


LOCATE 23, 2
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS

END SUB

SUB makeclefs
'lines
LINE (25, 63)-(150, 63)
LINE (25, 76)-(150, 76)
LINE (25, 89)-(150, 89)
LINE (25, 102)-(150, 102)
LINE (25, 115)-(150, 115)

IF clef = 1 THEN GOTO bass
IF clef = 2 THEN GOTO treble

treble:
LINE (55, 65)-(35, 86)
LINE (35, 86)-(30, 96)
LINE (30, 96)-(32, 106)
LINE (32, 106)-(40, 112)
LINE (40, 112)-(48, 115)
LINE (48, 115)-(58, 113)
LINE (58, 113)-(65, 100)
LINE (65, 100)-(58, 90)
LINE (58, 90)-(48, 90)
LINE (48, 90)-(41, 98)
LINE (41, 98)-(43, 103)
LINE (43, 103)-(46, 105)
LINE (55, 65)-(57, 55)
LINE (57, 55)-(54, 48)
LINE (54, 48)-(48, 51)
LINE (48, 51)-(44, 57)
LINE (44, 57)-(57, 125)
LINE (57, 125)-(54, 127)
LINE (54, 127)-(46, 128)
CIRCLE (43, 125), 4
PAINT (43, 125), 15
GOTO done

bass:
CIRCLE (37, 76), 5
PAINT (37, 75), 15
PAINT (37, 77), 15
LINE (33, 73)-(40, 67)
LINE (40, 67)-(50, 63)
LINE (50, 63)-(62, 68)
LINE (62, 68)-(67, 80)
LINE (67, 80)-(59, 100)
LINE (59, 100)-(33, 112)
CIRCLE (73, 69), 2
CIRCLE (73, 83), 2
PAINT (73, 69), 15
PAINT (73, 83), 15
GOTO done


done:
END SUB

SUB pmissed
LINE (210, 98)-(270, 102), , BF
LOCATE 19, 31
PRINT realnote$
FOR i = 1 TO 400000
LET y$ = INKEY$
NEXT i
END SUB

SUB pright
FOR i = 25 TO 30
CIRCLE (240, 100), i, 10
NEXT i
FOR i = 1 TO 400000
LET y$ = INKEY$
NEXT i
END SUB

SUB problem
CLS
LOCATE 2, 2
PRINT "Problem notes:"

temp = 0
DO UNTIL temp = 20
LET temp = temp + 1
IF bassposition(temp) >= 2 THEN LET review = review + 1: LET bass = bass + 1
LOOP


temp = 0
DO UNTIL temp = 17
LET temp = temp + 1
IF trebleposition(temp) >= 2 THEN LET review = review + 1: LET treble = treble + 1
LOOP

IF review = 0 THEN LOCATE 5, 5: PRINT "There are no problem notes.": GOTO endofproblem

ff = 0
IF bass >= 1 THEN
       
        LET clef = 1
        DO UNTIL bass = 0
        CLS
LOCATE 2, 2
PRINT "Problem notes:"
       
        LET bass = bass - 1
                LET ff = ff + 1
                DO UNTIL bassposition(ff) > 1
                ff = ff + 1
                LOOP
        LET position = ff
        LET place = 141
      
        LET f = 0
        DO UNTIL f = position
                f = f + 1
                LET place = place - 6.5
        LOOP
       
        makeclefs
       
        position = position + 1
        IF position = 1 THEN LINE (120, 141)-(140, 141): LINE (120, 128)-(140, 128)
        IF position = 3 OR position = 2 THEN LINE (120, 128)-(140, 128)
        IF position > 14 THEN LINE (120, 50)-(140, 50)
        IF position > 16 THEN LINE (120, 37)-(140, 37)
        IF position > 18 THEN LINE (120, 24)-(140, 24)
        position = position - 1
       
        CIRCLE (130, place), 6
        PAINT (130, place + 2), 15
        PAINT (130, place - 2), 15
       
                position = position + 1
                IF position = 1 OR position = 8 OR position = 15 THEN LET realnote$ = "C"
                IF position = 2 OR position = 9 OR position = 16 THEN LET realnote$ = "D"
                IF position = 3 OR position = 10 OR position = 17 THEN LET realnote$ = "E"
                IF position = 4 OR position = 11 OR position = 18 THEN LET realnote$ = "F"
                IF position = 5 OR position = 12 OR position = 19 THEN LET realnote$ = "G"
                IF position = 6 OR position = 13 OR position = 20 THEN LET realnote$ = "A"
                IF position = 7 OR position = 14 THEN LET realnote$ = "B"
       
        LOCATE 10, 32
        PRINT realnote$
        FOR i = 1 TO 2000000
        NEXT i
LOOP
END IF


ff = 1
IF treble >= 1 THEN

LOCATE 2, 2
PRINT "Problem notes:"
       
        LET clef = 2
        DO UNTIL treble = 0
        CLS
LOCATE 2, 2
PRINT "Problem notes:"
       
        LET treble = treble - 1
                LET ff = ff + 1
                DO UNTIL trebleposition(ff) > 1
                ff = ff + 1
                LOOP
        LET position = ff
        LET place = 141
    
        LET f = 0
        DO UNTIL f = position
                f = f + 1
                LET place = place - 6.5
        LOOP
     
        makeclefs
     
        position = position + 1
        IF position = 1 THEN LINE (120, 141)-(140, 141): LINE (120, 128)-(140, 128)
        IF position = 3 OR position = 2 THEN LINE (120, 128)-(140, 128)
        IF position > 14 THEN LINE (120, 50)-(140, 50)
        IF position > 16 THEN LINE (120, 37)-(140, 37)
        IF position > 18 THEN LINE (120, 24)-(140, 24)
        position = position - 1
     
        CIRCLE (130, place), 6
        PAINT (130, place + 2), 15
        PAINT (130, place - 2), 15
     
                position = position + 1
                IF position = 5 OR position = 12 THEN LET realnote$ = "E"
                IF position = 6 OR position = 13 THEN LET realnote$ = "F"
                IF position = 7 OR position = 14 THEN LET realnote$ = "G"
                IF position = 8 OR position = 15 THEN LET realnote$ = "A"
                IF position = 9 OR position = 16 THEN LET realnote$ = "B"
                IF position = 10 OR position = 17 THEN LET realnote$ = "C"
                IF position = 11 OR position = 18 THEN LET realnote$ = "D"
           
        LOCATE 10, 32
        PRINT realnote$
        FOR i = 1 TO 2000000
        NEXT i
LOOP
END IF


endofproblem:
LOCATE 23, 2
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS

END SUB

SUB pwrong
FOR i = 73 TO 77
LET y = i + 50
LINE (210, i)-(270, y)
LINE (270, i)-(210, y)
NEXT i
LOCATE 19, 31
PRINT realnote$
FOR i = 1 TO 400000
LET y$ = INKEY$
NEXT i
END SUB

SUB quiz
LOCATE 11, 17
PRINT "Ready!"
SLEEP 1
LOCATE 12, 18
PRINT "Set!"
SLEEP 1
LOCATE 13, 18
PRINT "GO!!"
SLEEP 1



DO UNTIL tempnumber = number
        IF tempnumber > number THEN EXIT DO
        LET tempnumber = tempnumber + 1
CLS
randagain:
       
        RANDOMIZE TIMER
        LET clef = INT(RND * 2) + 1
        
        IF clefs = 1 THEN LET clef = 1
        IF clefs = 2 THEN LET clef = 2
       
        makeclefs

        IF clef = 1 THEN
                RANDOMIZE TIMER
                LET note = INT(RND * 17) + 1 ' lowest is C String
                LET position = note
       
                IF position = 1 OR position = 8 OR position = 15 THEN LET realnote$ = "C"
                IF position = 2 OR position = 9 OR position = 16 THEN LET realnote$ = "D"
                IF position = 3 OR position = 10 OR position = 17 THEN LET realnote$ = "E"
                IF position = 4 OR position = 11 OR position = 18 THEN LET realnote$ = "F"
                IF position = 5 OR position = 12 OR position = 19 THEN LET realnote$ = "G"
                IF position = 6 OR position = 13 OR position = 20 THEN LET realnote$ = "A"
                IF position = 7 OR position = 14 THEN LET realnote$ = "B"
               
        END IF
        IF clef = 2 THEN
                RANDOMIZE TIMER
                LET note = INT(RND * 17) + 1 ' lowest is the 1st E on A string
                LET position = note
       
                IF position = 5 OR position = 12 THEN LET realnote$ = "E"
                IF position = 6 OR position = 13 THEN LET realnote$ = "F"
                IF position = 7 OR position = 14 THEN LET realnote$ = "G"
                IF position = 1 OR position = 8 OR position = 15 THEN LET realnote$ = "A"
                IF position = 2 OR position = 9 OR position = 16 THEN LET realnote$ = "B"
                IF position = 3 OR position = 10 OR position = 17 THEN LET realnote$ = "C"
                IF position = 4 OR position = 11 OR position = 18 THEN LET realnote$ = "D"
       
        END IF

       
                LET position = position - 1
       
        LET place = 141
       
        LET f = 0
        DO UNTIL f = position
                f = f + 1
                LET place = place - 6.5
        LOOP

        position = position + 1
        IF position = 1 THEN LINE (120, 141)-(140, 141): LINE (120, 128)-(140, 128)
        IF position = 3 OR position = 2 THEN LINE (120, 128)-(140, 128)
        IF position > 14 THEN LINE (120, 50)-(140, 50)
        IF position > 16 THEN LINE (120, 37)-(140, 37)
        IF position > 18 THEN LINE (120, 24)-(140, 24)
        position = position - 1
       
        LOCATE 2, 2
        PRINT "  Question #"; tempnumber
        CIRCLE (130, place), 6
        PAINT (130, place + 2), 15
        PAINT (130, place - 2), 15

        LET starttime = TIMER
        LET endtime = starttime + time

        DO WHILE TIMER <= endtime
        y$ = INKEY$
        LET y$ = UCASE$(y$)
        IF y$ = "A" OR y$ = "B" OR y$ = "C" OR y$ = "D" OR y$ = "E" OR y$ = "F" OR y$ = "G" THEN GOTO pressedkey
        LOOP
       
        pmissed
       
        LET missed = missed + 1
        GOTO loopdone

pressedkey:
        IF y$ = realnote$ THEN pright: LET right = right + 1:
        IF y$ <> realnote$ THEN
                pwrong
                IF clef = 1 THEN LET bassposition(position) = bassposition(position) + 1
                IF clef = 3 THEN LET trebleposition(position) = trebleposition(position) + 1
       END IF
loopdone:
LOOP

CLS
LOCATE 5, 2
PRINT "Results:"
LOCATE 7, 5
PRINT "Questions Answered Correctly:"; right
LOCATE 8, 5
wrong = number - (right + missed)
PRINT "Questions Answered Incorrectly:"; wrong
LOCATE 9, 5
PRINT "Questions Unanswered:"; missed
LOCATE 10, 5

IF number = 0 THEN PRINT "Overall Percentage:"; "0"; "%": GOTO skippercentage
PRINT "Overall Percentage:"; CINT((((number - (missed + wrong)) / number)) * 100); "%"
skippercentage:


IF number <> 0 THEN LET percent = CINT((((number - (missed + wrong)) / number)) * 100)
IF number = 0 THEN LET percent = 0


SELECT CASE percent

CASE 100
        LOCATE 12, 2
        PRINT "Great Job!!!"
        GOTO dp
CASE IS >= 90
        LOCATE 12, 2
        PRINT "Good!"
        GOTO dp
CASE IS >= 80
        LOCATE 12, 2
        PRINT "Nice Job"
        GOTO dp
CASE IS >= 70
        LOCATE 12, 2
        PRINT "Not bad"
        GOTO dp
CASE IS >= 60
        LOCATE 12, 2
        PRINT "You're getting there!"
        GOTO dp
CASE IS >= 50
        LOCATE 12, 2
        PRINT "Let's try again, shall we?"
        GOTO dp
CASE IS >= 40
        LOCATE 12, 2
        PRINT "You can do better!"
        GOTO dp
CASE IS >= 30
        LOCATE 12, 2
        PRINT "That wasn't too good..."
        GOTO dp
CASE IS >= 20
        LOCATE 12, 2
        PRINT "I really hope you weren't trying"
        GOTO dp
CASE IS >= 10
        LOCATE 12, 2
        PRINT "That score makes me want to cry"
        GOTO dp
CASE IS >= 0
        LOCATE 12, 2
        PRINT "Hey! Wake up! You fell asleep! (I hope)"
        GOTO dp

END SELECT

dp:
LOCATE 14, 8
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS
problem

high
END SUB

