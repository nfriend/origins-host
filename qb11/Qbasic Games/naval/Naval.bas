







'                              Type F5 to play                               '
'                          Type Alt, f, x to quit                            '








DECLARE SUB winnaar (beurt%)
DECLARE SUB sound1 ()
DECLARE SUB sound2 ()
DECLARE FUNCTION speel% ()
DECLARE FUNCTION controleer% (x%, y%, hor%, lengte%, speler%)
DECLARE SUB boten (i%)
DECLARE FUNCTION raak% (x%, y%, beurt%)

COMMON SHARED spelers%, herrie%

DIM SHARED naam$(1), veld%(9, 9, 1), cooud%(1, 1), omgeving%(2, 2)

RANDOMIZE (TIMER)

home:
IF herrie% THEN CLEAR : herrie% = NOT (herrie%) ELSE CLEAR

ON KEY(2) GOSUB dinges
ON KEY(31) GOSUB einde

KEY(2) ON
KEY(31) ON

SCREEN 12: CLS

LOCATE 12, 38: PRINT "Naval Battle"
COLOR 14
LOCATE 15, 36: PRINT CHR$(16); " 1 Player"
LOCATE 16, 38: PRINT "2 Players"
LOCATE 17, 38: PRINT "Quit"

LOCATE 24, 10: COLOR 15: PRINT "F2 = Sound On/Off"
LOCATE 25, 10: PRINT "F12 = Quit"

COLOR 14

DO
        DO: a$ = INKEY$: LOOP WHILE a$ = ""
       
        IF a$ = CHR$(0) + "H" THEN po% = po% - 1
        IF a$ = CHR$(0) + "P" THEN po% = po% + 1
        IF a$ = CHR$(13) AND po% = 0 THEN spelers% = 1
        IF a$ = CHR$(13) AND po% = 1 THEN spelers% = 2
        IF a$ = CHR$(13) AND po% = 2 THEN SYSTEM
        IF po% > 2 THEN po% = 0
        IF po% < 0 THEN po% = 2

        FOR i% = 0 TO 2
                LOCATE 15 + i%, 36: IF po% = i% THEN PRINT CHR$(16);  ELSE PRINT " ";
        NEXT i%

LOOP WHILE spelers% = 0

COLOR 11

LOCATE 20, 20: INPUT "Name player 1 : ", naam$(0): IF naam$(0) = "" THEN naam$(0) = "Speler 1"
IF spelers% = 2 THEN LOCATE 21, 20: INPUT "Name player 2 : ", naam$(1): IF naam$(1) = "" THEN naam$(1) = "Player 2"
IF spelers% = 1 THEN naam$(1) = "Computer"

FOR i% = 0 TO 1
        boten (i%)
NEXT i%

beurt% = speel%

winnaar (beurt%)

DO: a$ = INKEY$: LOOP WHILE a$ = ""

GOTO home

einde:
SYSTEM
RETURN

dinges:
herrie% = NOT (herrie%)
BEEP
RETURN

SUB boten (speler%)


IF NOT (speler% = 1 AND spelers% = 1) THEN
        CLS
        COLOR 10
        PRINT "Place your boats, "; naam$(speler%); " :"
        COLOR 8
        LINE (100, 50)-(500, 400), , B
        LINE (95, 45)-(505, 405), , B
        FOR j% = 1 TO 9
               
                LINE (100 + 40 * j%, 50)-(100 + 40 * j%, 400)
                LINE (100, 50 + 35 * j%)-(500, 50 + 35 * j%)

        NEXT j%
        FOR j% = 0 TO 9
                LOCATE 5 + 2.15 * j%, 10: PRINT USING "##"; 10 - j%
                LOCATE 27, 16 + 5 * j%: PRINT CHR$(65 + j%)
        NEXT j%

        x% = 1: y% = 1

        FOR q% = 0 TO 1
                LINE (60 + 40 * (x% + hor% * q%), 15 + 35 * (y% + (1 - hor%) * q%))-(100 + 40 * (x% + hor% * q%), 50 + 35 * (y% + (1 - hor%) * q%)), 14, B
        NEXT q%

END IF

FOR j% = 0 TO 4

        lengte% = INT(1.5 + .7 * j%)

        IF NOT (speler% = 1 AND spelers% = 1) THEN

        DO
                DO: a$ = INKEY$: LOOP UNTIL a$ = CHR$(0) + "H" OR a$ = CHR$(0) + "P" OR a$ = CHR$(0) + "M" OR a$ = CHR$(0) + "K" OR a$ = CHR$(27) OR a$ = CHR$(13) OR a$ = " "

                FOR q% = 0 TO lengte%
                        LINE (60 + 40 * (x% + hor% * q%), 15 + 35 * (y% + (1 - hor%) * q%))-(100 + 40 * (x% + hor% * q%), 50 + 35 * (y% + (1 - hor%) * q%)), 8, B
                NEXT q%

                IF a$ = CHR$(0) + "P" THEN y% = y% + 1
                IF a$ = CHR$(0) + "H" THEN y% = y% - 1
                IF a$ = CHR$(0) + "M" THEN x% = x% + 1
                IF a$ = CHR$(0) + "K" THEN x% = x% - 1
                IF a$ = " " THEN hor% = 1 - hor%
                IF a$ = CHR$(27) THEN SYSTEM
                IF x% < 1 THEN x% = 1: IF NOT herrie% THEN BEEP
                IF x% > 10 - hor% * lengte% THEN x% = 10 - hor% * lengte%: IF NOT herrie% THEN BEEP
                IF y% < 1 THEN y% = 1: IF NOT herrie% THEN BEEP
                IF y% > 10 - (1 - hor%) * lengte% THEN y% = 10 - (1 - hor%) * lengte%: IF NOT herrie% THEN BEEP

                FOR q% = 0 TO lengte%
                        LINE (60 + 40 * (x% + hor% * q%), 15 + 35 * (y% + (1 - hor%) * q%))-(100 + 40 * (x% + hor% * q%), 50 + 35 * (y% + (1 - hor%) * q%)), 14, B
                NEXT q%
       
        LOOP UNTIL a$ = CHR$(13)

        END IF

        IF speler% = 1 AND spelers% = 1 THEN hor% = INT(RND + .5): x% = 1 + INT((10 - lengte% * hor%) * RND): y% = 1 + INT((10 - lengte% * (1 - hor%)) * RND)
       
        IF controleer%(x%, y%, hor%, lengte%, speler%) = 0 THEN j% = j% - 1: GOTO skip

        FOR q% = 0 TO lengte%
                PAINT (80 + 40 * (x% + hor% * q%), 33 + 35 * (y% + (1 - hor%) * q%)), 6, 14
        NEXT q%

        FOR i% = 0 TO lengte%
                IF hor% = 1 THEN veld%(x% - 1 + i%, y% - 1, speler%) = 1
                IF hor% = 0 THEN veld%(x% - 1, y% - 1 + i%, speler%) = 1
        NEXT i%

skip:

NEXT j%

END SUB

FUNCTION controleer% (x%, y%, hor%, lengte%, speler%)

magwel% = 1
       
IF hor% = 0 THEN
               
'erop'
        FOR i% = 0 TO lengte%
                IF veld%(x% - 1, y% + i% - 1, speler%) THEN magwel% = 0
        NEXT i%

'boven'
        IF y% > 1 THEN IF veld%(x% - 1, y% - 2, speler%) THEN magwel% = 0
               
'onder'
        IF y% < 10 - lengte% THEN IF veld%(x% - 1, y% + lengte%, speler%) THEN magwel% = 0

'links'
        IF x% > 1 THEN
                FOR i% = 0 TO lengte%
                        IF veld%(x% - 2, y% - 1 + i%, speler%) THEN magwel% = 0
                NEXT i%
        END IF

'rechts'
        IF x% < 10 THEN
                FOR i% = 0 TO lengte%
                        IF veld%(x%, y% - 1 + i%, speler%) THEN magwel% = 0
                NEXT i%
        END IF

'linksboven'
        IF x% > 1 AND y% > 1 THEN IF veld%(x% - 2, y% - 2, speler%) THEN magwel% = 0
'rechtsboven'
        IF x% < 10 AND y% > 1 THEN IF veld%(x%, y% - 2, speler%) THEN magwel% = 0
'linksonder'
        IF x% > 1 AND y% < 10 - lengte% THEN IF veld%(x% - 2, y% + lengte%, speler%) THEN magwel% = 0
'rechtsonder'
        IF x% < 10 AND y% < 10 - lengte% THEN IF veld%(x%, y% + lengte%, speler%) THEN magwel% = 0

END IF

IF hor% = 1 THEN
              
'erop'
        FOR i% = 0 TO lengte%
                IF veld%(x% - 1 + i%, y% - 1, speler%) THEN magwel% = 0
        NEXT i%

'links'
        IF x% > 1 THEN IF veld%(x% - 2, y% - 1, speler%) THEN magwel% = 0
              
'rechts'
        IF x% < 10 - lengte% THEN IF veld%(x% + lengte%, y% - 1, speler%) THEN magwel% = 0

'boven'
        IF y% > 1 THEN
                FOR i% = 0 TO lengte%
                        IF veld%(x% - 1 + i%, y% - 2, speler%) THEN magwel% = 0
                NEXT i%
        END IF

'onder'
        IF y% < 10 THEN
                FOR i% = 0 TO lengte%
                        IF veld%(x% - 1 + i%, y%, speler%) THEN magwel% = 0
                NEXT i%
        END IF

'linksboven'
        IF x% > 1 AND y% > 1 THEN IF veld%(x% - 2, y% - 2, speler%) THEN magwel% = 0
'linksonder'
        IF x% > 1 AND y% < 10 THEN IF veld%(x% - 2, y%, speler%) THEN magwel% = 0
'rechtsboven'
        IF x% < 10 - lengte% AND y% > 1 THEN IF veld%(x% + lengte%, y% - 2, speler%) THEN magwel% = 0
'rechtsonder'
        IF x% < 10 - lengte% AND y% < 10 THEN IF veld%(x% + lengte%, y%, speler%) THEN magwel% = 0

END IF

controleer% = magwel%

END FUNCTION

FUNCTION raak% (x%, y%, beurt%)

gezonken% = 1

DO
        i% = i% + 1
        IF x% - i% >= 0 AND links% = 0 THEN
                IF veld%(x% - i%, y%, beurt%) = 1 THEN gezonken% = 0
                IF veld%(x% - i%, y%, beurt%) = 0 OR veld%(x% - i%, y%, beurt%) = 2 THEN links% = 1
        END IF
        IF x% + i% <= 9 AND rechts% = 0 THEN
                IF veld%(x% + i%, y%, beurt%) = 1 THEN gezonken% = 0
                IF veld%(x% + i%, y%, beurt%) = 0 OR veld%(x% + i%, y%, beurt%) = 2 THEN rechts% = 1
        END IF
        IF y% - i% >= 0 AND boven% = 0 THEN
                IF veld%(x%, y% - i%, beurt%) = 1 THEN gezonken% = 0
                IF veld%(x%, y% - i%, beurt%) = 0 OR veld%(x%, y% - i%, beurt%) = 2 THEN boven% = 1
        END IF
        IF y% + i% <= 9 AND onder% = 0 THEN
                IF veld%(x%, y% + i%, beurt%) = 1 THEN gezonken% = 0
                IF veld%(x%, y% + i%, beurt%) = 0 OR veld%(x%, y% + i%, beurt%) = 2 THEN onder% = 1
        END IF
LOOP UNTIL i% = 4 OR gezonken% = 0

links% = 0: rechts% = 0: onder% = 0: boven% = 0: i% = 0

IF gezonken% THEN

        LINE (101 + 40 * x%, 51 + 35 * y%)-(139 + 40 * x%, 84 + 35 * y%), 12, BF: veld%(x%, y%, beurt%) = veld%(x%, y%, beurt%) + 10

        DO
                i% = i% + 1
                IF x% - i% >= 0 AND links% = 0 THEN
                        IF veld%(x% - i%, y%, beurt%) <> 3 THEN links% = 1 ELSE LINE (101 + 40 * (x% - i%), 51 + 35 * y%)-(139 + 40 * (x% - i%), 84 + 35 * y%), 12, BF: veld%(x% - i%, y%, beurt%) = veld%(x% - i%, y%, beurt%) + 10
                END IF
               
                IF x% + i% <= 9 AND rechts% = 0 THEN
                        IF veld%(x% + i%, y%, beurt%) <> 3 THEN rechts% = 1 ELSE LINE (101 + 40 * (x% + i%), 51 + 35 * y%)-(139 + 40 * (x% + i%), 84 + 35 * y%), 12, BF: veld%(x% + i%, y%, beurt%) = veld%(x% + i%, y%, beurt%) + 10
                END IF
               
                IF y% - i% >= 0 AND boven% = 0 THEN
                        IF veld%(x%, y% - i%, beurt%) <> 3 THEN boven% = 1 ELSE LINE (101 + 40 * x%, 51 + 35 * (y% - i%))-(139 + 40 * x%, 84 + 35 * (y% - i%)), 12, BF: veld%(x%, y% - i%, beurt%) = veld%(x%, y% - i%, beurt%) + 10
                END IF
               
                IF y% + i% <= 9 AND onder% = 0 THEN
                        IF veld%(x%, y% + i%, beurt%) <> 3 THEN onder% = 1 ELSE LINE (101 + 40 * x%, 51 + 35 * (y% + i%))-(139 + 40 * x%, 84 + 35 * (y% + i%)), 12, BF: veld%(x%, y% + i%, beurt%) = veld%(x%, y% + i%, beurt%) + 10
                END IF

        LOOP UNTIL i% = 4

END IF

raak% = gezonken%
END FUNCTION

SUB sound1
FOR i% = 0 TO 35
        SOUND (40 + INT(60 * RND)), .25
NEXT i%
END SUB

SUB sound2
FOR i% = 1 TO 40
        SOUND (300 + INT(100 * RND)), .25
NEXT i%
END SUB

FUNCTION speel%

DIM hit%(1)                     ', omgeving%(2, 2)'

omgeving%(1, 1) = 3

herhaal:

CLS : COLOR 15
LOCATE 1, 37: PRINT "Naval Battle"

COLOR 8

LINE (100, 50)-(500, 400), , B
LINE (95, 45)-(505, 405), , B
FOR j% = 1 TO 9
      
        LINE (100 + 40 * j%, 50)-(100 + 40 * j%, 400)
        LINE (100, 50 + 35 * j%)-(500, 50 + 35 * j%)

NEXT j%
FOR j% = 0 TO 9
        LOCATE 5 + 2.15 * j%, 10: PRINT USING "##"; 10 - j%
        LOCATE 27, 16 + 5 * j%: PRINT CHR$(65 + j%)
NEXT j%

FOR i% = 0 TO 9
        FOR j% = 0 TO 9
                
                IF veld%(i%, j%, beurt%) = 13 THEN PAINT (120 + 40 * i%, 68 + 35 * j%), 12, 8
                IF veld%(i%, j%, beurt%) = 3 THEN PAINT (120 + 40 * i%, 68 + 35 * j%), 4, 8
                IF veld%(i%, j%, beurt%) = 2 THEN PAINT (120 + 40 * i%, 68 + 35 * j%), 15, 8
        NEXT j%
NEXT i%

FOR i% = 0 TO 9
        FOR j% = 0 TO 9
                IF veld%(i%, j%, beurt%) = 13 THEN PAINT (120 + 40 * i%, 68 + 35 * j%), 12, 8
                IF veld%(i%, j%, beurt%) = 3 THEN PAINT (120 + 40 * i%, 68 + 35 * j%), 4, 8
                IF veld%(i%, j%, beurt%) = 2 THEN PAINT (120 + 40 * i%, 68 + 35 * j%), 15, 8
        NEXT j%
NEXT i%

COLOR 14
LOCATE 2, 5: PRINT naam$(1 - beurt%); " is to play!"

x% = cooud%(beurt%, 0): y% = cooud%(beurt%, 1)

LINE (100 + 40 * x%, 50 + 35 * y%)-(140 + 40 * x%, 85 + 35 * y%), 14, B

IF NOT (spelers% = 1 AND beurt% = 0) THEN

        DO
                DO: a$ = INKEY$: LOOP UNTIL a$ = CHR$(0) + "H" OR a$ = CHR$(0) + "P" OR a$ = CHR$(0) + "M" OR a$ = CHR$(0) + "K" OR a$ = CHR$(27) OR a$ = CHR$(13) OR a$ = " "
               
                LINE (100 + 40 * x%, 50 + 35 * y%)-(140 + 40 * x%, 85 + 35 * y%), 8, B

                IF a$ = CHR$(0) + "P" THEN y% = y% + 1
                IF a$ = CHR$(0) + "H" THEN y% = y% - 1
                IF a$ = CHR$(0) + "M" THEN x% = x% + 1
                IF a$ = CHR$(0) + "K" THEN x% = x% - 1
                IF a$ = CHR$(27) THEN SYSTEM
                IF x% < 0 THEN x% = 0: IF NOT herrie% THEN BEEP
                IF x% > 9 THEN x% = 9: IF NOT herrie% THEN BEEP
                IF y% < 0 THEN y% = 0: IF NOT herrie% THEN BEEP
                IF y% > 9 THEN y% = 9: IF NOT herrie% THEN BEEP

                LINE (100 + 40 * x%, 50 + 35 * y%)-(140 + 40 * x%, 85 + 35 * y%), 14, B

        LOOP UNTIL a$ = CHR$(13)

ELSE

'Dit hier is de computerspeler'

retry:

        x% = INT(10 * RND)
        y% = 2 * ((x% / 2) - INT(x% / 2)) + 2 * INT(5 * RND)

        IF x% > 0 AND y% > 0 THEN IF veld%(x% - 1, y% - 1, 0) = 13 THEN GOTO retry
        IF y% > 0 THEN IF veld%(x%, y% - 1, 0) = 13 THEN GOTO retry
        IF x% < 9 AND y% > 0 THEN IF veld%(x% + 1, y% - 1, 0) = 13 THEN GOTO retry
        IF x% > 0 THEN IF veld%(x% - 1, y%, 0) = 13 THEN GOTO retry
        IF veld%(x%, y%, 0) = 0 AND veld%(x%, y%, 0) = 1 THEN GOTO retry
        IF x% < 9 THEN IF veld%(x% + 1, y%, 0) = 13 THEN GOTO retry
        IF x% > 0 AND y% < 9 THEN IF veld%(x% - 1, y% + 1, 0) = 13 THEN GOTO retry
        IF y% < 9 THEN IF veld%(x%, y% + 1, 0) = 13 THEN GOTO retry
        IF x% < 9 AND y% < 9 THEN IF veld%(x% + 1, y% + 1, 0) = 13 THEN GOTO retry
       
       
        FOR i% = 0 TO 9
                FOR j% = 0 TO 9
                        IF veld%(i%, j%, 0) = 3 THEN

                                IF i% > 0 AND j% > 0 THEN omgeving%(0, 2) = veld%(i% - 1, j% - 1, 0) ELSE omgeving%(0, 2) = -1
                                IF j% > 0 THEN omgeving%(1, 2) = veld%(i%, j% - 1, 0) ELSE omgeving%(1, 2) = -1
                                IF i% < 9 AND j% > 0 THEN omgeving%(2, 2) = veld%(i% + 1, j% - 1, 0) ELSE omgeving%(2, 2) = -1
                                IF i% > 0 THEN omgeving%(0, 1) = veld%(i% - 1, j%, 0) ELSE omgeving%(0, 1) = -1
                                omgeving%(1, 1) = 3
                                IF i% < 9 THEN omgeving%(2, 1) = veld%(i% + 1, j%, 0) ELSE omgeving%(2, 1) = -1
                                IF i% > 0 AND j% < 9 THEN omgeving%(0, 0) = veld%(i% - 1, j% + 1, 0) ELSE omgeving%(0, 0) = -1
                                IF j% < 9 THEN omgeving%(1, 0) = veld%(i%, j% + 1, 0) ELSE omgeving%(1, 0) = -1
                                IF i% < 9 AND j% < 9 THEN omgeving%(2, 0) = veld%(i% + 1, j% + 1, 0) ELSE omgeving%(2, 0) = -1

                                IF omgeving%(0, 1) = 3 AND omgeving%(2, 1) = 3 THEN GOTO overslaan
                                IF omgeving%(1, 0) = 3 AND omgeving%(1, 2) = 3 THEN GOTO overslaan

                                IF omgeving%(0, 1) = 0 OR omgeving%(0, 1) = 1 THEN x% = i% - 1: y% = j%
                                IF omgeving%(2, 1) = 0 OR omgeving%(2, 1) = 1 THEN x% = i% + 1: y% = j%
                                IF omgeving%(1, 0) = 0 OR omgeving%(1, 0) = 1 THEN x% = i%: y% = j% + 1
                                IF omgeving%(1, 2) = 0 OR omgeving%(1, 2) = 1 THEN x% = i%: y% = j% - 1

                                IF omgeving%(0, 1) = 3 AND (omgeving%(2, 1) = 0 OR omgeving%(2, 1) = 1) THEN x% = i% + 1: y% = j%
                                IF omgeving%(2, 1) = 3 AND (omgeving%(0, 1) = 0 OR omgeving%(0, 1) = 1) THEN x% = i% - 1: y% = j%
                                IF omgeving%(1, 0) = 3 AND (omgeving%(1, 2) = 0 OR omgeving%(1, 2) = 1) THEN x% = i%: y% = j% - 1
                                IF omgeving%(1, 2) = 3 AND (omgeving%(1, 0) = 0 OR omgeving%(1, 0) = 1) THEN x% = i%: y% = j% + 1
overslaan:         
                        END IF
                NEXT j%
        NEXT i%

        LINE (100 + 40 * x%, 50 + 35 * y%)-(140 + 40 * x%, 85 + 35 * y%), 14, B

'en hier niet meer'

END IF

IF veld%(x%, y%, beurt%) < 2 THEN
        veld%(x%, y%, beurt%) = veld%(x%, y%, beurt%) + 2
ELSE
        IF NOT herrie% OR (speler% = 1 AND beurt% = 1) THEN BEEP
        GOTO herhaal
END IF

IF veld%(x%, y%, beurt%) = 3 THEN
        PAINT (120 + 40 * x%, 68 + 35 * y%), 4, 14
        IF raak%(x%, y%, beurt%) THEN IF NOT (herrie%) THEN PLAY "mbl32o1cdecdefa"
        hit%(beurt%) = hit%(beurt%) + 1
        IF NOT (herrie%) THEN sound1
END IF

IF veld%(x%, y%, beurt%) = 2 THEN
        PAINT (120 + 40 * x%, 68 + 35 * y%), 15, 14
        IF NOT (herrie%) THEN sound2
END IF

cooud%(beurt%, 0) = x%: cooud%(beurt%, 1) = y%

beurt% = 1 - beurt%

FOR t2% = 0 TO 100
        FOR t1% = 1 TO 5000: NEXT t1%
NEXT t2%

IF hit%(1 - beurt%) < 17 THEN GOTO herhaal

speel% = beurt%
END FUNCTION

SUB winnaar (beurt%)
CLS : SCREEN 12: COLOR 15

LINE (100, 260)-(200, 300), 8, BF
CIRCLE (100, 260), 40, 8, -3.14, -1.5 * 3.14
PAINT (80, 280), 8, 8
LINE (200, 300)-(250, 260), 8
LINE (250, 260)-(200, 260), 8
LINE (200, 300)-(200, 260), 8
PAINT (210, 270), 8, 8
LINE (80, 260)-(160, 235), 8, BF
LINE (60, 259)-(250, 259), 0
LINE (200, 258)-(220, 254), 8, BF
LINE (190, 252)-(220, 240), 8, BF
LINE -STEP(10, 12), 8
LINE -STEP(-10, 0), 8
PAINT STEP(5, -1), 8, 8
LINE (222, 242)-(260, 232), 8
LINE (223, 249)-(263, 239), 8
LINE (260, 232)-(263, 239), 8

LINE (450, 230)-(550, 300), 8
LINE (450, 230)-(450, 300), 8
LINE (550, 300)-(450, 300), 8
PAINT (470, 285), 8, 8

LINE (500, 265)-(530, 230), 15
LINE -(560, 250), 15
LINE -(547, 265), 15
LINE -(515, 245), 15

PAINT (540, 250), 15, 15

FOR i% = 0 TO 640
        PSET (i%, 290 + 10 * SIN(.05 * i%)), 1
NEXT i%

PAINT (0, 400), 1, 1

COLOR 11

LOCATE 8, 8: PRINT "And the winner is :"
LOCATE 8, 55: PRINT "And the loser is :"

COLOR 14

IF LEN(naam$(beurt%)) < 30 THEN
        LOCATE 10, 18 - .5 * LEN(naam$(beurt%)): PRINT naam$(beurt%)
ELSE
        LOCATE 10, 2: PRINT naam$(beurt%)
END IF

IF LEN(naam$(1 - beurt%)) < 30 THEN
        LOCATE 10, 63 - .5 * LEN(naam$(1 - beurt%)): PRINT naam$(1 - beurt%)
ELSE
        LOCATE 10, 50: PRINT USING "\                            \"; naam$(1 - beurt%)
END IF

COLOR 7

FOR i% = 18 TO 63 STEP 45
        LOCATE 11, i%: PRINT "|"
        LOCATE , i%: PRINT "|"
        LOCATE , i%: PRINT "|"
        LOCATE , i%: PRINT CHR$(25)
NEXT i%

COLOR 2
LOCATE 24, 22: PRINT STRING$(37, " ")
LOCATE , 22: PRINT "  Press any key to continu"
LOCATE , 22: PRINT STRING$(37, " ")

END SUB

