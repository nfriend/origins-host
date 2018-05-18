'Press SHIFT + F5 to start this program

'This program was created to help with note recognition for the cello
'Created by Nathan Friend in June of 2005

                 

















DECLARE SUB high ()
DECLARE SUB makeclefs ()
DECLARE SUB quiz ()
COMMON SHARED number, clefs, time, clef, position, wrong, right, missed, percent
CLS
SCREEN 1
SLEEP 2



LOCATE 5, 5
COLOR 15, 0
PRINT "Welcome to CelloHelp V.I"
' plays cello music

PLAY "< < <"
PLAY "t170"
PLAY "ML"
PLAY "l8"


FOR t = 1 TO 2
PLAY "g > d b a b d b d <"
NEXT t

FOR t = 1 TO 2
PLAY "g > e > c < b > c < e > c < e <"
NEXT t

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
PRINT "2) Tenor Clef"
LOCATE 6, 4
PRINT "3) Treble Clef"
LOCATE 7, 4
PRINT "4) Bass + Tenor Clef"
LOCATE 8, 4
PRINT "5) Bass + Treble Clef"
LOCATE 9, 4
PRINT "6) Tenor + Treble Clef"
LOCATE 10, 4
PRINT "7) All Three Clefs"
LOCATE 12, 4
INPUT "", clefs

IF clefs < 1 OR clefs > 7 THEN GOTO cleftop

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
OPEN "c:/work/nathan/qbasic~1/musichi/hiscores.txt" FOR INPUT AS #1

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
OPEN "c:/work/nathan/qbasic~1/musichi/hiscores.txt" FOR OUTPUT AS #1
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

OPEN "c:/work/nathan/qbasic~1/musichi/hiscores.txt" FOR INPUT AS #1

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
IF clef = 2 THEN GOTO tenor
IF clef = 3 THEN GOTO treble

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



tenor:
LINE (32, 50)-(40, 102), , BF
LINE (43, 50)-(45, 102), , BF
LINE (49, 76)-(54, 71)
CIRCLE (61, 63), 10, , 4, 1.9, 1.1
CIRCLE (54, 58), 4, , , , 1.1
PAINT (54, 58), 15
PSET (57, 54)
LINE (49, 76)-(54, 81)
CIRCLE (61, 89), 10, , 4, 2.2, 1.1
CIRCLE (54, 94), 4, , , , 1.1
PAINT (54, 94)
PSET (57, 90)



done:
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
        LET clef = INT(RND * 3) + 1
        
        IF clefs = 1 THEN
                IF clef = 2 OR clef = 3 THEN GOTO randagain
        END IF
        IF clefs = 2 THEN
                IF clef = 1 OR clef = 3 THEN GOTO randagain
        END IF
        IF clefs = 3 THEN
                IF clef = 1 OR clef = 2 THEN GOTO randagain
        END IF
        IF clefs = 4 AND clef = 3 THEN GOTO randagain
        IF clefs = 5 AND clef = 2 THEN GOTO randagain
        IF clefs = 6 AND clef = 1 THEN GOTO randagain
       
        makeclefs

        IF clef = 1 THEN
                RANDOMIZE TIMER
                LET note = INT(RND * 20) + 1 ' lowest is C String
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
                LET note = INT(RND * 15) + 1 ' lowest is D String
                LET position = note + 4
                
                IF position = 5 OR position = 12 OR position = 19 THEN LET realnote$ = "D"
                IF position = 6 OR position = 13 THEN LET realnote$ = "E"
                IF position = 7 OR position = 14 THEN LET realnote$ = "F"
                IF position = 8 OR position = 15 THEN LET realnote$ = "G"
                IF position = 9 OR position = 16 THEN LET realnote$ = "A"
                IF position = 10 OR position = 17 THEN LET realnote$ = "B"
                IF position = 11 OR position = 18 THEN LET realnote$ = "C"
                
        END IF
        IF clef = 3 THEN
                RANDOMIZE TIMER
                LET note = INT(RND * 13) + 1 ' lowest is the 1st E on A string
                LET position = note + 4
       
                IF position = 5 OR position = 12 THEN LET realnote$ = "E"
                IF position = 6 OR position = 13 THEN LET realnote$ = "F"
                IF position = 7 OR position = 14 THEN LET realnote$ = "G"
                IF position = 8 OR position = 15 THEN LET realnote$ = "A"
                IF position = 9 OR position = 16 THEN LET realnote$ = "B"
                IF position = 10 OR position = 17 THEN LET realnote$ = "C"
                IF position = 11 OR position = 18 THEN LET realnote$ = "D"
       
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

        SOUND 100, 2
        LET missed = missed + 1
        GOTO loopdone

pressedkey:
        IF y$ = realnote$ THEN SOUND 1000, 2: LET right = right + 1:
        IF y$ <> realnote$ THEN SOUND 100, 2


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

high
END SUB

