DECLARE SUB draai (hoek%)
DECLARE SUB spring (hoek%)
CONST HIER = 8
CONST GRADEN = 3.14 / 180


SCREEN 12: CLS
WINDOW (-240, -180)-(240, 180)

DIM SHARED x%(100, 2)
DIM SHARED y%(100, 2)

LOCATE 22, 34: PRINT "Jarno Software"

FOR j% = 0 TO 1
        FOR i% = 0 TO HIER - 1
                READ xin%, yin%
                x%(i%, j%) = xin%
                y%(i%, j%) = yin%
        NEXT i%
        RESTORE
NEXT j%

DO

FOR k% = 0 TO 360 STEP 5

        FOR l% = 1 TO 30000: NEXT l%

        IF INKEY$ <> "" THEN SYSTEM
       
        COLOR 0

        FOR i% = 0 TO HIER - 2
                LINE (x%(i%, 0), y%(i%, 0))-(x%(i% + 1, 0), y%(i% + 1, 0))
                LINE (x%(i%, 1), y%(i%, 1))-(x%(i% + 1, 1), y%(i% + 1, 1))
        NEXT i%

        LINE (x%(0, 0), y%(0, 0))-(x%(7, 0), y%(7, 0))
        LINE (x%(0, 1), y%(0, 1))-(x%(7, 1), y%(7, 1))

        draai (k%)
        spring (k%)

        COLOR 14

        FOR i% = 0 TO HIER - 2
                LINE (x%(i%, 0), y%(i%, 0))-(x%(i% + 1, 0), y%(i% + 1, 0))
                LINE (x%(i%, 1), y%(i%, 1))-(x%(i% + 1, 1), y%(i% + 1, 1))
        NEXT i%

        FOR i% = 0 TO HIER - 1
                LINE (x%(i%, 0), y%(i%, 0))-(x%(i%, 1), y%(i%, 1))
        NEXT i%

        LINE (x%(0, 0), y%(0, 0))-(x%(7, 0), y%(7, 0))
        LINE (x%(0, 1), y%(0, 1))-(x%(7, 1), y%(7, 1))

NEXT k%

LOOP

DATA 20,100, 40,100, 40,0, 0,-40, -40,0, -40,20, 0,-20, 20,0

SUB draai (hoek%)

RESTORE


        FOR i% = 0 TO HIER - 1
                READ xlang%, ylang%
                x%(i%, 0) = xlang% * COS(hoek% * GRADEN) + 10 * SIN(hoek% * GRADEN)
                x%(i%, 1) = xlang% * COS(hoek% * GRADEN) - 10 * SIN(hoek% * GRADEN)
        NEXT i%


END SUB

SUB spring (hoek%) STATIC

q% = q% + 1
IF q% = 1 THEN richting% = -1

IF y%(2, 0) > 20 THEN richting% = -1
IF y%(2, 0) < -20 THEN richting% = 1


FOR j% = 0 TO 1
        FOR i% = 0 TO HIER - 1
                y%(i%, j%) = y%(i%, j%) + richting%
        NEXT i%
NEXT j%


LINE (-40, hulp%)-(40, hulp%)
LINE (-40, hulp% + 20)-(40, hulp% + 20)
LINE (-40, hulp% - 20)-(40, hulp% - 20)
LINE (-40, hulp% - 40)-(40, hulp% - 40)
LINE (-40, hulp% + 100)-(40, hulp% + 100)

hulp% = hulp% + richting%

END SUB

