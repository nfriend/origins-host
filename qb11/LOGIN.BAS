DECLARE SUB new ()
DECLARE SUB login ()
CLS
SCREEN 0
LOCATE 12, 32
COLOR 10
PRINT "Welcome to LOGIN!"



LOCATE 11, 29: COLOR 20: PRINT STRING$(23, "*"): LOCATE 13, 29: COLOR 20: PRINT STRING$(23, "*"): LOCATE 12, 29: COLOR 20: PRINT "*": LOCATE 12, 51: COLOR 20: PRINT "*"
music$ = "t450l4Fl8CCl4f>l2c": PLAY music$
SLEEP 2
CLS

DEF FNcentr$ (pStr$)
IF LEN(pStr) > 80 THEN
        FNcentr$ = pStr$

        EXIT DEF
    END IF
    stLen = LEN(pStr$)
    outStr$ = SPACE$(80)

    MID$(outStr$, (80 - stLen) / 2) = pStr$
    FNcentr$ = outStr$
END DEF

top:
COLOR 14
CLS
LOCATE 8, 10
PRINT "1.  Login"
LOCATE 10, 10
PRINT "2.  Create a new log"
LOCATE 12, 10
PRINT "3.  Quit"
LOCATE 6, 10
INPUT "What would you like to do?  ", what
SELECT CASE what
CASE 1
        CALL login
CASE 2
        CALL new
CASE 3
        END
CASE 67
       CLS
       KILL "c:/QSAVE/username.txt"
       KILL "c:/QSAVE/password.txt"
       PRINT "All logs have been erased."
       END
CASE ELSE
        GOTO top
END SELECT

SUB login
COLOR 2
chances = 3
logintop:
PRINT
PRINT
CLS
LINE INPUT "Username?   ", username$
CLS
PRINT "Password?   ";
DO
i$ = INKEY$
IF i$ <> "" AND i$ <> CHR$(13) THEN PRINT "*"; : password$ = password$ + i$
LOOP UNTIL i$ = CHR$(13)
PRINT ""
OPEN "c:/QSAVE/username.txt" FOR INPUT AS #1
OPEN "c:/QSAVE/password.txt" FOR INPUT AS #2
DO UNTIL EOF(1)
INPUT #1, name$
INPUT #2, pass$
IF name$ = username$ AND pass$ = password$ THEN LET what$ = "right": GOTO done
LOOP
LET what$ = "wrong"

done:
PRINT
totaldone:
COLOR 15
IF what$ = "right" THEN
        PRINT "Login Succesful"
ELSE
        IF chances <> 0 THEN PRINT "Login name and/or password incorrect.  You now have "; chances; " tries left.": LET chances = chances - 1: GOTO logintop
        IF chances = 0 THEN PRINT "Login name and/or password incorrect.": END
END IF

END SUB

SUB new
CLS
COLOR 9
LINE INPUT "What would you like you username to be?  ", name$
CLS
password:
PRINT "Password?  ";
DO
i$ = INKEY$
IF i$ <> "" AND i$ <> CHR$(13) THEN PRINT "*"; : pass$ = pass$ + i$
LOOP UNTIL i$ = CHR$(13)
PRINT ""
PRINT
PRINT "Please confirm your password:  ";
DO
i$ = INKEY$
IF i$ <> "" AND i$ <> CHR$(13) THEN PRINT "*"; : passs$ = passs$ + i$
LOOP UNTIL i$ = CHR$(13)
COLOR 15
PRINT ""
IF pass$ = passs$ THEN
        GOTO nexts
ELSE
        PRINT
        PRINT "Sorry, the passwords that you typed in were not identicle.  Please try again."
        PRINT "Press any key to continue..."
        DO WHILE INKEY$ = ""
        LOOP
        CLS
        GOTO password
END IF


nexts:
OPEN "c:/QSAVE/username.txt" FOR APPEND AS #1
PRINT #1, name$
OPEN "c:/QSAVE/password.txt" FOR APPEND AS #2
PRINT #2, pass$
CLOSE
CLS
PRINT
PRINT "Your password and username have been saved."
END SUB

