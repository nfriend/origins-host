'                                                                            '
'                                  YAHTZEE                                   '
'                                                                            '
'                                                                            '
'                                                                            '
'                                                                            '
'                                                                            '
'                                                                            '
'                      Druk op Shift + F5 om te spelen                       '
'                      Druk op Alt, B, A om te stoppen                       '
'                                                                            '
'                                                                            '
'                                                                            '
'                                                                            '
'                                                                            '
'                                                                            '
'                                                                            '
'                                                                            '
'                                                                            '
'                                                                            '
DECLARE SUB geluid ()
DECLARE SUB totalen (spelers%)
DECLARE SUB scorekaart (speler%)
DECLARE SUB dobbelsteen (dob)
DECLARE FUNCTION score! (x!, y!, dobbel!())
COMMON SHARED kaart(), naam$()

opnieuw:
CLEAR

ON KEY(2) GOSUB dinges

KEY(2) ON

SCREEN 12: CLS
DIM kaart(1, 6, 1, 3)
DIM naam$(3)
herrie% = NOT (0)

RANDOMIZE (TIMER)

OPEN "yahtzee.hi" FOR INPUT AS #1
INPUT #1, hiscore$
INPUT #1, hiscore%
CLOSE

LOCATE 10, 37: PRINT "Yahtzee"
LOCATE 24, 20: COLOR 14: PRINT "F2 = Sound On/Off": COLOR 15
DO: LOCATE 15, 10: PRINT STRING$(40, " "): LOCATE 15, 20: INPUT "How many Players (1-4)"; spelers%: LOOP WHILE spelers% < 1 OR spelers% > 4

spelers% = spelers% - 1

FOR i% = 0 TO spelers%
       
        LOCATE 17 + i%, 10
        PRINT "Name Player"; i% + 1; : INPUT " : ", naam$(i%)

        IF naam$(i%) = "" THEN naam$(i%) = "Player " + CHR$(i% + 49)

NEXT i%

FOR i% = 1 TO 50
        SWAP naam$(INT((spelers% + 1) * RND)), naam$(INT((spelers% + 1) * RND))
NEXT i%


gedobbel:

CLS
SCREEN 13

COLOR 2 + 2 * speler%: LOCATE 2, 1: PRINT naam$(speler%): COLOR 15
COLOR 235: LOCATE 1, 10: PRINT "Hiscore of "; hiscore$; : PRINT USING " : ###"; hiscore%: COLOR 15



LINE (10, 20)-(290, 70), 120, BF

IF a$ = "s" THEN beurt = beurt - 1

FOR i% = 1 TO 5
      
        IF NOT vast(i%) AND a$ <> "s" AND b$ <> CHR$(27) THEN dobbel(i%) = INT(6 * RND) + 1: IF herrie% THEN geluid
        dobbelsteen (dobbel(i%))

NEXT i%

b$ = ""

LOCATE 10, 5: PRINT "Hold which? ( Enter = throw )"
LOCATE 11, 17: PRINT "( Space = keep )"
LOCATE 12, 17: PRINT "(  's'  = scorecard)"

scorekaart (speler%)

COLOR 14
FOR i% = 1 TO 5
       
        LOCATE 8, 6 * i%
        IF vast(i%) THEN PRINT "HELD" ELSE PRINT "    "

NEXT i%
COLOR 15


DO
        DO: a$ = INKEY$: LOOP UNTIL a$ = "1" OR a$ = "2" OR a$ = "3" OR a$ = "4" OR a$ = "5" OR a$ = CHR$(13) OR a$ = CHR$(27) OR a$ = " " OR beurt = 2 OR a$ = "s"

        IF a$ = "1" THEN vast(1) = NOT vast(1)
        IF a$ = "2" THEN vast(2) = NOT vast(2)
        IF a$ = "3" THEN vast(3) = NOT vast(3)
        IF a$ = "4" THEN vast(4) = NOT vast(4)
        IF a$ = "5" THEN vast(5) = NOT vast(5)

        FOR i% = 1 TO 5
                COLOR 14
                LOCATE 8, 6 * i%
                IF vast(i%) THEN PRINT "HELD" ELSE PRINT "    "
        NEXT i%

        COLOR 15
        IF a$ = CHR$(27) THEN END

LOOP UNTIL a$ = CHR$(13) OR a$ = " " OR beurt = 2 OR a$ = "s"
beurt = beurt + 1

IF a$ = "s" THEN totalen (spelers%): GOTO gedobbel

IF a$ = CHR$(13) AND beurt <> 3 GOTO gedobbel

posx = 0: posy = 0
LOCATE 10, 1: PRINT STRING$(40, " ")
LOCATE 11, 1: PRINT STRING$(40, " ")
LOCATE 12, 1: PRINT STRING$(40, " ")

LOCATE 11, 4: PRINT "Make your choice:"

LOCATE 14, 3: COLOR 14: PRINT CHR$(16): COLOR 15

scorekaart (speler%)

keuze:

DO
       
        DO: b$ = INKEY$: LOOP UNTIL b$ = CHR$(0) + "H" OR b$ = CHR$(0) + "P" OR b$ = CHR$(0) + "K" OR b$ = CHR$(0) + "M" OR b$ = CHR$(13) OR b$ = CHR$(27)
      
        IF b$ = CHR$(27) AND beurt < 3 THEN beurt = beurt - 1: GOTO gedobbel
       
        IF posy < 6 THEN LOCATE 14 + posy, 3 + 13 * posx: PRINT " "
        IF posy = 6 THEN LOCATE 21, 9: PRINT " "

        IF b$ = CHR$(0) + "H" THEN posy = posy - 1
        IF b$ = CHR$(0) + "P" THEN posy = posy + 1
        IF b$ = CHR$(0) + "K" THEN posx = posx - 1
        IF b$ = CHR$(0) + "M" THEN posx = posx + 1

        IF posy < 0 THEN posy = 0: BEEP
        IF posy > 6 THEN posy = 6: BEEP
        IF posx < 0 THEN posx = 0: BEEP
        IF posx > 1 THEN posx = 1: BEEP
       
        IF posy < 6 THEN LOCATE 14 + posy, 3 + 13 * posx: COLOR 14: PRINT CHR$(16): COLOR 15
        IF posy = 6 THEN LOCATE 21, 9: COLOR 14: PRINT CHR$(16): COLOR 15

LOOP UNTIL b$ = CHR$(13)

IF kaart(posx, posy, 1, speler%) THEN BEEP: GOTO keuze

kaart(posx, posy, 0, speler%) = score(posx, posy, dobbel())
kaart(posx, posy, 1, speler%) = 1

beurt = 0
FOR i% = 1 TO 5: vast(i%) = 0: NEXT i%
posx = 0: posy = 0

bonus% = 0

FOR i% = 0 TO 1
        FOR j% = 0 TO 6
                IF kaart(i%, j%, 1, speler%) THEN vol% = vol% + 1
               
                IF i% = 0 AND j% <> 6 THEN bonus% = bonus% + kaart(i%, j%, 0, speler%)
        NEXT j%
NEXT i%

IF bonus% >= 63 AND dummy(speler%) = 0 AND herrie% THEN PLAY "l32 t255 o1 c d e f a b c d e f a b c d e f a b c d e f a b": dummy(speler%) = 1

IF NOT vol% = 13 OR NOT spelers% = speler% THEN : vol% = 0: speler% = speler% + 1: IF speler% > spelers% THEN speler% = 0
IF NOT vol% = 13 OR NOT spelers% = speler% THEN : GOTO gedobbel

totalen (spelers%)

SCREEN 13: CLS

FOR i% = 16 TO 31
        COLOR i%
        LOCATE 10, 10: PRINT "Type 'y' to play again"
        FOR t% = 1 TO 16500: NEXT t%
        FOR t% = 1 TO 16500: NEXT t%
NEXT i%

DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "y" OR a$ = "j" THEN GOTO opnieuw

FOR i% = 31 TO 16 STEP -1
        COLOR i%
        LOCATE 10, 3: PRINT "Type 'y' to play again"
        FOR t% = 1 TO 16500: NEXT t%
        FOR t% = 1 TO 16500: NEXT t%
NEXT i%

COLOR 15

SYSTEM

DATA "ones","two's","threes","fours","Fives","Sixes"
DATA "three-of-a-kind","Four-of-a-kind","Full house","Little street", "Large street","Chance"
DATA "YAHTZEE"

dinges:
herrie% = NOT (herrie%)
RETURN

SUB dobbelsteen (dob) STATIC
LINE (45 + 48 * i%, 30)-(65 + 48 * i%, 45), 15, BF

IF dob = 1 OR dob = 3 OR dob = 5 THEN CIRCLE (55 + 48 * i%, 37.5), 1, 0
IF dob = 2 OR dob = 3 OR dob = 4 OR dob = 5 OR dob = 6 THEN CIRCLE (50 + 48 * i%, 33.75), 1, 0: CIRCLE (60 + 48 * i%, 41.25), 1, 0
IF dob = 4 OR dob = 5 OR dob = 6 THEN CIRCLE (60 + 48 * i%, 33.75), 1, 0: CIRCLE (50 + 48 * i%, 41.25), 1, 0
IF dob = 6 THEN CIRCLE (50 + 48 * i%, 37.5), 1, 0: CIRCLE (60 + 48 * i%, 37.5), 1, 0
i% = i% + 1
IF i% = 5 THEN i% = 0
END SUB

SUB geluid
waarde% = 100
FOR j% = 1 TO 10
SOUND i%, .5
i% = i% + waarde%
IF i% = 150 THEN waarde% = -10
IF i% = 100 THEN waarde% = 10
NEXT j%
END SUB

FUNCTION score (x, y, dobbel())

FOR i% = 1 TO 5
        FOR j% = 1 TO i%
                IF dobbel(i%) < dobbel(j%) THEN SWAP dobbel(i%), dobbel(j%)
        NEXT j%
NEXT i%

IF x = 0 AND y <> 6 THEN
       
        FOR i% = 1 TO 5
        IF dobbel(i%) = y + 1 THEN stand = stand + y + 1
        NEXT i%

END IF

IF x = 1 AND y <> 6 THEN

        SELECT CASE y

                CASE 0
                       
                        FOR i% = 1 TO 3
                        IF dobbel(i%) = dobbel(i% + 1) AND dobbel(i% + 1) = dobbel(i% + 2) THEN goed = 1
                        NEXT i%

                        IF goed THEN FOR t = 1 TO 5: stand = stand + dobbel(t): NEXT t

                CASE 1
                       
                        FOR i% = 1 TO 2
                        IF dobbel(i%) = dobbel(i% + 1) AND dobbel(i% + 1) = dobbel(i% + 2) AND dobbel(i% + 2) = dobbel(i% + 3) THEN goed = 1
                        NEXT i%

                        IF goed THEN FOR t = 1 TO 5: stand = stand + dobbel(t): NEXT t

                CASE 2

                        IF dobbel(1) = dobbel(2) AND dobbel(2) = dobbel(3) AND dobbel(4) = dobbel(5) THEN goed = 1
                        IF dobbel(1) = dobbel(2) AND dobbel(3) = dobbel(4) AND dobbel(4) = dobbel(5) THEN goed = 1
       
                        IF goed THEN stand = 25
       
                CASE 3

                        FOR k% = 0 TO 2
                                IF dobbel(1) = 1 + k% AND dobbel(2) = 2 + k% AND dobbel(3) = 3 + k% AND dobbel(4) = 4 + k% THEN goed = 1
                                IF dobbel(1) = 1 + k% AND dobbel(2) = 2 + k% AND dobbel(3) = 3 + k% AND dobbel(5) = 4 + k% THEN goed = 1
                                IF dobbel(1) = 1 + k% AND dobbel(2) = 2 + k% AND dobbel(4) = 3 + k% AND dobbel(5) = 4 + k% THEN goed = 1
                                IF dobbel(1) = 1 + k% AND dobbel(3) = 2 + k% AND dobbel(4) = 3 + k% AND dobbel(5) = 4 + k% THEN goed = 1
                                IF dobbel(2) = 1 + k% AND dobbel(3) = 2 + k% AND dobbel(4) = 3 + k% AND dobbel(5) = 4 + k% THEN goed = 1
                        NEXT k%

                        IF goed THEN stand = 30
       
                CASE 4

                        IF dobbel(1) = dobbel(2) - 1 AND dobbel(2) = dobbel(3) - 1 AND dobbel(3) = dobbel(4) - 1 AND dobbel(4) = dobbel(5) - 1 THEN goed = 1
                       
                        IF goed THEN stand = 40
      
                CASE 5
               
                        FOR t = 1 TO 5: stand = stand + dobbel(t): NEXT t
       
        END SELECT

END IF

IF y = 6 THEN IF dobbel(1) = dobbel(2) AND dobbel(2) = dobbel(3) AND dobbel(3) = dobbel(4) AND dobbel(4) = dobbel(5) THEN stand = 50

score = stand

END FUNCTION

SUB scorekaart (speler%)
RESTORE

FOR j% = 5 TO 18 STEP 13
      
        FOR i% = 14 TO 19
        READ a$
        IF kaart((j% - 5) / 13, i% - 14, 1, speler%) THEN COLOR 8
        LOCATE i%, j%: PRINT a$
        COLOR 15
        NEXT i%

NEXT j%

IF kaart(0, 6, 1, speler%) OR kaart(1, 6, 1, speler%) THEN COLOR 8
LOCATE 21, 11
READ a$
PRINT a$
COLOR 15

END SUB

SUB totalen (spelers%)

DIM subtotaal(2, 3)
DIM totaal%(3)
DIM ok%(3)

SCREEN 12

FOR speler% = 0 TO spelers%
        FOR i% = 0 TO 5
                subtotaal(0, speler%) = subtotaal(0, speler%) + kaart(0, i%, 0, speler%)
                subtotaal(2, speler%) = subtotaal(2, speler%) + kaart(1, i%, 0, speler%)
        NEXT i%

        subtotaal(2, speler%) = subtotaal(2, speler%) + kaart(0, 6, 0, speler%) + kaart(1, 6, 0, speler%)

        IF subtotaal(0, speler%) >= 63 THEN
                ok%(speler%) = 1
                subtotaal(1, speler%) = subtotaal(0, speler%) + 35
        ELSE
                ok%(speler%) = 0
                subtotaal(1, speler%) = subtotaal(0, speler%)
        END IF

        totaal%(speler%) = subtotaal(1, speler%) + subtotaal(2, speler%)
NEXT speler%

IF speler% > 1 THEN eind% = 1 ELSE eind% = spelers%

selecteer:

CLS

FOR speler% = begin% TO eind%

letters% = 2 + 2 * speler%
strepen% = 1 + 2 * speler%

LOCATE 1, 2 + 40 * (speler% - begin%): COLOR strepen%: PRINT CHR$(201); STRING$(28, CHR$(205)); CHR$(187)
LOCATE 2, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT USING " \                        \ "; naam$(speler%); : COLOR strepen%: PRINT CHR$(186)
LOCATE 3, 2 + 40 * (speler% - begin%): PRINT CHR$(204); STRING$(22, CHR$(205)); CHR$(209); STRING$(5, CHR$(205)); CHR$(185)
LOCATE 4, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Ones                 "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(0, 0, 1, speler%) THEN PRINT USING " ### "; kaart(0, 0, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 5, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Two's                "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(0, 1, 1, speler%) THEN PRINT USING " ### "; kaart(0, 1, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 6, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Threes               "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(0, 2, 1, speler%) THEN PRINT USING " ### "; kaart(0, 2, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 7, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Fours                "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(0, 3, 1, speler%) THEN PRINT USING " ### "; kaart(0, 3, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 8, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Fives                "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(0, 4, 1, speler%) THEN PRINT USING " ### "; kaart(0, 4, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 9, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Sixes                "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(0, 5, 1, speler%) THEN PRINT USING " ### "; kaart(0, 5, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)

LOCATE 10, 2 + 40 * (speler% - begin%): PRINT CHR$(199); STRING$(22, CHR$(196)); CHR$(197); STRING$(5, CHR$(196)); CHR$(182)
LOCATE 11, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Subtotal A           "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: PRINT USING " ### "; subtotaal(0, speler%); : COLOR strepen%: PRINT CHR$(186)
LOCATE 12, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Bonus                "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: PRINT USING " ### "; ok%(speler%) * 35; : COLOR strepen%: PRINT CHR$(186)
LOCATE 13, 2 + 40 * (speler% - begin%): PRINT CHR$(199); STRING$(22, CHR$(196)); CHR$(197); STRING$(5, CHR$(196)); CHR$(182)
LOCATE 14, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Subtotal B           "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: PRINT USING " ### "; subtotaal(1, speler%); : COLOR strepen%: PRINT CHR$(186)
LOCATE 15, 2 + 40 * (speler% - begin%): PRINT CHR$(199); STRING$(22, CHR$(196)); CHR$(197); STRING$(5, CHR$(196)); CHR$(182)
LOCATE 16, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Three-of-a-kind      "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(1, 0, 1, speler%) THEN PRINT USING " ### "; kaart(1, 0, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 17, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Four-of-a-kind       "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(1, 1, 1, speler%) THEN PRINT USING " ### "; kaart(1, 1, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 18, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Full House           "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(1, 2, 1, speler%) THEN PRINT USING " ### "; kaart(1, 2, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 19, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Small street         "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(1, 3, 1, speler%) THEN PRINT USING " ### "; kaart(1, 3, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 20, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Large street         "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(1, 4, 1, speler%) THEN PRINT USING " ### "; kaart(1, 4, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 21, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Chance               "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(1, 5, 1, speler%) THEN PRINT USING " ### "; kaart(1, 5, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)
LOCATE 22, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Yahtzee              "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: IF kaart(1, 6, 1, speler%) OR kaart(0, 6, 1, speler%) THEN PRINT USING " ### "; kaart(0, 6, 0, speler%) + kaart(1, 6, 0, speler%); :  ELSE PRINT "  -  ";
COLOR strepen%: PRINT CHR$(186)

LOCATE 23, 2 + 40 * (speler% - begin%): PRINT CHR$(199); STRING$(22, CHR$(196)); CHR$(197); STRING$(5, CHR$(196)); CHR$(182)
LOCATE 24, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Subtotal C           "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: PRINT USING " ### "; subtotaal(2, speler%); : COLOR strepen%: PRINT CHR$(186)
LOCATE 25, 2 + 40 * (speler% - begin%): PRINT CHR$(199); STRING$(22, CHR$(196)); CHR$(197); STRING$(5, CHR$(196)); CHR$(182)
LOCATE 26, 2 + 40 * (speler% - begin%): PRINT CHR$(186); : COLOR letters%: PRINT " Total                "; : COLOR strepen%: PRINT CHR$(179); : COLOR letters%: PRINT USING " ### "; totaal%(speler%); : COLOR strepen%: PRINT CHR$(186)
LOCATE 27, 2 + 40 * (speler% - begin%): PRINT CHR$(200); STRING$(22, CHR$(205)); CHR$(207); STRING$(5, CHR$(205)); CHR$(188)
LOCATE 29, 23: COLOR 10: PRINT "Press 'Escape' to leave this screen";

NEXT speler%

IF begin% = 0 AND spelers% = 1 THEN LOCATE 26, 36: COLOR 6: PRINT CHR$(17); : PRINT CHR$(16):  links% = 0: rechts% = 0
IF begin% = 0 AND spelers% >= 2 THEN LOCATE 26, 36: COLOR 6: PRINT CHR$(17); : COLOR 14: PRINT CHR$(16): links% = 0: rechts% = 1
IF begin% = 1 AND spelers% = 2 THEN LOCATE 26, 36: COLOR 14: PRINT CHR$(17); : COLOR 6: PRINT CHR$(16): links% = 1: rechts% = 0
IF begin% = 1 AND spelers% = 3 THEN LOCATE 26, 36: COLOR 14: PRINT CHR$(17); : COLOR 14: PRINT CHR$(16): links% = 1: rechts% = 1
IF begin% = 2 AND spelers% = 3 THEN LOCATE 26, 36: COLOR 14: PRINT CHR$(17); : COLOR 6: PRINT CHR$(16): links% = 1: rechts% = 0

DO: a$ = INKEY$: LOOP UNTIL a$ = CHR$(0) + "K" OR a$ = CHR$(0) + "M" OR a$ = CHR$(27)

IF a$ = CHR$(0) + "K" THEN
        IF links% THEN begin% = begin% - 1: eind% = eind% - 1 ELSE BEEP
        GOTO selecteer
END IF

IF a$ = CHR$(0) + "M" THEN
        IF rechts% THEN begin% = begin% + 1: eind% = eind% + 1 ELSE BEEP
        GOTO selecteer
END IF

OPEN "yahtzee.hi" FOR INPUT AS #1
INPUT #1, beste$, bestescore%
CLOSE

FOR i% = 0 TO spelers%
        IF totaal%(i%) > bestescore% THEN bestescore% = totaal%(i%): beste$ = naam$(i%): BEEP
NEXT i%

OPEN "yahtzee.hi" FOR OUTPUT AS #1
PRINT #1, beste$
PRINT #1, bestescore%
CLOSE

END SUB

