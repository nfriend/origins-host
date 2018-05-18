DECLARE SUB figureout ()
COMMON SHARED num, multiple
CLS
OPTION BASE 1
SOUND 600, 5
SOUND 1200, 2
LOCATE 12, 32
COLOR 14
PRINT "Welcome to FACTOR!"
SLEEP 3
top:
COLOR 9
CLS
INPUT "Number?  (1 - 5000)   ", num
IF num < 1 THEN CLS : PRINT "Your number must be greater or equal to 1.": PRINT "Press any key to continue..": DO WHILE INKEY$ = "": LOOP: GOTO top
IF num > 5000 THEN CLS : PRINT "Your number must be smaller or equal to 5000.": PRINT "Press any key to continue..": DO WHILE INKEY$ = "": LOOP: GOTO top
DIM SHARED multiple(num)

figureout
COLOR 15

SUB figureout
CLS
PRINT "Please wait..."

FOR i = 1 TO num
        FOR u = 1 TO num
                IF i * u = num THEN LET gg = gg + 1: LET multiple(gg) = i
        NEXT u
NEXT i

CLS
COLOR 10
IF num = 1 THEN PRINT "1 is neither a prime or a composite.  It has no factors except itself.": COLOR 15: END
IF multiple(1) = 1 AND multiple(2) = num THEN PRINT num; "is a prime. Its only factors are 1 and"; num; ".": COLOR 15: END

PRINT num; "is composite.  Its factors are:"
PRINT
IF multiple(2) <> num THEN
        f = 1
        DO UNTIL multiple(f) = 0
        PRINT multiple(f),
        f = f + 1
        IF multiple(f) = 0 THEN EXIT DO
        PRINT multiple(f),
        f = f + 1
        IF multiple(f) = 0 THEN EXIT DO
        PRINT multiple(f),
        f = f + 1
        IF multiple(f) = 0 THEN EXIT DO
        PRINT multiple(f),
        f = f + 1
        IF multiple(f) = 0 THEN EXIT DO
        LOOP
END IF
COLOR 15
END SUB

