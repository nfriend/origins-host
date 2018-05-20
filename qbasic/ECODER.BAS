CLS
top:
INPUT "File name?  ", filename$
LINE INPUT "What would you like you password to be?  ", password$
IF LEN(filename$) > 8 THEN PRINT "Sorry, your file name must be equal to or less than 8 characters long.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO top
IF LEN(filename$) = 0 THEN PRINT "Please type in a filename.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO top
LET file$ = "c:/Qsave/" + filename$ + ".txt"
FOR i = 1 TO LEN(password$)
IF ASC(MID$(password$, i, i)) <= 5 OR ASC(MID$(password$, i, i)) >= 250 THEN PRINT "An error occured while checking your password.": PRINT "Press any key to continue...": DO WHILE INKEY$ = "": LOOP: CLS : GOTO top
NEXT i

'FOR e = 1 TO LEN(password$)
'LET temp = ASC(MID$(password$, e, e))
'd$ = CHR$(temp - 5)
'LET npassword$ = npassword$ + d$
'NEXT e

OPEN "./save/" + filename$ + ".txt" FOR OUTPUT AS #1
PRINT #1, password$
CLOSE


FOR e = 1 TO LEN(password$)
LET temp = ASC(MID$(password$, e, e))
LET g = g + temp
NEXT e



CLS
PRINT "Type your message now:"
PRINT

OPEN "./save/" + filename$ + ".txt" FOR APPEND AS #1

DO UNTIL h$ = CHR$(27)
h$ = INKEY$
IF h$ = CHR$(27) THEN EXIT DO
IF h$ <> "" THEN
        RANDOMIZE g
        y = INT(RND * 100) + 1
        PRINT #1, ASC(h$) + y
        LET g = g + 17
        PRINT CHR$(ASC(h$));
        END IF
LOOP
CLOSE
END

