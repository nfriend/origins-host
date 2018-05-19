'ADVENTURE was created by Nathan Friend in the month of April, 2005
'
'To start the program, hold the SHIFT key and press F5.
'To navagate your person (Blue Square) around the world, use the number pad.
'8 = up    2 = down    4 = left    5 = right    SPACE = menu
'Red sqaures are enemies-move into their area to fight them.
'Gain food and money by defeating the enemies.
'Once you have conquered all 20 enemies, you win... or do you?
'Green squares are cities.  Move into them to enter the city.
'In the cities you can buy lessons to improve your endurance,
'     get healed, or buy different pieces of armor or different weapons.
'When you move into an enemies square, you will be brought to the fighting
'     screen.
'Wait until the screen flashes red, and press SPACE as quickly as possible.
'The faster you press ENTER, the more damage you will do to you enemy.
'Don't let him kill you first!
'Have fun!












'Okay, don't mess with this stuff, cuz' you'll probably mess it up real bad.
'Unless of course, you programmed it in the first place.
'Or you're a real good programmer.


'Things to do yet:
'Add in difficulty levels
'Add in end of game-win
'Add other sounds

DECLARE SUB test ()
DECLARE SUB win ()
DECLARE SUB death ()
DECLARE SUB fight ()
DECLARE SUB save ()
DECLARE SUB loadgame ()
DECLARE SUB menu ()
DECLARE SUB town ()
DECLARE SUB main ()
DECLARE SUB enemychange ()
COMMON SHARED name$, x, y, money, food, peak, health, alreadyfought, back
COMMON SHARED dagger, axe, sword, helmet, armor, shield, enemynumber, tfood
COMMON SHARED vision, playerx, playery, reaction

CLOSE

CLS

DIM SHARED previousnames$(500)

DIM SHARED ex(20)
DIM SHARED ey(20)

DIM SHARED averagetime(500)


LET money = 15
LET food = 20
LET peak = 10
LET health = 10
LET vision = 3
LET playerx = 40
LET playery = 11
LET dagger = 0
LET axe = 0
LET sword = 0
LET helmet = 0
LET shield = 0
LET armor = 0
LOCATE 3, 10
PRINT "What would you like to do?"
LOCATE 5, 15
PRINT "(1) Start a new game"
LOCATE 6, 15
PRINT "(2) Load a saved game"
LOCATE 7, 15
PRINT "(3) Quit"

DO
LET y$ = INKEY$
SELECT CASE y$
CASE "1"
GOTO nameagain
CASE "2"
CALL loadgame
main
CASE "3"
END
CASE ELSE
END SELECT
LOOP

nameagain:

CLS
INPUT "Name?", name$
LET name$ = UCASE$(name$)
LET namelength = LEN(name$)
IF namelength > 8 THEN PRINT "Sorry, but your file is to long.  Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO nameagain

OPEN "./save/names.txt" FOR INPUT AS #1
DO UNTIL EOF(1)
aa = aa + 1
INPUT #1, previousnames$(aa)
IF previousnames$(aa) = name$ THEN
        PRINT "File '"; name$; "' already exists.  Overwrite?  y/n  ";
        INPUT ""; overwrite$
        LET overwrite$ = UCASE$(overwrite$)
        IF MID$(overwrite$, 1, 1) = "Y" THEN LET overwrite$ = "y": GOTO overwrite
        IF MID$(overwrite$, 1, 1) = "N" THEN LET overwrite$ = "n": CLOSE : GOTO nameagain
END IF
LOOP
CLOSE
    


CLOSE
OPEN "./save/names.txt" FOR APPEND AS #1
PRINT #1, name$
CLOSE


overwrite:


testagain:
PRINT "What is your reaction speed?"
PRINT
PRINT "   (1) Fast"
PRINT "   (2) Medium"
PRINT "   (3) Slow"
PRINT "   (4) Take a test to find out"
PRINT
INPUT "   ", r$

SELECT CASE r$
CASE "1"
LET reaction = 1
CASE "2"
LET reaction = 2
CASE "3"
LET reaction = 3
CASE "4"
test
CASE ELSE
CLS
GOTO testagain
END SELECT




CLOSE
OPEN "./save/" + name$ + ".txt" FOR OUTPUT AS #1
CLOSE

writefile:

DIM SHARED x(8)
DIM SHARED y(8)

FOR i = 1 TO 8

cityagain:

RANDOMIZE TIMER
y(i) = INT(RND * 23) + 1
x(i) = INT(RND * 80) + 1

FOR b = 1 TO 8
IF y(i) - y(b) < 2 AND y(i) - y(b) > -2 AND b < i THEN GOTO cityagain
IF x(i) - x(b) < 2 AND x(i) - x(b) > -2 AND b < i THEN GOTO cityagain
NEXT b

NEXT i

FOR i = 1 TO 20

enemyagain:
ey(i) = INT(RND * 23) + 1
ex(i) = INT(RND * 80) + 1

FOR b = 1 TO 20
IF ey(i) = ey(b) AND ex(i) = ex(b) AND b < i THEN GOTO enemyagain
IF ey(i) = 1 AND ex(i) = 1 THEN GOTO enemyagain
NEXT b

NEXT i


OPEN "./save/" + name$ + ".txt" FOR OUTPUT AS #2
PRINT #2, name$
PRINT #2, reaction
FOR j = 1 TO 8
PRINT #2, x(j)
PRINT #2, y(j)
NEXT j
FOR P = 1 TO 20
PRINT #2, ex(P)
PRINT #2, ey(P)
NEXT P
PRINT #2, money
PRINT #2, food
PRINT #2, peak
PRINT #2, health
PRINT #2, vision
PRINT #2, playerx
PRINT #2, playery
PRINT #2, dagger
PRINT #2, axe
PRINT #2, sword
PRINT #2, helmet
PRINT #2, armor
PRINT #2, shield
PRINT #2, enemynumber
PRINT #2, tfood
CLOSE

OPEN "./save/average/" + name$ + ".txt" FOR OUTPUT AS #1
CLOSE

CALL main

SUB death
CLS
PLAY "<<t50l4ce-l2gmll8fe-msdml<b>l2c "
LOCATE 1, 36
COLOR 12
FOR i = 1 TO 23
FOR t = 1 TO 10000
NEXT t
COLOR 0
LOCATE i, 36
PRINT "You died."
COLOR 12
LOCATE i + 1, 36
PRINT "You died."
NEXT i
COLOR 0
END
END SUB

SUB enemychange

FOR u = 1 TO 20

IF ex(u) = 1 AND ey(u) = 1 THEN GOTO done1

RANDOMIZE TIMER
xy = INT(RND * 17) + 1

IF xy = 2 OR xy = 5 OR xy = 9 OR xy = 10 OR xy = 15 OR xy = 14 THEN GOTO changex
IF xy = 1 OR xy = 8 OR xy = 3 OR xy = 11 OR xy = 13 OR xy = 12 THEN GOTO changey
IF xy = 4 OR xy = 7 OR xy = 17 OR xy = 16 THEN GOTO done1
IF xy = 6 THEN GOTO randomplace

changex:
COLOR 0
LOCATE ey(u), ex(u)
        PRINT CHR$(219)
        RANDOMIZE TIMER
        updown = INT(RND * 20) + 1
        IF updown <= 15 AND updown >= 6 THEN LET ex(u) = ex(u) + 1
        IF updown < 6 OR updown > 15 THEN LET ex(u) = ex(u) - 1
        IF ex(u) < 1 THEN LET ex(u) = 80
        IF ex(u) > 80 THEN LET ex(u) = 1
        GOTO done1


changey:
COLOR 0

        LOCATE ey(u), ex(u)
        PRINT CHR$(219)
        RANDOMIZE TIMER
        leftright = INT(RND * 20) + 1
        IF leftright <= 15 AND leftright >= 6 THEN LET ey(u) = ey(u) + 1
        IF leftright < 6 OR leftright > 15 THEN LET ey(u) = ey(u) - 1
        IF ey(u) < 1 THEN LET ey(u) = 23
        IF ey(u) > 23 THEN LET ey(u) = 1
        GOTO done1

randomplace:
COLOR 0
LOCATE ey(u), ex(u)
PRINT CHR$(219)

RANDOMIZE TIMER
ey(u) = INT(RND * 23) + 1
ex(u) = INT(RND * 80) + 1

IF ex(u) = 1 AND ey(u) = 1 THEN LET ex(u) = 13: LET ey(u) = 13



done1:
NEXT u

END SUB

SUB fight

tophere:

RANDOMIZE TIMER
epeak = INT(RND * peak + 2) + peak - 5
IF epeak < peak - 5 THEN GOTO tophere
IF epeak > peak + 2 THEN GOTO tophere

topofehealth:
RANDOMIZE TIMER
ehealth = INT(RND * epeak) + (epeak - 5)

IF ehealth < (epeak - 5) THEN GOTO topofehealth
IF ehealth > epeak THEN GOTO topofehealth

IF sword = 1 THEN LET ehealth = ehealth - 1.5: GOTO ready
IF axe = 1 THEN LET ehealth = ehealth - 1: GOTO ready
IF dagger = 1 THEN LET ehealth = ehealth - .5: GOTO ready

ready:



CLS
SCREEN 9
SLEEP 2

LOCATE 13, 37
COLOR 10
PRINT "READY!"
SLEEP 1

CLS
LOCATE 13, 38
COLOR 14
PRINT "SET!"
SLEEP 1

CLS
LOCATE 13, 37
COLOR 12
PRINT "FIGHT!"
SLEEP 1

CLS

DO UNTIL ehealth <= 0 OR health <= 0
LET j = j + 1

COLOR 9
LOCATE 11, 10
PRINT "Your Health:"; health; "out of"; peak; "          "
COLOR 12
LOCATE 13, 10
PRINT "Enemies Health:"; ehealth; "out of"; epeak; "                 "

RANDOMIZE TIMER
sleeptime = INT(RND * 2000000) + 160000

FOR i = 1 TO sleeptime
LET r$ = INKEY$
NEXT i



COLOR , 12
FOR i = 1 TO 10000
NEXT i
COLOR 0, 0

LOCATE 9, 10
PRINT "                                                                "


topa:
LET s$ = ""
LET time = -10000
DO WHILE s$ = ""
s$ = INKEY$
LET time = time + 1
LOOP

LET averagetime(j) = time

IF reaction = 1 THEN
SELECT CASE time
CASE IS < 50000
LET ehealth = ehealth - 2
CASE IS >= 50000
IF time < 60000 THEN LET ehealth = ehealth - 1.5
CASE IS >= 60000
IF time < 70000 THEN LET ehealth = ehealth - 1
CASE IS >= 70000
IF time < 90000 THEN LET ehealth = ehealth - .5
CASE ELSE
END SELECT
END IF

IF reaction = 2 THEN
SELECT CASE time
CASE IS < 60000
LET ehealth = ehealth - 2
CASE IS >= 60000
IF time < 70000 THEN LET ehealth = ehealth - 1.5
CASE IS >= 70000
IF time < 80000 THEN LET ehealth = ehealth - 1
CASE IS >= 80000
IF time < 100000 THEN LET ehealth = ehealth - .5
CASE ELSE
END SELECT
END IF

IF reaction = 3 THEN
SELECT CASE time
CASE IS < 70000
LET ehealth = ehealth - 2
CASE IS >= 70000
IF time < 80000 THEN LET ehealth = ehealth - 1.5
CASE IS >= 80000
IF time < 90000 THEN LET ehealth = ehealth - 1
CASE IS >= 90000
IF time < 110000 THEN LET ehealth = ehealth - .5
CASE ELSE
END SELECT
END IF


erand:
RANDOMIZE TIMER
etime = INT(RND * 100000) + 60000
IF etime < 60000 OR etime > 100000 THEN GOTO erand

randagain:

IF armor = 1 THEN
RANDOMIZE TIMER
block = INT(RND * 4) + 1
IF block < 1 OR block > 4 THEN GOTO randagain
IF block = 3 THEN LET ehealth = ehealth - .5: LET miss = 1: GOTO nodamage
END IF

randagain1:
IF shield = 1 THEN
RANDOMIZE TIMER
block = INT(RND * 4) + 1
IF block < 1 OR block > 4 THEN GOTO randagain1
IF block = 2 THEN LET miss = 1: GOTO nodamage
END IF

randagain2:
IF helmet = 1 THEN
RANDOMIZE TIMER
block = INT(RND * 5) + 1
IF block < 1 OR block > 5 THEN GOTO randagain2
IF block = 5 THEN LET miss = 1: GOTO nodamage
END IF


SELECT CASE etime

CASE IS < 72000
LET health = health - 2

CASE IS >= 72000
IF etime < 83000 THEN LET health = health - 1.5

CASE IS >= 83000
IF etime < 93000 THEN LET health = health - 1

CASE IS >= 93000
IF etime < 97000 THEN LET health = health - .5

CASE ELSE

END SELECT

nodamage:

COLOR 12
IF miss = 1 THEN LOCATE 9, 10: PRINT "Your protection blocks the enemy's attack!": LET miss = 0
COLOR 9
LOCATE 11, 10
PRINT "Your Health:"; health; "out of"; peak; "          "
COLOR 12
LOCATE 13, 10
PRINT "Enemies Health:"; ehealth; "out of"; epeak; "                 "

LOOP

CLS
SCREEN 0

CLOSE
OPEN "./save/average/" + name$ + ".txt" FOR APPEND AS #1
FOR i = 1 TO j
PRINT #1, averagetime(i)
NEXT i
CLOSE

ERASE averagetime

IF health <= 0 THEN death

IF ehealth <= 0 THEN
        RANDOMIZE TIMER
        egold = INT(RND * 40) + 1
        efood = INT(RND * 15) + 1
        ehhealth = INT(RND * 5) + 1
PRINT "Conratulations!  You have defeated your enemy!"
PRINT "This is what you gained from you enemy:"
PRINT egold; "Gold"
PRINT efood; "Food"
PRINT ehhealth; "Health"
LET alreadyfought = 1
LET money = money + egold
LET food = food + efood
LET health = health + ehhealth
IF health > peak THEN LET health = peak
PRINT "You now have "; money; "gold, a"; food; "-day food supply, and your health is"; health; "/"; peak; "."
PLAY "l16ceg>c<"
END IF

PRINT
PRINT "Press any key to go back to the game..."

DO WHILE INKEY$ = ""
LOOP

CLS

END SUB

SUB loadgame
top:
CLS
OPEN "./save/names.txt" FOR INPUT AS #1
DO UNTIL EOF(1)
FOR i = 1 TO 9
IF EOF(1) THEN EXIT DO
INPUT #1, a$
PRINT a$;
PRINT "  ";
NEXT i
PRINT " "
PRINT
LOOP
CLOSE

PRINT
PRINT

INPUT "What file would you like to load?  ", load$

LET load$ = UCASE$(load$)
OPEN "./save/names.txt" FOR INPUT AS #1
DO UNTIL EOF(1)
INPUT #1, tempname$
IF tempname$ = load$ THEN GOTO cleared
LOOP
CLOSE


IF LEN(load$) > 8 THEN PRINT "Sorry, but there is no file called '"; load$; "'.": DO WHILE INKEY$ = "": LOOP: GOTO top
PRINT "Sorry, but there is no file called '"; load$; ";."
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
GOTO top
cleared:
OPEN "./save/" + load$ + ".txt" FOR INPUT AS #2
INPUT #2, name$
INPUT #2, reaction
FOR j = 1 TO 8
INPUT #2, x(j)
INPUT #2, y(j)
NEXT j
FOR P = 1 TO 20
INPUT #2, ex(P)
INPUT #2, ey(P)
NEXT P
INPUT #2, money
INPUT #2, food
INPUT #2, peak
INPUT #2, health
INPUT #2, vision
INPUT #2, playerx
INPUT #2, playery
INPUT #2, dagger
INPUT #2, axe
INPUT #2, sword
INPUT #2, helmet
INPUT #2, armor
INPUT #2, shield
INPUT #2, enemynumber
INPUT #2, tfood
CLOSE


END SUB

SUB main

CLS

COLOR 9
LOCATE playery, playerx
PRINT CHR$(219)

FOR i = 1 TO 8
LOCATE y(i), x(i)
COLOR 10
PRINT CHR$(219)
NEXT i

FOR r = 1 TO 20
IF ey(r) - playery < vision AND ey(r) - playery > -vision AND ex(r) - playerx < vision AND ex(r) - playerx > -vision AND ey(r) <> -1 THEN
        COLOR 12
        LOCATE ey(r), ex(r)
        PRINT CHR$(219)
END IF
NEXT r

DO

LET y$ = INKEY$
IF y$ = "4" THEN COLOR 0: LOCATE playery, playerx: PRINT CHR$(219): LET playerx = playerx - 1: LET tfood = tfood + 1: IF tfood = 4 THEN LET food = food - 1: IF tfood = 4 THEN LET tfood = 0
IF y$ = "6" THEN COLOR 0: LOCATE playery, playerx: PRINT CHR$(219): LET playerx = playerx + 1: LET tfood = tfood + 1: IF tfood = 4 THEN LET food = food - 1: IF tfood = 4 THEN LET tfood = 0
IF y$ = "8" THEN COLOR 0: LOCATE playery, playerx: PRINT CHR$(219): LET playery = playery - 1: LET tfood = tfood + 1: IF tfood = 4 THEN LET food = food - 1: IF tfood = 4 THEN LET tfood = 0
IF y$ = "2" THEN COLOR 0: LOCATE playery, playerx: PRINT CHR$(219): LET playery = playery + 1: LET tfood = tfood + 1: IF tfood = 4 THEN LET food = food - 1: IF tfood = 4 THEN LET tfood = 0
IF y$ = " " THEN CALL menu

IF food < 0 THEN LET food = 0

IF y$ <> "" AND food < 4 THEN SOUND 700, 2

IF y$ = "4" OR y$ = "6" OR y$ = "8" OR y$ = "2" THEN
        IF food = 0 THEN LET health = health - .5
END IF

IF health = 0 THEN death

IF y$ <> "" THEN LET alreadyfought = 0
IF y$ = "4" OR y$ = "6" OR y$ = "8" OR y$ = "2" THEN CALL enemychange

FOR i = 1 TO 8
LOCATE y(i), x(i)
COLOR 10
PRINT CHR$(219)
NEXT i


IF y$ <> "" THEN
        IF playery < 1 THEN LET playery = 23': LET food = food + 1
        IF playery > 23 THEN LET playery = 1': LET food = food + 1
        IF playerx < 1 THEN LET playerx = 80': LET food = food + 1
        IF playerx > 80 THEN LET playerx = 1': LET food = food + 1
        LOCATE playery, playerx
        COLOR 9
        PRINT CHR$(219)
END IF


IF y$ <> "" THEN
        LOCATE 23, 1
        IF food <= 6 THEN COLOR 12
        PRINT "Food supply:"; food; "-day supply.";
        COLOR 9
        PRINT "  Gold:"; money; ".";
        PRINT "  Health:"; health; "/"; peak; ". ";
        PRINT "Enemies left:"; 20 - enemynumber
END IF

IF y$ <> "" THEN
FOR t = 1 TO 20
LOCATE ey(t), ex(t)
COLOR 0
PRINT CHR$(219)
NEXT t
END IF
                                                                                                                   
IF y$ <> "" THEN
FOR r = 1 TO 20
IF ey(r) - playery < vision AND ey(r) - playery > -vision AND ex(r) - playerx < vision AND ex(r) - playerx > -vision THEN
        IF ey(r) <> 1 OR ex(r) <> 1 THEN
                COLOR 12
                LOCATE ey(r), ex(r)
                PRINT CHR$(219)
        END IF
END IF
NEXT r
END IF

FOR c = 1 TO 20
IF playerx = ex(c) AND playery = ey(c) AND alreadyfought <> 1 THEN
        IF ey(c) <> 1 OR ex(c) <> 1 THEN fight: LET enemynumber = enemynumber + 1: IF enemynumber = 20 THEN win
IF alreadyfought = 1 THEN
        FOR u = 1 TO 20
                IF playery = ey(u) AND playerx = ex(u) THEN LET ey(u) = 1: LET ex(u) = 1
        NEXT u
END IF
END IF
NEXT c






IF y$ <> "" THEN
        FOR i = 1 TO 8
        IF playerx = x(i) AND playery = y(i) THEN CALL town
        NEXT i
END IF


LOOP


END SUB

SUB menu
here:
CLS
COLOR 9
LOCATE 3, 10
PRINT "Main Menu"
LOCATE 5, 13
PRINT "(1) Save Game"
LOCATE 6, 13
PRINT "(2) Quit Game"
LOCATE 7, 13
PRINT "(3) Load Game"
LOCATE 8, 13
PRINT "(4) Continue"
LOCATE 10, 13
INPUT "", what$


SELECT CASE what$
CASE "1"
save

CASE "2"
topofhere:
INPUT "Would you like to save your game before quitting?", quit$
IF UCASE$(MID$(quit$, 1, 1)) = "Y" THEN : save: END
IF UCASE$(MID$(quit$, 1, 1)) = "N" THEN END
GOTO topofhere

CASE "3"
topofhere2:
INPUT "Would you like to save your game before loading a game?", loadgames$
IF UCASE$(MID$(loadgames$, 1, 1)) = "Y" THEN save: loadgame: GOTO done
IF UCASE$(MID$(loadgames$, 1, 1)) = "N" THEN loadgame: GOTO done
GOTO topofhere2

CASE "4"
main

CASE ELSE
menu

END SELECT

done:
CLS
IF back = 1 THEN GOTO here
END SUB

SUB save
OPEN "./save/" + name$ + ".txt" FOR OUTPUT AS #2
PRINT #2, name$
PRINT #2, reaction
FOR j = 1 TO 8
PRINT #2, x(j)
PRINT #2, y(j)
NEXT j
FOR P = 1 TO 20
PRINT #2, ex(P)
PRINT #2, ey(P)
NEXT P
PRINT #2, money
PRINT #2, food
PRINT #2, peak
PRINT #2, health
PRINT #2, vision
PRINT #2, playerx
PRINT #2, playery
PRINT #2, dagger
PRINT #2, axe
PRINT #2, sword
PRINT #2, helmet
PRINT #2, armor
PRINT #2, shield
PRINT #2, enemynumber
PRINT #2, tfood
CLOSE

END SUB

SUB test
testingagain:
CLS
PRINT "Press SPACE as quickly as you can after you see the screen flash red."
PRINT "The screen will flash 5 times and this will determine your reaction speed."
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS

SCREEN 9
SLEEP 2

LOCATE 13, 37
COLOR 12
PRINT "READY!"
SLEEP 1

CLS
LOCATE 13, 38
COLOR 14
PRINT "SET!"
SLEEP 1

CLS
LOCATE 13, 39
COLOR 10
PRINT "GO!"
SLEEP 1

CLS

IF UCASE$(MID$(testnoyes$, 1, 1)) = "Y" THEN REDIM testing(5)
IF testnoyes$ = "" THEN DIM testing(5)
FOR tester = 1 TO 5

RANDOMIZE TIMER
sleeptime = INT(RND * 2000000) + 160000

FOR i = 1 TO sleeptime
LET r$ = INKEY$
NEXT i

COLOR , 12
FOR i = 1 TO 10000
NEXT i
COLOR , 0


LET s$ = ""
LET time = -10000
DO WHILE s$ = ""
s$ = INKEY$
LET time = time + 1
LOOP


LET testing(tester) = time
PRINT time

NEXT tester

SCREEN 0
LET average = (testing(0) + testing(1) + testing(2) + testing(3) + testing(4)) / 5
            

SELECT CASE average
CASE IS < 42000
LET reaction = 1
CLS
PRINT "Your reaction speed is 'fast'"
CASE IS >= 42000
IF average < 47000 THEN LET reation = 2
CLS
PRINT "Your reaction speed is 'medium'"
CASE IS >= 47000
LET reaction = 3
CLS
PRINT "Your reaction speed is 'slow'"
END SELECT

INPUT "Would you like to take the test again to try to get a better score?", testnoyes$
IF UCASE$(MID$(testnoyes$, 1, 1)) = "Y" THEN GOTO testingagain
IF UCASE$(MID$(testnoyes$, 1, 1)) = "N" THEN GOTO bottom

bottom:
END SUB

SUB town
COLOR 9
towntop:
CLS
LOCATE 2, 5
'get vision into here sometime
PRINT "You enter the town.  What would you like to do?"
LOCATE 3, 5
PRINT "You have"; money; " gold."
LOCATE 5, 8
PRINT "(1) Take training to increase your endurance"
LOCATE 6, 8
PRINT "(2) Buy extra food supply"
LOCATE 7, 8
PRINT "(3) Buy equipment"
LOCATE 8, 8
PRINT "(4) Rest in the local inn"
LOCATE 9, 8
PRINT "(5) Go to the local doctor to be healed"
LOCATE 10, 8
PRINT "(6) Buy a telescope to increase you vision"
LOCATE 11, 8
PRINT "(7) Leave town"
LOCATE 13, 8
INPUT "", towntop$

SELECT CASE towntop$
CASE "1"
GOTO training
CASE "2"
GOTO buyfood
CASE "3"
GOTO equipment
CASE "4"
GOTO inn
CASE "5"
GOTO doctor
CASE "6"
GOTO telescope
CASE "7"
GOTO exittown
CASE ELSE
GOTO towntop
END SELECT

training:
CLS
LOCATE 5, 10
PRINT "This will increase you maximum health by 1 point."
LOCATE 6, 10
PRINT "Your current maximum health is"; peak; "."
LOCATE 7, 10
PRINT "Cost: 100 gold"
LOCATE 8, 10
PRINT "Do you still want to take the training?";
INPUT "", train$

IF UCASE$(MID$(train$, 1, 1)) = "Y" AND money >= 100 THEN
        CLS
        PRINT "You train with a experienced trainer in the town and increase your endurance.";
        LET peak = peak + 1
        LET health = health + 1
        LET money = money - 100
        PRINT "Your maximum health is now"; peak; ", and your health is "; health; "/"; peak; "."
        SLEEP 9
        GOTO towntop
END IF

IF UCASE$(MID$(train$, 1, 1)) = "Y" AND money < 100 THEN
        CLS
        LET goldshort = 100 - money
        PRINT "Sorry, but you are "; goldshort; " gold short."
        SLEEP 2
        GOTO towntop
END IF

IF UCASE$(MID$(train$, 1, 1)) = "N" THEN GOTO towntop

buyfood:
CLS
LOCATE 5, 10
PRINT "Here are the choices of food supplies.  What would you like to buy?"
LOCATE 6, 10
PRINT "You have"; money; "gold."
LOCATE 8, 12
PRINT "(1) 5-day supply - 5 gold"
LOCATE 9, 12
PRINT "(2) 10-day supply - 9 gold"
LOCATE 10, 12
PRINT "(3) 20-day supply - 17 gold"
LOCATE 11, 12
PRINT "(4) 50-day supply - 45 gold"
LOCATE 12, 12
PRINT "(5) 100-day supply - 85 gold"
LOCATE 13, 12
PRINT "(6) Back"
LOCATE 15, 12
INPUT "", whatfood$

LOCATE 17, 1

SELECT CASE whatfood$
CASE "1"
       
        IF money < 5 THEN
                PRINT "Sorry, but you are "; 5 - money; " gold short."
                SLEEP 3
                GOTO buyfood
        END IF
food5top:
        IF money >= 5 THEN INPUT "Are you sure you want to purchase a 5-day food supply for 5 gold?", food5$
                IF UCASE$(MID$(food5$, 1, 1)) = "Y" THEN LET food = food + 5: LET money = money - 5: LOCATE 18, 12: PRINT "You now have a "; food; "-day food supply and "; money; "gold.": SLEEP 4: GOTO towntop
                IF UCASE$(MID$(food5$, 1, 1)) = "N" THEN GOTO buyfood
        LOCATE 17, 12: GOTO food5top

CASE "2"
       
        IF money < 9 THEN
                PRINT "Sorry, but you are "; 9 - money; " gold short."
                SLEEP 3
                GOTO buyfood
        END IF
food10top:
        IF money >= 9 THEN INPUT "Are you sure you want to purchase a 10-day food supply for 9 gold?", food10$
                IF UCASE$(MID$(food10$, 1, 1)) = "Y" THEN LET food = food + 10: LET money = money - 9: LOCATE 18, 12: PRINT "You now have a "; food; "-day food supply and "; money; "gold.": SLEEP 4: GOTO towntop
                IF UCASE$(MID$(food10$, 1, 1)) = "N" THEN GOTO buyfood
        LOCATE 17, 12: GOTO food10top

CASE "3"
      
        IF money < 17 THEN
                PRINT "Sorry, but you are "; 17 - money; " gold short."
                SLEEP 3
                GOTO buyfood
        END IF
food20top:
        IF money >= 17 THEN INPUT "Are you sure you want to purchase a 20-day food supply for 17 gold?", food20$
                IF UCASE$(MID$(food20$, 1, 1)) = "Y" THEN LET food = food + 20: LET money = money - 17: LOCATE 18, 12: PRINT "You now have a "; food; "-day food supply and "; money; "gold.": SLEEP 4: GOTO towntop
                IF UCASE$(MID$(food20$, 1, 1)) = "N" THEN GOTO buyfood
        LOCATE 17, 12: GOTO food20top

CASE "4"
     
        IF money < 45 THEN
                PRINT "Sorry, but you are "; 45 - money; " gold short."
                SLEEP 3
                GOTO buyfood
        END IF
food50top:
        IF money >= 45 THEN INPUT "Are you sure you want to purchase a 50-day food supply for 45 gold?", food50$
                IF UCASE$(MID$(food50$, 1, 1)) = "Y" THEN LET food = food + 50: LET money = money - 45: LOCATE 18, 12: PRINT "You now have a "; food; "-day food supply and "; money; "gold.": SLEEP 4: GOTO towntop
                IF UCASE$(MID$(food50$, 1, 1)) = "N" THEN GOTO buyfood
        LOCATE 17, 12: GOTO food50top

CASE "5"
    
        IF money < 85 THEN
                PRINT "Sorry, but you are "; 85 - money; " gold short."
                SLEEP 3
                GOTO buyfood
        END IF
food100top:
        IF money >= 85 THEN INPUT "Are you sure you want to purchase a 100-day food supply for 85 gold?", food100$
                IF UCASE$(MID$(food100$, 1, 1)) = "Y" THEN LET food = food + 100: LET money = money - 85: LOCATE 18, 12: PRINT "You now have a "; food; "-day food supply and "; money; "gold.": SLEEP 4: GOTO towntop
                IF UCASE$(MID$(food100$, 1, 1)) = "N" THEN GOTO buyfood
        LOCATE 17, 12: GOTO food100top

CASE "6"
        GOTO towntop

CASE ELSE
        GOTO buyfood

END SELECT

equipment:
CLS
LOCATE 5, 10
PRINT "Here are some various peices of equipment to help you as you fight."
LOCATE 6, 10
PRINT "Choose one to find out what it can do for you."
LOCATE 8, 10
PRINT "(1) Dagger"
LOCATE 9, 10
PRINT "(2) Axe"
LOCATE 10, 10
PRINT "(3) Sword"
LOCATE 11, 10
PRINT "(4) Helmet"
LOCATE 12, 10
PRINT "(5) Shield"
LOCATE 13, 10
PRINT "(6) Armor"
LOCATE 14, 10
PRINT "(7) Go Back"
LOCATE 16, 10
INPUT "", choose$


choosetop:

SELECT CASE choose$
CASE "1"

        CLS
        LOCATE 5, 1
        PRINT "The dagger will take down the enemy's health by .5 a point at the very  "
        LOCATE 6, 1
        PRINT "beginning of every battle.  It costs 70 gold. It is replaced by the Axe."
        LOCATE 7, 1
        PRINT "Would you like to buy it?";
        INPUT "  ", dagger$
        LOCATE 9, 1
        IF UCASE$(MID$(dagger$, 1, 1)) = "Y" THEN
                IF money < 70 THEN PRINT "Sorry, but you are"; 70 - money; "gold short.": SLEEP 3: GOTO equipment
                IF money >= 70 THEN LET dagger = 1: LET money = money - 70: PRINT "You now have a dagger and"; money; "gold.": SLEEP 4: GOTO towntop
        END IF
        IF UCASE$(MID$(dagger$, 1, 1)) = "N" THEN GOTO equipment
        GOTO choosetop

CASE "2"

axetop:
        CLS
        LOCATE 5, 1
        PRINT "The axe will take down the enemy's health by 1 point at the very  "
        LOCATE 6, 1
        PRINT "beginning of every battle.  It costs 100 gold."
        LOCATE 7, 1
        PRINT "The dagger is needed to buy the axe, and the axe is replaced by the sword."
        LOCATE 8, 1
        PRINT "Would you like to buy it?";
        INPUT "  ", axe$
        LOCATE 10, 1
        IF UCASE$(MID$(axe$, 1, 1)) = "Y" THEN
                IF money < 100 THEN PRINT "Sorry, but you are"; 100 - money; "gold short.": SLEEP 3: GOTO equipment
                IF money >= 100 THEN LET axe = 1: LET money = money - 100: PRINT "You now have a axe and"; money; "gold.": SLEEP 4: GOTO towntop
        END IF
        IF UCASE$(MID$(axe$, 1, 1)) = "N" THEN GOTO equipment
        GOTO choosetop
CASE "3"

swordtop:
        CLS
        LOCATE 5, 1
        PRINT "The sword will take down the enemy's health by 1.5 points at the very  "
        LOCATE 6, 1
        PRINT "beginning of every battle.  It costs 120 gold."
        LOCATE 7, 1
        PRINT "The axe is needed to buy the sword."
        LOCATE 8, 1
        PRINT "Would you like to buy it?";
        INPUT "  ", sword$
        LOCATE 10, 1
        IF UCASE$(MID$(sword$, 1, 1)) = "Y" THEN
                IF money < 120 THEN PRINT "Sorry, but you are"; 120 - money; "gold short.": SLEEP 3: GOTO equipment
                IF money >= 120 THEN LET sword = 1: LET money = money - 120: PRINT "You now have a sword and"; money; "gold.": SLEEP 4: GOTO towntop
        END IF
        IF UCASE$(MID$(axe$, 1, 1)) = "N" THEN GOTO equipment
        GOTO choosetop
CASE "4"

helmettop:
        CLS
        LOCATE 5, 1
        PRINT "The helmet has a 1/5 chance of blocking an enemy attack."
        LOCATE 6, 1
        PRINT "It costs 70 gold"
        LOCATE 7, 1
        PRINT "Would you like to buy it?";
        INPUT "  ", helmet$
        LOCATE 10, 1
        IF UCASE$(MID$(helmet$, 1, 1)) = "Y" THEN
                IF money < 70 THEN PRINT "Sorry, but you are"; 70 - money; "gold short.": SLEEP 3: GOTO equipment
                IF money >= 70 THEN LET helmet = 1: LET money = money - 70: PRINT "You now have a helmet and"; money; "gold.": SLEEP 4: GOTO towntop
        END IF
        IF UCASE$(MID$(helmet$, 1, 1)) = "N" THEN GOTO equipment
        GOTO choosetop
CASE "5"

shieldtop:
        CLS
        LOCATE 5, 1
        PRINT "The shield has a 1/4 chance of blocking an enemy attack."
        LOCATE 6, 1
        PRINT "It costs 100 gold"
        LOCATE 7, 1
        PRINT "Would you like to buy it?";
        INPUT "  ", shield$
        LOCATE 10, 1
        IF UCASE$(MID$(shield$, 1, 1)) = "Y" THEN
                IF money < 100 THEN PRINT "Sorry, but you are"; 100 - money; "gold short.": SLEEP 3: GOTO equipment
                IF money >= 100 THEN LET shield = 1: LET money = money - 100: PRINT "You now have a shield and"; money; "gold.": SLEEP 4: GOTO towntop
        END IF
        IF UCASE$(MID$(shield$, 1, 1)) = "N" THEN GOTO equipment
        GOTO choosetop

CASE "6"

armortop:
        CLS
        LOCATE 5, 1
        PRINT "The armor has a 1/4 chance of blocking an enemy attack."
        LOCATE 6, 1
        PRINT "In the case that the armor does block a attack, the enemy's health will be"
        LOCATE 7, 1
        PRINT "decreased by .5 a point."
        LOCATE 8, 1
        PRINT "It costs 120 gold"
        LOCATE 9, 1
        PRINT "Would you like to buy it?";
        INPUT "  ", armor$
        LOCATE 10, 1
        IF UCASE$(MID$(armor$, 1, 1)) = "Y" THEN
                IF money < 120 THEN PRINT "Sorry, but you are"; 120 - money; "gold short.": SLEEP 3: GOTO equipment
                IF money >= 120 THEN LET armor = 1: LET money = money - 120: PRINT "You now have armor and"; money; "gold.": SLEEP 4: GOTO towntop
        END IF
        IF UCASE$(MID$(armor$, 1, 1)) = "N" THEN GOTO equipment
        GOTO choosetop
CASE "7"
GOTO towntop

CASE ELSE
GOTO equipment

END SELECT

inn:
CLS
LOCATE 5, 10
PRINT "A stay at the local in will give you 3 extra health.  Cost: 20 gold."
LOCATE 6, 10
INPUT "Would you like to stay at the inn?  ", innny$
IF UCASE$(MID$(innny$, 1, 1)) = "Y" THEN
LOCATE 7, 10
LET money = money - 20
LET health = health + 3
PRINT "You enjoy a refreshing night at the inn."
LOCATE 7, 10
PRINT "Your health is now "; health; "/"; peak; ", and you have "; money; "gold."
SLEEP 6
GOTO towntop
END IF
IF UCASE$(MID$(innny$, 1, 1)) = "N" THEN GOTO towntop
GOTO inn

doctor:
CLS
LOCATE 4, 1
PRINT "A visit to the doctor will heal you completely."
LOCATE 5, 1
PRINT "It will cost you 10 gold for each point that you are healed."
LOCATE 6, 1
PRINT "If you do not have enough money to completely heal yourself, you will be"
LOCATE 7, 1
PRINT "    healed until you run out of money."
LOCATE 8, 1
PRINT "Your current health is "; health; "/"; peak; "."
LOCATE 10, 1
INPUT "Do you want to be healed?  ", heal$

IF UCASE$(MID$(heal$, 1, 1)) = "Y" THEN
        LET amount = 10 * (peak - health)
        IF money >= amount THEN LET health = peak: LET money = money - amount: LOCATE 11, 10: PRINT "The doctor fixes you up, and you now have full health and"; money; "gold.": SLEEP 4: GOTO towntop
        IF money < amount THEN
                LET tempmoney = money
               
                DO UNTIL tempmoney < 0
                        LET f = f + 1
                        LET tempmoney = tempmoney - 5
                LOOP
      
                FOR i = 1 TO f - 1
                        LET money = money - 5
                        LET health = health + .5
                NEXT i
        
        LOCATE 11, 10
        PRINT "Your health is now"; health; "/"; peak; ", and you have "; money; "gold."
        SLEEP 5
        GOTO towntop
        END IF
END IF

IF UCASE$(MID$(heal$, 1, 1)) = "N" THEN GOTO towntop




telescope:
CLS
LOCATE 5, 1
PRINT "A telescope will increase you vision so that you can see enemies from farther"
LOCATE 6, 1
PRINT "     away."
LOCATE 7, 1
PRINT "Your current vision is"; vision - 1; ".  That means that you can see enemies from"
PRINT "     that many squares away."
LOCATE 9, 1
PRINT "It will cost you 300 gold."
LOCATE 10, 1
PRINT "You can also buy another telescope after you buy the first one and increase"
LOCATE 11, 1
PRINT "     your vision even more."
LOCATE 13, 1
INPUT "Would you like to buy it?", tele$
IF UCASE$(MID$(tele$, 1, 1)) = "Y" AND money >= 300 THEN LET money = money - 300: LET vision = vision + 1: LOCATE 15, 1: PRINT "You bought a telescope. Your vision is now"; vision; ".": SLEEP 5: GOTO towntop
IF UCASE$(MID$(tele$, 1, 1)) = "Y" AND money < 300 THEN LOCATE 15, 1: PRINT "Sorry, but you are"; 300 - money; "gold short.": SLEEP 3: GOTO towntop
IF UCASE$(MID$(tele$, 1, 1)) = "N" THEN GOTO towntop
GOTO telescope



exittown:
CLS
END SUB

SUB win
DIM highscore(1000)
DIM tempname$(1000)
CLS
PRINT "YOU WIN!"
IF reaction = 2 THEN PRINT "Now you will move on to the next level.  Your reaction speed has been set at": PRINT "  fast."
IF reaction = 3 THEN PRINT "Now, move on to the next level.  Your reaction speed has been changed to": PRINT "  medium."
IF reaction = 1 THEN
        PRINT
        CLOSE
        OPEN "./save/average/" + name$ + ".txt" FOR INPUT AS #1
        DO UNTIL EOF(1)
                INPUT #1, inputed
                LET addtime = addtime + inputed
                LET amountadd = amountadd + 1
        LOOP
        CLOSE
        LET finalscore = CINT(addtime / amountadd)
        LET finalscore = 200000
        PRINT "Your overall score is"; finalscore; "."
        OPEN "./save/highscor.txt" FOR APPEND AS #1
        PRINT #1, name$
        PRINT #1, finalscore
        CLOSE
        OPEN "./save/highscor.txt" FOR INPUT AS #1
        DO UNTIL EOF(1)
        LET r = r + 1
        INPUT #1, tempname$(r)
        INPUT #1, highscore(r)
        LOOP
        FOR i = 1 TO r
                FOR m = i + 1 TO r
                        IF highscore(i) > highscore(m) THEN SWAP highscore(i), highscore(m): SWAP tempname$(i), tempname$(m)
                NEXT m
        NEXT i
        PRINT
        PRINT "These are the top ten scores:"
        PRINT
        FOR i = 1 TO 10
        PRINT "     "; i; ")  "; tempname$(i); "", "", highscore(i)
        NEXT i
END IF
END

END SUB

