DECLARE SUB length ()
top:
CLS
PRINT "What type of conversion are you wanting?  "
PRINT
PRINT "   1) Length"
PRINT "   3) Weight"
PRINT "   4) Volume"
PRINT "   5) Mass"
LOCATE 1, 43
INPUT "", types
SELECT CASE types
CASE 1
        length
CASE 2
        'weight
CASE 3
        'volume
CASE 4
        'mass
CASE ELSE
        GOTO top
END SELECT



SUB length

ltop:
CLS
PRINT "What is the beginning unit?"
PRINT
PRINT "   1) Inches"
PRINT "   2) Feet"
PRINT "   3) Yards"
PRINT "   4) Miles"
PRINT "   5) Millimeter"
PRINT "   6) Centimeter"
PRINT "   7) Decimeter"
PRINT "   8) Meter"
PRINT "   9) Decameter"
PRINT "   10) Hectometer"
PRINT "   11) Kilometer"

LOCATE 1, 31

INPUT "", what

SELECT CASE what
CASE 1
        LET name$ = "inch(es)"
CASE 2
        LET name$ = "feet (or foot)"
CASE 3
        LET name$ = "yard(s)"
CASE 4
        LET name$ = "mile(s)"
CASE 5
        LET name$ = "millimeter(s)"
CASE 6
        LET name$ = "centimeter(s)"
CASE 7
        LET name$ = "decimeter(s)"
CASE 8
        LET name$ = "meter(s)"
CASE 9
        LET name$ = "decameter(s)"
CASE 10
        LET name$ = "hectometer(s)"
CASE 11
        LET name$ = "kilometer(s)"
END SELECT

CLS

SELECT CASE what
CASE 1
        INPUT "How many inches?   ", num1
CASE 2
        INPUT "How many feet?   ", num1
        LET num1 = num1 * 12
CASE 3
        INPUT "How many yards?   ", num1
        LET num1 = num1 * 12
        LET num1 = num1 * 3
CASE 4
        INPUT "How many miles?   ", num1
        LET num1 = num1 * 5280
        LET num1 = num1 * 12
CASE 5
        INPUT "How many millimeters?   ", num1
        
CASE 6
        INPUT "How many centimeters?   ", num1
        LET num1 = num1 * 10
CASE 7
        INPUT "How many decimeters?   ", num1
        LET num1 = num1 * 100
CASE 8
        INPUT "How many meters?   ", num1
        LET num1 = num1 * 1000
CASE 9
        INPUT "How many decameters?   ", num1
        LET num1 = num1 * 10000
CASE 10
        INPUT "How many hectometers?   ", num1
        LET num1 = num1 * 100000
CASE 11
        INPUT "How many kilometers?   ", num1
        LET num1 = num1 * 1000000
CASE ELSE
        GOTO ltop
END SELECT


lltop:
CLS
PRINT "What is the unit that you would like to convert to?"
PRINT
PRINT "   1) Inches"
PRINT "   2) Feet"
PRINT "   3) Yards"
PRINT "   4) Miles"
PRINT "   5) Millimeter"
PRINT "   6) Centimeter"
PRINT "   7) Decimeter"
PRINT "   8) Meter"
PRINT "   9) Decameter"
PRINT "   10) Hectometer"
PRINT "   11) Kilometer"

LOCATE 1, 55

INPUT "", what2

SELECT CASE what2
CASE 1
        LET name2$ = "inch(es)"
CASE 2
        LET name2$ = "feet (or foot)"
CASE 3
        LET name2$ = "yard(s)"
CASE 4
        LET name2$ = "mile(s)"
CASE 5
        LET name2$ = "millimeter(s)"
CASE 6
        LET name2$ = "centimeter(s)"
CASE 7
        LET name2$ = "decimeter(s)"
CASE 8
        LET name2$ = "meter(s)"
CASE 9
        LET name2$ = "decameter(s)"
CASE 10
        LET name2$ = "hectometer(s)"
CASE 11
        LET name2$ = "kilometer(s)"
END SELECT


SELECT CASE what
CASE 1 TO 4
        IF what2 = 1 OR what2 = 2 OR what2 = 3 OR what2 = 4 THEN
                LET num2 = num1 * 1
        ELSE
                LET num2 = num1 * .03937
        END IF

CASE 5 TO 11
        IF what >= 5 AND what <= 11 THEN
                LET num2 = num1 * 1
        ELSE
                LET num2 = num1 / .03937
        END IF
END SELECT

SELECT CASE what2
CASE 1
        LET num2 = num2 / 1
CASE 2
        LET num2 = num2 / 12
CASE 3
        LET num2 = num2 / 12
        LET num2 = num2 / 3
CASE 4
        LET num2 = num2 / 12
        LET num2 = num2 / 5280
CASE 5
        LET num2 = num2 / 1
CASE 6
        LET num2 = num2 / 10
CASE 7
        LET num2 = num2 / 100
CASE 8
        LET num2 = num2 / 1000
CASE 9
        LET num2 = num2 / 10000
CASE 10
        LET num2 = num2 / 100000
CASE 11
        LET num2 = num2 / 1000000
END SELECT

SELECT CASE what
CASE 1
        LET num1 = num1 / 1
CASE 2
        LET num1 = num1 / 12
CASE 3
        LET num1 = num1 / 12
        LET num1 = num1 / 3
CASE 4
        LET num1 = num1 / 12
        LET num1 = num1 / 5280
CASE 5
        LET num1 = num1 / 1
CASE 6
        LET num1 = num1 / 10
CASE 7
        LET num1 = num1 / 100
CASE 8
        LET num1 = num1 / 1000
CASE 9
        LET num1 = num1 / 10000
CASE 10
        LET num1 = num1 / 100000
CASE 11
        LET num1 = num1 / 1000000
END SELECT

CLS

PRINT ""; num1; ""; name$; " is equal to "; num2; ""; name2$; "."


END SUB

