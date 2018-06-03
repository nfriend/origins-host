DECLARE SUB ULTIMATEDEFEAT ()
DECLARE SUB CASTLE ()
DECLARE SUB instructions ()
DECLARE SUB runaway ()
DECLARE SUB surrender ()
DECLARE SUB stoper ()
DECLARE SUB restoregame ()
DECLARE SUB save ()
DECLARE SUB hit ()
DECLARE SUB etie ()
DECLARE SUB people ()
DECLARE SUB a ()
DECLARE SUB Q ()
DECLARE SUB two ()
DECLARE SUB eight ()
DECLARE SUB fight ()
DECLARE SUB lose ()
DECLARE SUB town ()
DECLARE SUB time ()
COMMON SHARED agi, edu, str
COMMON SHARED times, day, yes, etimes
COMMON SHARED food, health, experience, c, r, maxhealth, gold, eedu, eagi, estr
COMMON SHARED dagger$, sword$, shield$, armor$
COMMON SHARED ehealth, emaxhealth
COMMON SHARED what$, totalend, numt, map, b, bb, final, searched
COMMON SHARED timeFactor

'Added in 2018 to allow for CPU time adjustment
'All timer loops will be multiplied by this factor
LET timeFactor = 0.0135

DIM SHARED m$(2000)
DIM SHARED townl(9)
DIM SHARED townw(9)
LET dagger$ = "n"
LET sword$ = "n"
LET sheild$ = "n"
LET armor$ = "n"
CLOSE
CLS
'ULTIMATEDEFEAT
day = 0
times = 0
c = 1
r = 1
food = 20
gold = 10
experience = 0

PALETTE 12, 63
top:
CLS
INPUT "Press ENTER to go to the game, or type in I for instructions.", ie$
IF ie$ = "" THEN GOTO clss
IF ie$ = "i" OR ie$ = "I" THEN instructions: GOTO clss
IF ie$ <> "i" OR ie$ <> "I" OR ie$ <> "" THEN CLS : GOTO top
clss:
CLS

PRINT "You have 21 points to put into 3 different catagories, endurance, strength, and agility."

INPUT "Endurance?  ", edu
INPUT "Strength?  ", str
INPUT "Agility?  ", agi
PRINT

'IF edu + str + agi <> 21 THEN CLS : PRINT "Sorry, but you do not have the correct number of points.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: GOTO top
here:
INPUT "How many towns would you like in your game? (1 - 8)   ", numt
IF numt < 1 OR numt > 8 THEN CLS : PRINT "Sorry, but the maximum number is 8 and the minimum 1": PRINT "Press any ley to continue...": DO WHILE INKEY$ = "": LOOP: GOTO here

map = 1
numt = numt - 1

maxhealth = edu * 5
health = maxhealth

emaxhealth = edu * 5
ehealth = emaxhealth

time


CLS
'CASTLE
FOR i = 0 TO numt
RANDOMIZE TIMER
townw(i) = INT(RND * 80) + 1
townl(i) = INT(RND * 23) + 1
NEXT i

LOCATE c, r
COLOR 15
PRINT CHR$(254)
FOR i = 0 TO numt
LOCATE townl(i), townw(i)
COLOR 9
PRINT CHR$(254)
NEXT i



topofhere:
timechange = CLNG(TIMER) + 10
DO 'UNTIL r$ = "q" OR r$ = "Q"
        IF CLNG(TIMER) > timechange THEN LET day = day + 1: LET food = food - 1: LET timechange = CLNG(TIMER) + 10
        IF food = 0 THEN LET health = health - 7
        IF health = 0 THEN lose
        r$ = INKEY$
        IF r$ = "8" THEN LOCATE c, r: LET searched = 0: COLOR 0: PRINT " ": LET c = c - 1: IF c = 0 THEN LET c = c + 1
        IF r$ = "2" THEN LOCATE c, r: LET searched = 0: COLOR 0: PRINT " ": LET c = c + 1: IF c = 24 THEN LET c = c - 1
        IF r$ = "4" THEN LOCATE c, r: LET searched = 0: COLOR 0: PRINT " ": LET r = r - 1: IF r = 0 THEN LET r = r + 1
        IF r$ = "6" THEN LOCATE c, r: LET searched = 0: COLOR 0: PRINT " ": LET r = r + 1: IF r = 81 THEN LET r = r - 1
        IF r$ = "M" OR r$ = "m" THEN
menutop:
                CLS
                PRINT "What would you like to do?"
                PRINT "     (1) Search for a creature to challenge in a fight"
                PRINT "     (2) Save your game"
                PRINT "     (3) Restore a saved game"
                PRINT "     (4) Exit the game"
                PRINT
                PRINT "     (5) Cancel"
                LOCATE 1, 29
                INPUT "", menu$
               
                IF menu$ = "1" THEN fight
                IF menu$ = "2" THEN save
                IF menu$ = "3" THEN restoregame
                IF menu$ = "4" THEN stoper
                IF menu$ = "5" THEN GOTO finished
                IF menu$ <> "1" AND menu$ <> "2" AND menu$ <> "3" AND menu$ <> "4" AND menu$ <> "5" THEN GOTO menutop
finished:
        END IF

        IF r$ = CHR$(27) THEN stoper
        IF r$ = "4" OR r$ = "8" OR r$ = "2" OR r$ = "6" THEN RANDOMIZE TIMER: de = INT(RND * 20 + 1): IF de = 2 THEN GOTO mapfind
        IF c = bb AND r = b THEN CASTLE
        IF r$ <> "" THEN LET yes = 0
        LOCATE c, r
        COLOR 10
        PRINT CHR$(254)
        FOR s = 0 TO numt
        IF r = townw(s) AND c = townl(s) AND yes <> 1 THEN town
        NEXT s
               

FOR e = 0 TO numt
IF map = 6 THEN GOTO maprando
IF b <> 0 THEN COLOR 12: LOCATE bb, b: PRINT CHR$(219)
LOCATE townl(e), townw(e)
COLOR 9
PRINT CHR$(254)
NEXT e
       
        FOR i = 1 TO times * timeFactor
        NEXT i
                LOCATE 23
                COLOR 15
                PRINT "Day #"; day; "    ";
                IF food > 0 THEN PRINT "Food Supply: "; food; "day(s)   ";
                IF food <= 0 THEN COLOR 12: PRINT "YOU NEED FOOD!     ";
                LET e = health * 100 / maxhealth
                PRINT "Health: "; e; "%    ";
                PRINT "Gold:"; gold; "coins"
LOOP

mapfind:
PRINT "You were wandering around when you found a scrap of paper."
PRINT "You were about to throw it away when you saw something that caught your eye."
PRINT "It was is a peice of the map!"
PRINT "You now have "; map; "map pieces."
GOTO topofhere

maprando:
DO
RANDOMIZE TIMER
b = INT(RND * 80) + 1
bb = INT(RND * 23) + 1
FOR n = 1 TO numt
        IF b <> townl(n) AND bb <> townw(n) AND b <> r AND bb <> c THEN GOTO topofhere
NEXT n
LOOP

SUB a
LOCATE 23, 22
LET e = ehealth * 100 / emaxhealth
PRINT "Health: "; CINT(e); "%    ";

LOCATE 23, 41
LET e = health * 100 / maxhealth
PRINT "Health: "; CINT(e); "%    ";
                      

                        RANDOMIZE TIMER
                        block = INT(RND * 10) + 1
                        FOR u = 43 TO 35 STEP -1
                        LOCATE 16, u
                        COLOR 12
                        PRINT CHR$(219)
                        FOR i = 1 TO times / 40
                        IF block <= 5 THEN LET block = 4: LET eee = 99999999
                        NEXT i
                       
                        eee = eee + i
                       
                        IF eee >= etimes AND block <= 6 THEN
                                LET eblock$ = "YES"
                                COLOR 9
                                LOCATE 14, 35
                                PRINT CHR$(219)
                                FOR uu = 14 TO 18
                                LOCATE uu, 36
                                PRINT CHR$(219)
                                NEXT uu
                                COLOR 12
                        END IF
                        NEXT u

                        IF eblock$ <> "YES" THEN LET hitpower = experience / 2 + str: ehealth = ehealth - hitpower / 2
                        IF dagger$ = "y" THEN LET ehealth = ehealth - 2
                        IF sword$ = "y" THEN LET ehealth = ehealth - 5
LOCATE 23, 22
LET e = ehealth * 100 / emaxhealth
PRINT "Health: "; CINT(e); "%    ";

LOCATE 23, 41
LET e = health * 100 / maxhealth
PRINT "Health: "; CINT(e); "%    ";
                       
                       
                       
                        FOR u = 35 TO 43
                        LOCATE 16, u
                        COLOR 0
                        PRINT CHR$(219)
                        FOR i = 1 TO times / 16
                        NEXT i
                        NEXT u


                                COLOR 0
                                LOCATE 14, 35
                                PRINT CHR$(219)
                                FOR uu = 14 TO 18
                                LOCATE uu, 36
                                PRINT CHR$(219)
                                NEXT uu

END SUB

SUB CASTLE
CLS
PRINT "You follow the directions on the map until you come to the spot it points to."
PRINT "The only problem is, there isn't anything in sight!"
PRINT "The rest of the day you search in vain for the entrance."
PRINT "Finally, you decide that the whole thing must be a prank."
PRINT "Somebody must have made the map, saying that it the entrace to the castle."
PRINT "The next day you walk around, dejected. You decide to make a final search."
PRINT "As you suspected, you find nothing."
PRINT "You start towards the nearest town."
PRINT "All of a sudden, you are falling..."
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
GOTO uip
CLS
COLOR 6
LOCATE 23, 1
PRINT STRING$(80, CHR$(219))
'LOCATE 25, 1
'PRINT STRING$(80, CHR$(219))
COLOR 14
FOR i = 1 TO 22
        COLOR 14
        LOCATE i, 40
        PRINT CHR$(5)
        COLOR 0
        IF i > 1 THEN LOCATE i - 1, 40
        PRINT CHR$(5)
        FOR y = 1 TO 100000 * timeFactor
        NEXT y
NEXT i
COLOR 6
LOCATE 22, 40
PRINT CHR$(219)
FOR i = 1 TO 100000 * timeFactor
NEXT i
LOCATE 22, 39
PRINT CHR$(178)
LOCATE 22, 41
PRINT CHR$(178)
LOCATE 21, 40
PRINT CHR$(178)
LOCATE 22, 38
PRINT CHR$(178)
LOCATE 22, 42
PRINT CHR$(178)
FOR i = 1 TO 100000 * timeFactor
NEXT i
LOCATE 22, 43
PRINT CHR$(177)
LOCATE 22, 44
PRINT CHR$(177)
LOCATE 22, 37
PRINT CHR$(177)
LOCATE 22, 36
PRINT CHR$(177)
LOCATE 21, 39
PRINT CHR$(177)
LOCATE 21, 41
PRINT CHR$(177)
LOCATE 20, 40
PRINT CHR$(177)
LOCATE 21, 38
PRINT CHR$(177)
LOCATE 21, 42
PRINT CHR$(177)
FOR i = 1 TO 100000 * timeFactor
NEXT i
LOCATE 22, 35
PRINT CHR$(176)
LOCATE 22, 45
PRINT CHR$(176)
LOCATE 21, 37
PRINT CHR$(176)
LOCATE 21, 43
PRINT CHR$(176)
LOCATE 20, 39
PRINT CHR$(176)
LOCATE 20, 41
PRINT CHR$(176)
FOR i = 1 TO 100000 * timeFactor
NEXT i
LOCATE 22, 39
PRINT CHR$(177)
LOCATE 22, 41
PRINT CHR$(177)
LOCATE 21, 40
PRINT CHR$(177)
LOCATE 22, 38
PRINT CHR$(177)
LOCATE 22, 42
PRINT CHR$(177)
FOR i = 1 TO 100000 * timeFactor
NEXT i
LOCATE 22, 43
PRINT CHR$(176)
LOCATE 22, 44
PRINT CHR$(176)
LOCATE 22, 37
PRINT CHR$(176)
LOCATE 22, 36
PRINT CHR$(176)
LOCATE 21, 39
PRINT CHR$(176)
LOCATE 21, 41
PRINT CHR$(176)
LOCATE 20, 40
PRINT CHR$(176)
LOCATE 21, 38
PRINT CHR$(176)
LOCATE 21, 42
PRINT CHR$(176)
LOCATE 22, 40
PRINT CHR$(177)
FOR i = 1 TO 100000 * timeFactor
NEXT i
COLOR 0
LOCATE 22, 35
PRINT CHR$(176)
LOCATE 22, 45
PRINT CHR$(176)
LOCATE 21, 37
PRINT CHR$(176)
LOCATE 21, 43
PRINT CHR$(176)
LOCATE 20, 39
PRINT CHR$(176)
LOCATE 20, 41
PRINT CHR$(176)
COLOR 6
FOR i = 1 TO 100000 * timeFactor
NEXT i
LOCATE 22, 39
PRINT CHR$(176)
LOCATE 22, 41
PRINT CHR$(176)
LOCATE 21, 40
PRINT CHR$(176)
LOCATE 22, 38
PRINT CHR$(176)
LOCATE 22, 42
PRINT CHR$(176)
FOR i = 1 TO 100000 * timeFactor
NEXT i
LOCATE 22, 43
PRINT CHR$(176)
LOCATE 22, 44
PRINT CHR$(176)
LOCATE 22, 37
PRINT CHR$(176)
LOCATE 22, 36
PRINT CHR$(176)
LOCATE 21, 39
PRINT CHR$(176)
LOCATE 21, 41
PRINT CHR$(176)
LOCATE 20, 40
PRINT CHR$(176)
LOCATE 21, 38
PRINT CHR$(176)
LOCATE 21, 42
PRINT CHR$(176)
COLOR 6
LOCATE 22, 40
PRINT CHR$(178)
FOR i = 1 TO 100000 * timeFactor
NEXT i
COLOR 0
LOCATE 22, 43
PRINT CHR$(176)
LOCATE 22, 44
PRINT CHR$(176)
LOCATE 22, 37
PRINT CHR$(176)
LOCATE 22, 36
PRINT CHR$(176)
LOCATE 21, 39
PRINT CHR$(176)
LOCATE 21, 41
PRINT CHR$(176)
LOCATE 20, 40
PRINT CHR$(176)
LOCATE 21, 38
PRINT CHR$(176)
LOCATE 21, 42
PRINT CHR$(176)
COLOR 6
LOCATE 22, 40
PRINT CHR$(177)
FOR i = 1 TO 100000 * timeFactor
NEXT i
COLOR 6
LOCATE 22, 40
PRINT CHR$(176)
COLOR 0
LOCATE 22, 39
PRINT CHR$(176)
LOCATE 22, 38
PRINT CHR$(176)
LOCATE 22, 41
PRINT CHR$(176)
LOCATE 22, 42
PRINT CHR$(176)
LOCATE 21, 40
PRINT CHR$(176)
FOR i = 1 TO 100000 * timeFactor
NEXT i
LOCATE 22, 40
COLOR 6
PRINT CHR$(5)
LOCATE 1, 1
COLOR 15
PRINT "You land, startled but unhurt. You brush yourself off..."
FOR u = 1 TO 1000000 * timeFactor
NEXT u
LOCATE 22, 40
COLOR 14
PRINT CHR$(5)
LOCATE 1, 1
COLOR 15
LOCATE 22, 39
PRINT CHR$(127)
PRINT "You grope around in the darknes and finally are able to light a lamp."
FOR u = 1 TO 1000000 * timeFactor
NEXT u
uip:
LOCATE 1, 1
PRINT "You suddenly realize this is Voltauk's underground castle!  It wasn't a hoax!"
PRINT "You are joyful until you remember that Voltauk may be somewhere near."
PRINT "You can't just sit here!  You must go find him!"
d = 40
e = 23
f:
RANDOMIZE TIMER
voltaukw = INT(RND * 80) + 1
voltaukl = INT(RND * 18) + 1
IF voltaukw <= 4 AND voltaukl <= 4 THEN GOTO f
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
voltaukl = 9
voltaukw = 40
CLS
df = TIMER + 60
DO
LOCATE 1, 1
w$ = INKEY$
IF w$ = "8" THEN COLOR 0: LOCATE e, d: PRINT CHR$(5): LET e = e - 1: IF e = 1 THEN LET e = e + 1
IF w$ = "4" THEN COLOR 0: LOCATE e, d: PRINT CHR$(5): LET d = d - 1: IF d = 0 THEN LET d = d + 1
IF w$ = "6" THEN COLOR 0: LOCATE e, d: PRINT CHR$(5): LET d = d + 1: IF d = 80 THEN LET d = d - 1
IF w$ = "2" THEN COLOR 0: LOCATE e, d: PRINT CHR$(5): LET e = e + 1: IF e = 23 THEN LET e = e - 1
IF w$ <> "" THEN
        COLOR 6
        LOCATE e, d
        PRINT CHR$(5)
        IF voltaukl - e < 5 AND voltaukl - e >= -4 AND voltaukw - d < 5 AND voltaukw - d >= -4 THEN GOTO foundhim

END IF
LOOP


'176
'177
'178
foundhim:
LOCATE voltaukl, voltaukw
COLOR 10
PRINT CHR$(21)
FOR i = 1 TO 1000000 * timeFactor
NEXT i
LET final = 1
fight



END SUB

SUB eight
        LOCATE 14, 43
        COLOR 12
        PRINT CHR$(219)

        FOR i = 14 TO 10 STEP -1
        LOCATE i, 42
        PRINT CHR$(219)
        NEXT i
        FOR y = 1 TO times * timeFactor
        NEXT y
        COLOR 0
        LOCATE 14, 43
        PRINT CHR$(219)
        FOR i = 14 TO 10 STEP -1
        LOCATE i, 42
        PRINT CHR$(219)
        NEXT i
END SUB

SUB etie
IF final = 1 THEN GOTO fd
rt = 21
etimes = 5000
DO UNTIL rt = eagi
IF rt = eagi THEN EXIT DO
IF rt <> eagi THEN LET rt = rt - 1: LET etimes = etimes + 50000
LOOP
fd:
IF final = 1 THEN LET etimes = 1000
emaxhealth = eedu * 5
ehealth = emaxhealth
END SUB

SUB fight
IF final = 1 THEN
        LET eagi = 30
        LET estr = 25
        LET eedu = 18
        RANDOMIZE TIMER
        egold = INT(RND * 20000) + 10000
        efood = INT(RND * 100) + 50
        GOTO gofight
END IF
IF searched = 1 THEN
        CLS
        PRINT "You have already searched this area."
        PRINT
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        GOTO dones
END IF
CLS
LOCATE 3, 3
PRINT "Searching"
SLEEP 1
LOCATE 3, 3
PRINT "Searching."
FOR i = 1 TO 100000 * timeFactor
NEXT i
LOCATE 3, 3
PRINT "Searching.."
FOR i = 1 TO 100000 * timeFactor
NEXT i
LOCATE 3, 3
PRINT "Searching..."
FOR i = 1 TO 100000 * timeFactor
NEXT i
RANDOMIZE TIMER
victim = INT(RND * 10) + 1
types = INT(RND * 34) + 1

IF victim > 0 AND victim < 6 THEN PRINT "You did not find anything on you search.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO dones

SELECT CASE types

CASE 1 TO 3
LET what$ = "leprechaun"
GOTO leprechaun
CASE 3 TO 7
LET what$ = "ogre"
GOTO ogre
CASE 7 TO 12
LET what$ = "troll"
GOTO troll
CASE 12 TO 13
LET what$ = "dragon"
GOTO dragon
CASE 13 TO 15
LET what$ = "bear"
GOTO bear
CASE 15 TO 19
LET what$ = "elf"
GOTO elf
CASE 19 TO 24
LET what$ = "gnome"
GOTO gnome
CASE 24 TO 26
LET what$ = "goblin"
GOTO goblin
CASE 26 TO 28
LET what$ = "wolf"
GOTO wolf
CASE 29 TO 30
LET what$ = "witch"
GOTO witch
CASE 30 TO 33
LET what$ = "dwarf"
GOTO dwarf

END SELECT

leprechaun:
LET eexp = 3
LET eedu = 4
LET estr = 4
LET eagi = 12
RANDOMIZE TIMER
egold = INT(RND * 30) + 10
efood = INT(RND * 10) + 2
GOTO fighter

ogre:
LET eexp = 5
LET eedu = 8
LET estr = 9
LET eagi = 4
RANDOMIZE TIMER
egold = INT(RND * 15) + 3
efood = INT(RND * 11) + 3
GOTO fighter

giant:
LET eexp = 7
LET eedu = 10
LET estr = 11
LET eagi = 2
RANDOMIZE TIMER
egold = INT(RND * 30) + 10
efood = INT(RND * 6) + 1
GOTO fighter



troll:
LET eexp = 5
LET eedu = 8
LET estr = 7
LET eagi = 6
RANDOMIZE TIMER
egold = INT(RND * 10) + 1
efood = INT(RND * 10) + 1
GOTO fighter




dragon:
LET eexp = 15
LET eedu = 7
LET estr = 12
LET eagi = 10
RANDOMIZE TIMER
egold = INT(RND * 15) + 1
efood = INT(RND * 3) + 1
GOTO fighter





bear:
LET eexp = 13
LET eedu = 10
LET estr = 10
LET eagi = 3
egold = 0
RANDOMIZE TIMER
efood = INT(RND * 10) + 2
GOTO fighter

elf:
LET eexp = 4
LET eedu = 5
LET estr = 4
LET eagi = 10
RANDOMIZE TIMER
egold = INT(RND * 25) + 10
efood = INT(RND * 7) + 3
GOTO fighter


gnome:
LET eexp = 5
LET eedu = 4
LET estr = 4
LET eagi = 12
RANDOMIZE TIMER
egold = INT(RND * 15) + 1
efood = INT(RND * 3) + 1
GOTO fighter

goblin:
LET eexp = 6
LET eedu = 4
LET estr = 5
LET eagi = 10
efood = 0
RANDOMIZE TIMER
egold = INT(RND * 10) + 1
GOTO fighter

wolf:
LET eexp = 7
LET eedu = 5
LET estr = 8
LET eagi = 10
efood = 1
egold = 0
GOTO fighter

witch:
LET eexp = 4
LET eedu = 5
LET estr = 4
LET eagi = 10
RANDOMIZE TIMER
egold = INT(RND * 15) + 1
efood = INT(RND * 3) + 1
GOTO fighter

dwarf:
LET eexp = 5
LET eedu = 9
LET estr = 10
LET eagi = 4
RANDOMIZE TIMER
egold = INT(RND * 25) + 1
efood = INT(RND * 10) + 1
GOTO fighter

fighter:
'LET eedu = eedu * 5
'LET estr = estr * 2
emaxhealth = edu * 5
ehealth = emaxhealth
RANDOMIZE TIMER
howtosay = INT(RND * 4) + 1
SELECT CASE howtosay
CASE 1
case1:
CLS
PRINT "You were wandering around when you came across a "; what$; ".  It hasn't seen you yet.  Would you like to attack?  Y/N  ";
INPUT "", yn$
IF yn$ = "y" OR yn$ = "Y" THEN GOTO gofight
IF yn$ = "n" OR yn$ = "N" THEN GOTO dones
IF yn$ <> "n" OR yn$ <> "N" OR yn$ <> "y" OR yn$ <> "Y" THEN GOTO case1
CASE 2
case2:
CLS
PRINT "You were walking around when you heard a noise.  You sneaked over to where you  heard it and there you found a "; what$; ".  It is oblivous of your presents.  Would you like to attack?  Y/N  ";
INPUT "", yn$
IF yn$ = "y" OR yn$ = "Y" THEN GOTO gofight
IF yn$ = "n" OR yn$ = "N" THEN GOTO dones
IF yn$ <> "n" OR yn$ <> "N" OR yn$ <> "y" OR yn$ <> "Y" THEN GOTO case2
CASE 3
case3:
CLS
PRINT "You found a "; what$; ".  Attack?  Y/N  ";
INPUT "", yn$
IF yn$ = "y" OR yn$ = "Y" THEN GOTO gofight
IF yn$ = "n" OR yn$ = "N" THEN GOTO dones
IF yn$ <> "n" OR yn$ <> "N" OR yn$ <> "y" OR yn$ <> "Y" THEN GOTO case3
CASE 4
case4:
CLS
PRINT "You came across a dark cave and decided to explore.  Inside you found a sleeping "; what$; ".  Would you like to attack the "; what$; "?  Y/N  ";
INPUT "", yn$
IF yn$ = "y" OR yn$ = "Y" THEN GOTO gofight
IF yn$ = "n" OR yn$ = "N" THEN GOTO dones
IF yn$ <> "n" OR yn$ <> "N" OR yn$ <> "y" OR yn$ <> "Y" THEN GOTO case4
END SELECT


gofight:
LET emaxhealth = ehealth
CALL etie
CLS
fightertop:
LET emaxhealth = ehealth
SCREEN 0
COLOR 0
FOR i = 10 TO 18
LOCATE i, 25
COLOR 9
PRINT STRING$(10, CHR$(219))
NEXT i

FOR i = 10 TO 18
LOCATE i, 44
COLOR 12
PRINT STRING$(10, CHR$(219))
NEXT i

LOCATE 23, 22
LET e = ehealth * 100 / emaxhealth
PRINT "Health: "; e; "%    ";

LOCATE 23, 41
LET e = health * 100 / maxhealth
PRINT "Health: "; e; "%    ";



CLS


people

DO UNTIL ehealth <= 0 OR health <= 0
        y$ = INKEY$
        IF y$ = "a" OR y$ = "A" THEN a
        IF y$ = "q" OR y$ = "Q" THEN Q
        IF y$ = "r" OR y$ = "R" THEN runaway: IF totalend = 1 THEN GOTO dones: GOTO fightertop
        IF y$ = "s" OR y$ = "S" AND s = 0 THEN LET s = s + 1: surrender: IF totalend = 1 THEN GOTO dones: GOTO fightertop
        IF y$ = "2" THEN two
        IF y$ = "8" THEN eight
        IF ehealth <= 0 AND final = 1 THEN ULTIMATEDEFEAT
        IF ehealth <= 0 THEN GOTO win
        IF health <= 0 THEN lose
        RANDOMIZE TIMER
        IF final = 0 THEN y = INT(RND * 900) + 1
        IF final = 1 THEN y = INT(RND * 500) + 1
        IF y = 17 THEN hit

LOCATE 23, 20
LET rr = ehealth * 100 / emaxhealth
PRINT "Health: "; CINT(rr); "%    ";

LOCATE 23, 43
LET e = health * 100 / maxhealth
PRINT "Health: "; CINT(e); "%    ";

LOOP


win:
CLS
COLOR 15
LOCATE 1, 1
PRINT "You have defeated the "; what$; "!"
IF egold = 1 THEN PRINT "  You gained 1 gold coin.  "
IF egold > 1 THEN PRINT "You gained"; egold; "gold coins.  "
IF efood >= 1 THEN PRINT "You also gained a "; efood; "-day food supply!"
IF eexp > 1 THEN PRINT "You gained"; eexp; " experience points."
IF eexp = 1 THEN PRINT "You gained 1 experience point."
LET gold = gold + egold
LET food = food + efood
LET experience = experience + eexp
PRINT
IF gold = 1 THEN PRINT "You now have 1 gold coin."
IF gold = 0 THEN PRINT "You still have no money."
IF gold > 1 THEN PRINT "You now have"; gold; "gold coins."
IF food > 0 THEN PRINT "You have a"; food; "-day food supply."
IF food = 0 THEN PRINT "You have no food.  Go to a town and buy some."
PRINT "You have"; experience; " experience points."
LET e = health * 100 / maxhealth
PRINT "Your health is %"; CINT(e); "."
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS
GOTO dones



dones:
CLS
LET searched = 1
END SUB

SUB hit
RANDOMIZE TIMER
tw = INT(RND * 2) + 1
IF tw = 1 THEN GOTO low
IF tw = 2 THEN GOTO high

low:
                FOR u = 35 TO 43
                LOCATE 16, u
                COLOR 9
                PRINT CHR$(219)
                FOR i = 1 TO times / 32
                e$ = INKEY$
                IF e$ = "8" THEN LET hl$ = "l": GOTO hblock
                IF e$ = "2" THEN GOTO lblock
                IF e$ = "" THEN GOTO ldone
ldone:
                NEXT i
               
                NEXT u

                IF block$ <> "YES" THEN LET health = health - str
                IF shield$ = "y" THEN LET health = health + 2
                IF armor$ = "y" THEN LET ehealth = ehealth + estr / 2


LOCATE 23, 22
LET e = ehealth * 100 / emaxhealth
PRINT "Health: "; CINT(e); "%    ";

LOCATE 23, 41
LET e = health * 100 / maxhealth
PRINT "Health: "; CINT(e); "%    ";
               
               
                FOR u = 43 TO 35 STEP -1
                LOCATE 16, u
                COLOR 0
                PRINT CHR$(219)
                FOR i = 1 TO times / 16
                NEXT i
               
                NEXT u

GOTO fightdone
high:
                FOR u = 35 TO 43
                LOCATE 12, u
                COLOR 9
                PRINT CHR$(219)
                FOR i = 1 TO etimes / 32
                r$ = INKEY$
                IF r$ = "8" THEN GOTO hblock
                IF r$ = "2" THEN LET hl$ = "h": GOTO lblock
hdone:
                NEXT i
               
                NEXT u

                IF block$ <> "YES" THEN LET health = health - str
                IF shield$ = "y" THEN LET health = health + 2
                IF armor$ = "y" THEN LET ehealth = ehealth + estr / 2
               
LOCATE 23, 22
LET e = ehealth * 100 / emaxhealth
PRINT "Health: "; CINT(e); "%    ";

LOCATE 23, 41
LET e = health * 100 / maxhealth
PRINT "Health: "; CINT(e); "%    ";
               
               
                FOR u = 43 TO 35 STEP -1
                LOCATE 12, u
                COLOR 0
                PRINT CHR$(219)
                FOR i = 1 TO times / 16
                NEXT i
              
                NEXT u
GOTO fightdone

hblock:
        LET block$ = "YES"
        LET hl$ = "h"
        LOCATE 14, 43
        COLOR 12
        PRINT CHR$(219)
       
        FOR i = 14 TO 10 STEP -1
        LOCATE i, 42
        PRINT CHR$(219)
        NEXT i
IF hl$ = "l" THEN GOTO ldone
GOTO hdone
        

lblock:
        LET block$ = "YES"
        LET hl$ = "l"
        LOCATE 14, 43
        COLOR 12
        PRINT CHR$(219)
       
        FOR w = 14 TO 18
        LOCATE w, 42
        PRINT CHR$(219)
        NEXT w

IF hl$ = "h" THEN GOTO hdone
GOTO ldone
       
       
        



fightdone:
        COLOR 0
        LOCATE 14, 43
        PRINT CHR$(219)
        FOR rrr = 10 TO 14
        LOCATE rrr, 42
        PRINT CHR$(219)
        NEXT rrr

        COLOR 0
        LOCATE 14, 43
        PRINT CHR$(219)
        FOR i = 14 TO 18
        LOCATE i, 42
        PRINT CHR$(219)
        NEXT i
LOCATE 23, 22
LET e = ehealth * 100 / emaxhealth
PRINT "Health: "; CINT(e); "%    ";

LOCATE 23, 41
LET e = health * 100 / maxhealth
PRINT "Health: "; CINT(e); "%    ";



END SUB

SUB instructions
CLS
PRINT "The object of the game is to find the 5 map pieces that lead to the Voltauk."
PRINT "Voltuak is the supreme enemy that holds the whole land under fear."
PRINT "When you find all 5 map pieces, a red square will show up on the screen."
PRINT "The square is the entrance to Voltuak's underground palace."
PRINT
PRINT "To move around, use the number pad.  (Make sure your Num Lock is on)"
PRINT "8 is up, 2 is down, 4 is left and 6 is right."
PRINT "To pick a fight with somebody, press F.  (for Fight)"
PRINT "A lower punch is A and a high one is Q."
PRINT "When the computer throws a punch at you, you must block it."
PRINT "To block, 8 is upper block and 2 is lower block."
PRINT "To try to run away during a fight, press R."
PRINT "To surrender to your enemy, press S."
PRINT
PRINT "To save your game, press S when you are in the country side."
PRINT "To retrieve your game, press r and select a game from the list."
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS
PRINT "Agility, strength, endurance, and experience determine your character."
PRINT "Agility is how fast you move."
PRINT "This the higher the agility, the faster you can move across the map."
PRINT "It also determines how fast you can punch."
PRINT "Strength is how how much damage you can to to your emeny when fighting."
PRINT "Endurance is how long you can last without dying."
PRINT "Experience is how skilled you are at fighting."
PRINT "The more experience you have, the more damage you will do to your enemy."
PRINT "You gain experience by fighting off enemies."
PRINT

PRINT "The blue square on the screen are towns."
PRINT "There you can buy things, take lessons to improve yourself, or stay at the inn."
PRINT
PRINT "Make sure you have enough food, or else you will starve."
PRINT "Press any key to go to the game..."
DO WHILE INKEY$ = ""
LOOP
END SUB

SUB lose
CLS
LOCATE 12, 36
COLOR 12
PRINT "You lost."
PLAY "t200"
PLAY "<"
music$ = "l2cl4cmll2fffl2cl4fmll2aaa"
PLAY music$
SLEEP 1
END
END SUB

SUB people
FOR i = 10 TO 18
LOCATE i, 25
COLOR 9
PRINT STRING$(10, CHR$(219))
NEXT i

FOR i = 10 TO 18
LOCATE i, 44
COLOR 12
PRINT STRING$(10, CHR$(219))
NEXT i

END SUB

SUB Q
LOCATE 23, 22
LET e = ehealth * 100 / emaxhealth
PRINT "Health: "; CINT(e); "%    ";

LOCATE 23, 41
LET e = health * 100 / maxhealth
PRINT "Health: "; CINT(e); "%    ";
               
                RANDOMIZE TIMER
                block = INT(RND * 10) + 1
                FOR u = 44 TO 35 STEP -1
                LOCATE 12, u
                COLOR 12
                PRINT CHR$(219)
                FOR i = 1 TO (times / 32) * timeFactor
                IF block <= 5 THEN LET block = 4: LET eee = 99999999
                NEXT i
               
                eee = eee + 1

                IF eee >= etimes AND block <= 6 THEN
                        LET eblock$ = "YES"
                        COLOR 9
                        LOCATE 14, 35
                        PRINT CHR$(219)
                        FOR uu = 10 TO 14
                        LOCATE uu, 36
                        PRINT CHR$(219)
                        NEXT uu
                        COLOR 12
                        END IF
                NEXT u

                IF eblock$ <> "YES" THEN LET hitpower = experience / 2 + str: ehealth = ehealth - hitpower / 2
                IF dagger$ = "y" THEN LET ehealth = ehealth - 2
                IF sword$ = "y" THEN LET ehealth = ehealth - 5
               
LOCATE 23, 22
LET e = ehealth * 100 / emaxhealth
PRINT "Health: "; CINT(e); "%    ";

LOCATE 23, 41
LET e = health * 100 / maxhealth
PRINT "Health: "; CINT(e); "%    ";
               
               
                COLOR 0
                FOR u = 35 TO 43
                LOCATE 12, u
                PRINT CHR$(219)
                COLOR 0
                PRINT CHR$(219)
                FOR i = 1 TO (times / 32) * timeFactor
                NEXT i
                NEXT u

                COLOR 0
                FOR n = 10 TO 14
                LOCATE n, 36
                PRINT CHR$(219)
                NEXT n
                LOCATE 14, 35
                PRINT CHR$(219)
END SUB

SUB restoregame
CLOSE
CLS
restoretop:
OPEN "./save/ADVNTURE/names.txt" FOR INPUT AS #1
DO UNTIL EOF(1)
INPUT #1, m$(t)
PRINT m$(t)
t = t + 1
LOOP
CLOSE
t = 0
PRINT
PRINT "Please choose a game to restore, (using the list above)  or push c to cancel.  "
INPUT "", filename$
IF filename$ = "c" OR filename$ = "C" THEN GOTO restoredone
DO UNTIL m$(t) = ""
t = t + 1
IF UCASE$(m$(t)) = UCASE$(filename$) THEN GOTO opener
LOOP
PRINT "Sorry, but there is no game called "; filename$; ".  Please choose a name of the list.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO restoretop


opener:
CLOSE
LET file$ = "./save/ADVNTURE/" + UCASE$(filename$) + ".txt"
OPEN file$ FOR INPUT AS #1
INPUT #1, agi
INPUT #1, edu
INPUT #1, str
INPUT #1, times
INPUT #1, day
INPUT #1, food
INPUT #1, health
INPUT #1, maxhealth
INPUT #1, c
INPUT #1, r
INPUT #1, gold
INPUT #1, dagger$
INPUT #1, sword$
INPUT #1, sheild$
INPUT #1, armor$
INPUT #1, numt
FOR i = 1 TO numt
INPUT #1, townw(i)
INPUT #1, townl(i)
NEXT i
INPUT #1, map
INPUT #1, b
INPUT #1, bb
restoredone:
CLOSE
CLS
END SUB

SUB runaway
COLOR 15
CLS
IF agi > eagi THEN LET crun = agi - eagi: GOTO aa
IF agi < eagi THEN LET crun = eagi - agi: GOTO ae


aa:
RANDOMIZE TIMER
p = INT(RND * crun) + 1
IF crun = 1 OR crun = 2 THEN GOTO caught
PRINT "You outran the"; what$; "!"
GOTO rdone

ae:
RANDOMIZE TIMER
p = INT(RND * crun) + 1
IF crun = 1 OR crun = 2 THEN PRINT "You ran away from the "; what$; "!": GOTO rdone
GOTO caught



caught:
PRINT "Oh no!  You've been caught!"
surrender
rdone:
END SUB

SUB save
CLOSE
savetop:
CLS
INPUT "File name  (type in c to cancel)  ?  ", file$
IF file$ = "c" OR file$ = "C" THEN GOTO saveend
IF LEN(file$) > 8 THEN PRINT "Sorry, but your name cannot be larger than 8 characters.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: GOTO savetop
CLOSE
OPEN "./save/ADVNTURE/names.txt" FOR INPUT AS #1
DO UNTIL EOF(1)
INPUT #1, ju$
IF UCASE$(ju$) = UCASE$(file$) THEN PRINT "Sorry, but there already is a file named '"; file$; ".'": PRINT "Press any ley to continue...": DO WHILE INKEY$ = "": LOOP: GOTO savetop
LOOP
CLOSE

OPEN "./save/ADVNTURE/names.txt" FOR APPEND AS #1
PRINT #1, file$
CLOSE

files$ = "./save/ADVNTURE/" + file$ + ".txt"
OPEN files$ FOR OUTPUT AS #1
PRINT #1, agi
PRINT #1, edu
PRINT #1, str
PRINT #1, times
PRINT #1, day
PRINT #1, food
PRINT #1, health
PRINT #1, maxhealth
PRINT #1, c
PRINT #1, r
PRINT #1, gold
PRINT #1, dagger$
PRINT #1, sword$
PRINT #1, sheild$
PRINT #1, armor$
PRINT #1, numt
FOR m = 1 TO numt
PRINT #1, townw(m)
PRINT #1, townl(m)
NEXT m
PRINT #1, map
PRINT #1, b
PRINT #1, bb
saveend:
CLOSE
CLS
END SUB

SUB stoper
CLS
INPUT "Would you like to save you game before exiting? Y/N  (press c to cancel)  "; exiter$
IF exiter$ = "y" OR exiter$ = "Y" THEN save
IF exiter$ = "n" OR exiter$ = "N" THEN END
IF exiter$ = "c" OR exiter$ = "C" THEN CLS : GOTO ddone
ddone:
END SUB

SUB surrender
IF what$ = "dragon" OR what$ = "wolf" OR what$ = "bear" THEN PRINT "You can't surrender to a "; what$; "!": SLEEP 2: GOTO no
RANDOMIZE TIMER
free = INT(RND * 5) + 3
IF free = 1 OR free = 3 OR free = 5 THEN GOTO setfree
IF free = 2 OR free = 4 THEN GOTO no


setfree:
CLS
COLOR 15
l:
PRINT "The "; what$; " says to you, 'All right I'll let you go free, but not until you pay up!"
INPUT "Do you agree to pay the ransom for your freedom?  Y/N  ", f$
IF f$ = "y" OR f$ = "Y" THEN CLS : GOTO yes
IF f$ = "n" OR f$ = "N" THEN GOTO no
CLS
GOTO l
yes:
DO
RANDOMIZE TIMER
l = INT(RND * 6) + 1
IF l = 1 AND food <> 0 THEN GOTO food
IF l = 2 AND gold <> 0 THEN GOTO money
IF l = 3 AND sword$ = "y" THEN GOTO sword
IF l = 4 AND dagger$ = "y" THEN GOTO dagger
IF l = 5 AND armor$ = "y" THEN GOTO armor
IF l = 6 AND shield$ = "y" THEN GOTO shield
IF l = 7 AND what$ = "dwarf" OR what$ = "leprechaun" OR what$ = "gnome" OR what$ = "elf" THEN GOTO kind
IF food = 0 AND gold = 0 AND sword$ <> "y" AND dagger$ <> "y" AND armor$ <> "y" AND shield$ <> "y" THEN PRINT "'Well!,' says the "; what$; ", 'I see you don't have anything!  I guess your on your own then!": GOTO no
LOOP

food:
RANDOMIZE TIMER
wq = INT(RND * food) + 1
PRINT "If you give me a "; wq; "-day food supply, I will let you go free."
INPUT "Do you agree?  Y/N  ", qa$
IF qa$ = "y" OR qa$ = "Y" THEN LET food = food - c:  LET totalend = 1: GOTO no
IF qa$ = "n" OR qa$ = "N" THEN people: GOTO no
CLS : GOTO food

money:
RANDOMIZE TIMER
wq = INT(RND * gold) + 1
IF c > 1 THEN PRINT "If you give me "; wq; "gold coins, I will let you go free."
IF c = 1 THEN PRINT "If you give me 1 gold coin, I will let you go free."
INPUT "Do you agree?  Y/N  ", qa$
IF qa$ = "y" OR qa$ = "Y" THEN LET gold = gold - c:  LET totalend = 1: GOTO no
IF qa$ = "n" OR qa$ = "N" THEN GOTO no
CLS : GOTO money

dagger:
PRINT "You have a nice dagger there!  I'll take that!"
INPUT "Do you agree?  Y/N  ", qa$
IF qa$ = "y" OR qa$ = "Y" THEN LET dagger$ = "n":  LET totalend = 1: GOTO no
IF qa$ = "n" OR qa$ = "N" THEN GOTO no
CLS : GOTO dagger

sword:
PRINT "I take your sword in return for your freedom."
INPUT "Do you agree?  Y/N  ", qa$
IF qa$ = "y" OR qa$ = "Y" THEN LET sword$ = "n":  LET totalend = 1: GOTO no
IF qa$ = "n" OR qa$ = "N" THEN GOTO no
CLS : GOTO sword

armor:
PRINT "Take off your suit of armor.  It's mine now!"
INPUT "Do you agree?  Y/N  ", qa$
IF qa$ = "y" OR qa$ = "Y" THEN LET armor$ = "n":  LET totalend = 1: GOTO no
IF qa$ = "n" OR qa$ = "N" THEN GOTO no
CLS : GOTO armor

shield:
PRINT "You have a very nice shield there.  I think that would do for your freedom."
INPUT "Do you agree?  Y/N  ", qa$
IF qa$ = "y" OR qa$ = "Y" THEN LET shield$ = "n":  LET totalend = 1: GOTO no
IF qa$ = "n" OR qa$ = "N" THEN GOTO no
CLS : GOTO shield

kind:
PRINT "Aww!  I've always been a softy at the heart!  I can't rob you!"
PRINT "Just don't cause any more trouble 'round here!"
GOTO no

no:
CLS
END SUB

SUB time
t = 21
times = 5000
DO UNTIL t = agi
IF t = agi THEN EXIT DO
IF t <> agi THEN LET t = t - 1: LET times = times + 50000
LOOP
END SUB

SUB town
RANDOMIZE TIMER
map1 = INT(RND * 10) + 1
IF map1 = 3 THEN GOTO mappiece
there:
CLS
PRINT "The citizens greet you warmly and listen intently as they hear your enthralling tale of your travels.";
hhere:
LOCATE 11, 1
PRINT "You have"; gold; "gold coins."
LOCATE 6, 1
PRINT "(1) Purchase items"
PRINT "(2) Stay overnight at the inn"
PRINT "(3) Take lessons from a master swordsman"
IF map = 6 THEN PRINT "(4) Leave town"
IF map <> 6 THEN PRINT "(4) Ask about the map peice(s)": PRINT "(5) Leave Town"

LOCATE 4, 1
INPUT "What would you like to do?  ", qq$
IF qq$ = "1" THEN GOTO buy
IF qq$ = "2" THEN GOTO stay
IF qq$ = "3" THEN GOTO lessons
IF qq$ = "4" AND map = 6 THEN GOTO done
IF qq$ = "4" AND map <> 6 AND askaboutmap < 1 OR askaboutmap > 1 THEN GOTO mapask
IF qq$ = "4" AND map <> 6 AND askaboutmap = 1 THEN CLS : PRINT "You have already asked about the map peice(s).": PRINT : PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO hhere
IF qq$ = "5" AND map <> 6 THEN GOTO done
GOTO there


stay:
CLS
IF gold < 5 THEN PRINT "Sorry, but you don't have enough money": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: GOTO there
INPUT "The stay will cost you 5 gold coins.  Proceed?  Y/N   ", syn$
IF syn$ = "y" OR syn$ = "Y" THEN
        LET day = day + 1
        LET health = health + 15
        LET gold = gold - 5
        IF health > maxhealth THEN LET health = maxhealth
        CLS
        PRINT "You enjoy a refreshing night at the local inn."
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        GOTO there
END IF
IF syn$ = "n" OR syn$ = "N" THEN GOTO there
GOTO there


buy:
CLS
LOCATE 3, 3

PRINT "If you would just like to look around, press 0."
PRINT
PRINT "(1) A five-day supply of food ", "5 gold coins"
PRINT "(2) A ten-day supply of food  ", "10 gold coins"
PRINT "(3) A 50-day supply of food   ", "45 gold coins"
PRINT "(4) A dagger                  ", "20 gold coins"
PRINT "(5) A sword                   ", "60 gold coins"
PRINT "(6) A shield                  ", "30 gold coins"
PRINT "(7) A suit of armor           ", "60 gold coins"
PRINT "(8) A small medicine pack     ", "15 gold coins"
PRINT "(9) A large medicine pack     ", "35 gold coins"
PRINT
PRINT "You have"; gold; "gold coins."
PRINT
INPUT "What would you like to buy?  ", buy
SELECT CASE buy
       
        CASE 0
        GOTO there

        CASE 1
        IF gold < 5 THEN PRINT "Sorry, but you don't have enough money.": GOTO buy
        LET food = food + 5
        LET gold = gold - 5
c1:
        INPUT "Would you like to buy other items?  Y/N   ", well$
        IF well$ = "y" OR well$ = "Y" THEN GOTO buy
        IF well$ = "n" OR well$ = "N" THEN GOTO there
        IF well$ = "y" OR well$ = "Y" OR well$ = "n" OR well$ = "N" THEN CLS : GOTO c1
       
        CASE 2
        IF gold < 10 THEN PRINT "Sorry, but you don't have enough money.": GOTO buy
        LET food = food + 10
        LET gold = gold - 10
c2:
        INPUT "Would you like to buy other items?  Y/N   ", well$
        IF well$ = "y" OR well$ = "Y" THEN GOTO buy
        IF well$ = "n" OR well$ = "N" THEN GOTO there
        IF well$ = "y" OR well$ = "Y" OR well$ = "n" OR well$ = "N" THEN CLS : GOTO c2

        CASE 3
        IF gold < 45 THEN PRINT "Sorry, but you don't have enough money.": GOTO buy
        LET food = food + 50
        LET gold = gold - 45
c3:
        INPUT "Would you like to buy other items?  Y/N   ", well$
        IF well$ = "y" OR well$ = "Y" THEN GOTO buy
        IF well$ = "n" OR well$ = "N" THEN GOTO there
        IF well$ = "y" OR well$ = "Y" OR well$ = "n" OR well$ = "N" THEN CLS : GOTO c3

        CASE 4
        IF gold < 20 THEN PRINT "Sorry, but you don't have enough money.": GOTO buy
        LET dagger$ = "y"
        LET gold = gold - 20
c4:
        INPUT "Would you like to buy other items?  Y/N   ", well$
        IF well$ = "y" OR well$ = "Y" THEN GOTO buy
        IF well$ = "n" OR well$ = "N" THEN GOTO there
        IF well$ = "y" OR well$ = "Y" OR well$ = "n" OR well$ = "N" THEN CLS : GOTO c4
       
        CASE 5
        IF gold < 60 THEN PRINT "Sorry, but you don't have enough money.": GOTO buy
        LET sword$ = "y"
        LET gold = gold - 60
c5:
        INPUT "Would you like to buy other items?  Y/N   ", well$
        IF well$ = "y" OR well$ = "Y" THEN GOTO buy
        IF well$ = "n" OR well$ = "N" THEN GOTO there
        IF well$ = "y" OR well$ = "Y" OR well$ = "n" OR well$ = "N" THEN CLS : GOTO c5
      
        CASE 6
        IF gold < 30 THEN PRINT "Sorry, but you don't have enough money.": GOTO buy
        LET sheild$ = "y"
        LET gold = gold - 30
c6:
        INPUT "Would you like to buy other items?  Y/N   ", well$
        IF well$ = "y" OR well$ = "Y" THEN GOTO buy
        IF well$ = "n" OR well$ = "N" THEN GOTO there
        IF well$ = "y" OR well$ = "Y" OR well$ = "n" OR well$ = "N" THEN CLS : GOTO c6
      
        CASE 7
        IF gold < 60 THEN PRINT "Sorry, but you don't have enough money.": GOTO buy
        LET armor$ = "y"
        LET gold = gold - 60
c7:
        INPUT "Would you like to buy other items?  Y/N   ", well$
        IF well$ = "y" OR well$ = "Y" THEN GOTO buy
        IF well$ = "n" OR well$ = "N" THEN GOTO there
        IF well$ = "y" OR well$ = "Y" OR well$ = "n" OR well$ = "N" THEN CLS : GOTO c7
      
        CASE 8
        IF gold < 15 THEN PRINT "Sorry, but you don't have enough money.": GOTO buy
        LET heath = heath + 20
        IF heath > maxhealth THEN LET health = maxhealth
        LET gold = gold - 15
c8:
        INPUT "Would you like to buy other items?  Y/N   ", well$
        IF well$ = "y" OR well$ = "Y" THEN GOTO buy
        IF well$ = "n" OR well$ = "N" THEN GOTO there
        IF well$ = "y" OR well$ = "Y" OR well$ = "n" OR well$ = "N" THEN CLS : GOTO c8
       
        CASE 9
        IF gold < 35 THEN PRINT "Sorry, but you don't have enough money.": GOTO buy
        LET heath = heath + 40
        IF heath > maxhealth THEN LET health = maxhealth
        LET gold = gold - 35
c9:
        INPUT "Would you like to buy other items?  Y/N   ", well$
        IF well$ = "y" OR well$ = "Y" THEN GOTO buy
        IF well$ = "n" OR well$ = "N" THEN GOTO there
        IF well$ = "y" OR well$ = "Y" OR well$ = "n" OR well$ = "N" THEN CLS : GOTO c9
END SELECT

lessons:
CLS
PRINT "A master swordsman is in the area and agrees to give you lessons."
PRINT "You can chose to impove your agility, endurance, strength, or experience."
PRINT "They will cost a total of 30 gold coins."
PRINT
u:
INPUT "Do you still want to take lessons?  Y/N  ", v$
IF v$ = "n" OR v$ = "N" THEN GOTO done
IF v$ = "y" OR v$ = "Y" THEN GOTO nowlesson
CLS
GOTO u

nowlesson:
CLS
IF gold < 30 THEN PRINT "You don't have enough money.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO hhere
LET gold = gold - 30
LOCATE 3, 1
PRINT "(1) Agility   ", "Will gain 3 points"
PRINT "(2) Endurance ", "Will gain 3 points"
PRINT "(3) Strength  ", "Will gain 4 points"
PRINT "(3) Experience", "Will gain 4 points"
LOCATE 8, 1
INPUT "What would you like to improve?", w$
IF w$ = "1" THEN
        CLS
        LET agi = agi + 3
        LET day = day + 30
        PRINT "You spend the next month training hard and working on you form."
        PRINT "The teacher you chose is an execelent teacher and you improve greatly."
        PRINT "You agility is now "; agi; "."
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        CLS
        GOTO hhere
END IF
IF w$ = "2" THEN
        CLS
        LET edu = edu + 3
        LET day = day + 30
        PRINT "You work hard for the next month running long distances and other excercises."
        PRINT "The trainer makes you work very hard and now your endurance is "; edu; "!"
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        CLS
        GOTO hhere

END IF
IF w$ = "3" THEN
        CLS
        LET str = str + 4
        LET day = day + 30
        PRINT "The next month is a hard one.  You lift weights and work on your sword skills."
        PRINT "The swordsman tells you that you are one of the most skilled he's ever seen!"
        PRINT "You strength is now "; str; "."
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        CLS
        GOTO hhere
END IF
IF w$ = "4" THEN
        CLS
        LET experience = experience + 4
        LET day = day + 30
        PRINT "You gradually bring up your experience over the next month."
        PRINT "You work hard at your skills from sunup to sundown."
        PRINT "Your experience is now "; experience; "!"
        DO WHILE INKEY$ = ""
        LOOP
        CLS
        GOTO hhere
END IF
IF w$ <> "1" OR w$ <> "2" OR w$ <> "3" OR w$ <> "4" THEN GOTO nowlesson
CLS


mappiece:
CLS
PRINT "After you had been greeted, you took a walk through the town."
PRINT "You run into a man about your age and you start a conversation."
PRINT "After a while, your conversation turns to the great and evil Voltauk."
PRINT "(Note - If you've never hear of the Voltauk, check the instructions next time)"
PRINT "He shows you a piece of a map that supposedly leads to Voltauak's castle."
IF map = 1 THEN PRINT "You try to conceal your excitement as you take out your map piece."
IF map > 1 THEN PRINT "You try to conceal your excitement as you take out your map pieces."
map = map + 1
PRINT "They all fit together!!!"
PRINT "After some pleading, he agrees to give it to you."
PRINT "You now have "; map; "map pieces."
IF map < 6 THEN PRINT "Only "; 6 - map; " more pieces until you find the whole map!"
IF map = 6 THEN PRINT "You now have all six pieces!"
PRINT
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS
GOTO hhere


mapask:
LET askaboutmap = 1
CLS
PRINT "You ask about the remaining map pieces.";
RANDOMIZE TIMER
pl = INT(RND * 15) + 1
IF pl = 5 THEN PRINT "An ederly man walks over to you.  ": PRINT "He says, 'I don't know if this is what your looking for, but here's this.": PRINT "My grandfather gave it to me before he died.  I never knew what is was.'": PRINT "He gives it to you."
IF pl = 6 THEN PRINT "A young boy walks up to you.": PRINT "He says, 'I don't know if this is what your looking for, but here's this.": PRINT "My father gave it to me .  I never knew what is was.'": PRINT "He gives it to you."
IF pl = 7 THEN PRINT "A middle-aged women walks up to you.": PRINT "She says, 'I don't know if this is what your looking for, but here's this.": PRINT "My grandmother gave it to me before she died.  I never knew what is was.'": PRINT "She gives it to you."
IF pl >= 5 AND pl <= 7 THEN
        IF map > 1 THEN PRINT "You take out your map pieces and put them together...  They match!"
        IF map = 1 THEN PRINT "You take out your map piece and put them together...  They match!"
        map = map + 1
        PRINT "You now have "; map; "map pieces."
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        CLS
ELSE
        PRINT "  Nobody knows anything about the map."
        DO WHILE INKEY$ = ""
        LOOP
CLS
END IF

GOTO there

done:
LET yes = 1
CLS
END SUB

SUB two
                COLOR 12
                FOR i = 18 TO 14 STEP -1
                LOCATE i, 42
                PRINT CHR$(219)
                NEXT i
                COLOR 12
                LOCATE 14, 43
                PRINT CHR$(219)
             
                FOR y = 1 TO times * timeFactor
                NEXT y

                COLOR 0
                LOCATE 14, 43
                PRINT CHR$(219)
                FOR i = 14 TO 18
                LOCATE i, 42
                PRINT CHR$(219)
                NEXT i
                

END SUB

SUB ULTIMATEDEFEAT
CLS
PRINT "The monster falls to the ground and starts to crawl away."
PRINT "But knowing that this is no time for mercy, you prepare for the final blow."
PRINT "You put all your strength into the last blow."
PRINT "He wriggles, and then flops down, dead."
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS
PRINT "You have defeated the mighty Voltauk!!!"
PRINT "You search around the castle and find the monster's treasure room."
PRINT "You find "; egold; "gold and a "; efood; "-day food supply!!!"
PRINT "You also take the monster's golden wristband as proof that you defeated him."
PRINT "You hike out of the castle, where a small crowd has formed."
PRINT "A dwarf had seen you go down into the castle and had brought some friends."
PRINT "You show them the wristband and they yell and dance in delight!"
PRINT "The crowd brings you to the nearby town."
PRINT "The people there crown you King!"
PRINT "You are given the highest honors and all the people in the land come to a feast."
PRINT "The feast is so incredible that people tell about for hundreds of years!"
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS
SCREEN 1
SLEEP 2
LOCATE 12, 17
PRINT "YOU WIN!"
SLEEP 3
SCREEN 0
END
END SUB

