DECLARE SUB get411 ()
DECLARE SUB getnow411 ()

COMMON SHARED year, month, day, hour, minute, second
COMMON SHARED nowyear, nowmonth, nowday, nowhour, nowminute, nowsecond

CLS

get411

getnow411

ageyear = nowyear - year
IF nowmonth < month THEN LET ageyear = ageyear - 1
IF nowmonth = month AND nowday < day THEN LET ageyear = ageyear - 1
IF nowmonth = month AND nowday = day AND nowhour < hour THEN LET ageyear = ageyear - 1
IF nowmonth = month AND nowday = day AND nowhour = hour AND nowminute < minute THEN LET ageyear = ageyear - 1
IF nowmonth = month AND nowday = day AND nowhour = hour AND nowminute = minute AND nowsecond < second THEN ageyear = ageyear - 1
IF nowmonth = month AND nowday = day AND nowhour = hour AND nowminute = minute AND nowsecond = second THEN LET ageyear = ageyear

IF nowmonth < month THEN LET agemonth = 12 - (month - nowmonth)
IF nowmonth - 1 = month AND nowday > day THEN LET month = 11
IF nowmonth > month THEN LET agemonth = nowmonth - month
IF nowmonth = month THEN LET agemonth = 0
IF nowday = day AND nowhour < hour THEN LET agemonth = agemonth - 1
IF nowday = day AND nowhour = hour AND nowminute < minute THEN LET agemonth = agemonth - 1
IF nowday = day AND nowhour = hour AND nowminute = minute AND nowsecond < second THEN LET agemonth = agemonth - 1
IF nowday = day AND nowhour = hour AND nowminute = minute AND nowsecond = second THEN LET agemonth = agemonth

IF nowday < day THEN LET ageday = day - nowday
IF nowday > day THEN LET ageday = nowday - day
IF nowday = day THEN LET ageday = 0
IF nowhour = hour AND nowminute < minute THEN LET ageday = ageday - 1

IF nowhour < hour THEN LET agehour = hour - nowhour
IF nowhour > hour THEN LET agehour = nowhour - hour
IF nowhour = hour THEN LET agehour = 0
IF nowminute = hour AND nowsecond < minute THEN LET agehour = agehour - 1

IF nowminute < minute THEN LET ageminute = minute - nowminute
IF nowminute > minute THEN LET ageminute = nowminute - minute
IF nowminute = minute THEN LET ageminute = 0

IF nowsecond < second THEN LET agesecond = second - nowsecond
IF nowsecond > second THEN LET agesecond = nowsecond - second
IF nowsecond = second THEN LET agesecond = 0

CLS
PRINT "You at this very moment are:"
PRINT
PRINT ""; ageyear; " year(s) old"
PRINT ""; agemonth; " month(s) old"
PRINT ""; ageday; " day(s) old"
PRINT ""; agehour; " hour(s) old"
PRINT ""; ageminute; " minute(s) old"
PRINT ""; agesecond; " second(s) old"
END

SUB get411
year:
INPUT "What year were you born in? (Please include all 4 digits)   ", year
thisyear = VAL(MID$(DATE$, 7, 10))
SELECT CASE year
        CASE 1900 TO thisyear
        CASE IS > thisyear
                CLS
                PRINT "Ha Ha Ha!  Don't try any funny stuff!  You were NOT born in the future!"
                PRINT "Press any key to continue..."
                DO WHILE INKEY$ = ""
                LOOP
                CLS
                GOTO year
        CASE IS < 1900
                CLS
                old = thisyear - year
                PRINT "Yeah, you think that you are pretty funny, don't you? "
                PRINT "You are not"; old; "year old!!!"
                PRINT "Press any key to continue..."
                DO WHILE INKEY$ = ""
                LOOP
                CLS
                GOTO year

END SELECT

CLS
month:
INPUT "What month were you born in? (Please type it in numbers)   ", month
SELECT CASE month
CASE 1 TO 12
CASE ELSE
        CLS
        PRINT "Your number must be between 1 and 12."
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        CLS
        GOTO month
END SELECT

day:
CLS
INPUT "What day were you born on? (Please use numbers)   ", day
SELECT CASE day
CASE 1 TO 31
CASE ELSE
CLS
PRINT "You must type in a number between 1 and 31."
PRINT "Press any key to continue..."
DO WHILE INKEY$ = ""
LOOP
CLS
GOTO day

END SELECT


hour:
CLS
INPUT "What hour were you born in? (If you don't know, type in ?)   ", hour$
PRINT
SELECT CASE VAL(hour$)
CASE 1 TO 12
CASE ELSE
        SELECT CASE hour$
        CASE "?"
        CASE ELSE
        CLS
        PRINT "You must type in a number between 1 and 12 or a ?"
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        GOTO hour
        END SELECT
END SELECT

ampm:
IF hour$ = "?" THEN
        PRINT "Were you born in AM or PM? (Again, if you don't know, type ?)   "
        LOCATE 4, 1
        PRINT "AM = a or A     PM = p or P"
        LOCATE 5, 1
        INPUT "", ampm$
        IF ampm$ = "p" OR ampm$ = "P" THEN LET hour = 12
        IF ampm$ = "a" OR ampm$ = "A" THEN LET hour = 0
        IF ampm$ <> "p" AND ampm$ <> "P" AND ampm$ <> "a" AND ampm$ <> "A" AND ampm$ <> "?" THEN CLS : PRINT "Sorry, but you answer must be an 'a', a 'p', or a '?'.  Press any key to cont.": DO WHILE INKEY$ = "": LOOP: CLS : GOTO ampm
        IF ampm$ = "?" THEN LET hour = 0
ELSE
        IF VAL(hour$) > 12 THEN PRINT "Sorry, but your answer must be between 1 and 12": DO WHILE INKEY$ = "": LOOP: CLS : GOTO hour
        PRINT "Were you born at "; hour$; " AM or "; hour$; " PM?  (Type in ? in you are unsure)   "
        PRINT "AM = a or A     PM = p or P"
        INPUT "", ampm$
        LOCATE 2, 1
        PRINT "AM = a or A     PM = p or P"
        IF ampm$ = "p" OR ampm$ = "P" THEN LET hour = VAL(hour$) + 12
        IF ampm$ = "a" OR ampm$ = "A" THEN LET hour = VAL(hour$)
        IF ampm$ = "?" THEN LET hour = VAL(hour$)
        IF ampm$ <> "p" AND ampm$ <> "P" AND ampm$ <> "a" AND ampm$ <> "A" AND ampm$ <> "?" THEN CLS : PRINT "Sorry, but your answer must be an 'a', a 'p', or a '?'.  Press any key to cont.": DO WHILE INKEY$ = "": LOOP: CLS : GOTO ampm
        END IF

CLS
minute:
INPUT "What minute were you born at? (If you don't know, type in... well, you know)  ", minute$

IF minute$ = "0" OR minute$ = "00" THEN GOTO second

IF minute$ = "?" THEN
        LET minute = 0
ELSE
        
        IF VAL(minute$) < 60 AND VAL(minute$) > 0 THEN LET minute = VAL(minute$): GOTO second
        IF VAL(minute$) > 60 AND VAL(minute$) < 1 THEN CLS : PRINT "Your number cannot excede 60 or be below 0. Press any key to continue...": DO WHILE INKEY$ = "; ": LOOP: CLS : GOTO minute
        CLS
        PRINT "You must type in a number between 1 and 60 or a ?"
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        CLS
        GOTO minute
END IF

CLS
second:
INPUT "What second were you born at? (You will probably be typing in ?)   ", second$

IF second$ = "0" OR second$ = "00" THEN GOTO done

IF second$ = "?" THEN
        LET second = 0
ELSE
        IF VAL(second$) < 60 AND VAL(second$) > 1 THEN LET second = VAL(second$): GOTO done
        IF VAL(second$) > 60 AND VAL(second$) < 0 THEN CLS : PRINT "Your number cannot excede 60 or be below 0. Press any key to continue...": DO WHILE INKEY$ = "; ": LOOP: CLS : GOTO second
        CLS
        PRINT "You must type in a number between 1 and 60 or a ?"
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        CLS
        GOTO second
END IF

done:
END SUB

SUB getnow411
anowyear$ = MID$(DATE$, 7, 4)
anowmonth$ = MID$(DATE$, 1, 2)
anowday$ = MID$(DATE$, 4, 2)
anowhour$ = MID$(TIME$, 1, 2)
anowminute$ = MID$(TIME$, 4, 2)
anowsecond$ = MID$(TIME$, 7, 2)

nowyear = VAL(anowyear$)
nowmonth = VAL(anowmonth$)
nowday = VAL(anowday$)
nowhour = VAL(anowhour$)
nowminute = VAL(anowminute$)
nowsecond = VAL(anowsecond$)
END SUB

