totaltop:
CLS
LOCATE 12, 25.5
COLOR 14
guessnumberchances = -1
guesswrong = 0
guessright = 0
PRINT "****  Welcome to ";
COLOR 25, 12: PRINT "G"; : COLOR 28, 12: PRINT "U"; : COLOR 26, 12: PRINT "E"; : COLOR 31, 12: PRINT "S"; : COLOR 29, 12: PRINT "S"; : COLOR 27, 12: PRINT "!"; : COLOR 14, 0: PRINT "  ****";

r = 100
FOR i = 1 TO 30
r = r + 20
SOUND r, 1
NEXT i

SLEEP 1
top: CLS
LOCATE 8, 27
COLOR 9
PRINT "What would you like to do? "
PRINT
PRINT

COLOR 14
PRINT SPC(20); "*  Play the original ";
COLOR 9, 12: PRINT "G"; : COLOR 12, 12: PRINT "U"; : COLOR 10, 12: PRINT "E"; : COLOR 15, 12: PRINT "S"; : COLOR 13, 12: PRINT "S"; : COLOR 11, 12: PRINT "!"; : COLOR 14, 0: PRINT "  (g)"
PRINT

PRINT SPC(20); "*  Play ";
COLOR 9, 9: PRINT "C"; : COLOR 12, 9: PRINT "O"; : COLOR 10, 9: PRINT "L"; : COLOR 13, 9: PRINT "O"; : COLOR 11, 9: PRINT "R"; : COLOR 0, 0: PRINT " ";
COLOR 9, 12: PRINT "G"; : COLOR 12, 12: PRINT "U"; : COLOR 10, 12: PRINT "E"; : COLOR 15, 12: PRINT "S"; : COLOR 13, 12: PRINT "S"; : COLOR 11, 12: PRINT "!"; : COLOR 14, 0: PRINT "  (c)"

PRINT
PRINT SPC(20); "*  Play 2 player ";
COLOR 9, 12: PRINT "G"; : COLOR 12, 12: PRINT "U"; : COLOR 10, 12: PRINT "E"; : COLOR 15, 12: PRINT "S"; : COLOR 13, 12: PRINT "S"; : COLOR 11, 12: PRINT "!"; : COLOR 14, 0: PRINT "  (2)"

PRINT
PRINT SPC(20); "*  Quit  (q)"
LOCATE 8, 55
COLOR 9
INPUT "", what$
IF what$ = "g" OR what$ = "G" THEN guessmusic$ = "t200l8cege>l4c": PLAY guessmusic$: GOTO guess
'IF what$ = "c" OR what$ = "C" THEN colormusic$ = "t200l4cl8edl4c>c": PLAY colormusic$: GOTO colorguess
'IF what$ = "2" OR what$ = "Two" OR what$ = "two" OR what$ = "TWO" THEN music2$ = "t200l8cg>c<gc": PLAY music2$: GOTO two
'IF what$ = "q" OR what$ = "Q" THEN quitmusic$ = "t100l6fl18cccl6dl3cl6el3f": PLAY quitmusic$: GOTO quit
GOTO top



guess:
CLS
LOCATE 5, 23
COLOR 2, 0
PRINT SPC(3); "You chose the original ";
COLOR 9, 12: PRINT "G"; : COLOR 12, 12: PRINT "U"; : COLOR 10, 12: PRINT "E"; : COLOR 15, 12: PRINT "S"; : COLOR 13, 12: PRINT "S"; : COLOR 11, 12: PRINT "!"; : COLOR 16, 0
SLEEP 3
guesspicker: CLS
LOCATE 3, 10
COLOR 15
PRINT "What level would you like?  "
PRINT
PRINT SPC(5); "Level", "     Numbers to guess", "    Chances"
PRINT
PRINT SPC(5); "  1", "          0 - 5", "       3"
PRINT
PRINT SPC(5); "  2", "          0 - 8", "       4"
PRINT
PRINT SPC(5); "  3", "          0 - 11", "       4"
PRINT
PRINT SPC(5); "  4", "          0 - 14", "       5"
PRINT
PRINT SPC(5); "  5", "          0 - 20", "       5"
PRINT
PRINT SPC(3); "Custom (c)", "       Your choice", "  Your choice"
LOCATE 3, 38
INPUT "", guesslevel$
IF guesslevel$ = "1" OR guesslevel$ = "one" OR guesslevel$ = "One" OR guesslevel$ = "ONE" THEN LET guessmax = 5: LET guessmin = 0: guesschances = 3: GOTO guessready
IF guesslevel$ = "2" OR guesslevel$ = "two" OR guesslevel$ = "Two" OR guesslevel$ = "TWO" THEN LET guessmax = 8: LET guessmin = 0: guesschances = 4: GOTO guessready
IF guesslevel$ = "3" OR guesslevel$ = "three" OR guesslevel$ = "Three" OR guesslevel$ = "THREE" THEN LET guessmax = 11: LET guessmin = 0: guesschances = 4: GOTO guessready
IF guesslevel$ = "4" OR guesslevel$ = "four" OR guesslevel$ = "Four" OR guesslevel$ = "FOUR" THEN LET guessmax = 14: LET guessmin = 0: guesschances = 5: GOTO guessready
IF guesslevel$ = "5" OR guesslevel$ = "five" OR guesslevel$ = "Five" OR guesslevel$ = "FIVE" THEN LET guessmax = 20: LET guessmin = 0: guesschances = 5: GOTO guessready
IF guesslevel$ = "c" OR guesslevel$ = "C" OR guesslevel$ = "custom" OR guesslevel$ = "Custom" OR guesslevel$ = "CUSTOM" THEN GOTO custom
GOTO guesspicker




custom:
CLS
LOCATE 5, 10
INPUT "What would you like your minimun number to be?", guessmin
LOCATE 6, 10
INPUT "What would you like your maximum number to be?", guessmax
LOCATE 7, 10
INPUT "How many chance would you like?", guesschances
GOTO guessready



guessready:
CLS
PRINT "Object:  You have"; guesschances; "chances to guess the correct number between"; guessmin; "and"; guessmax; "."
PRINT "Press any key to begin the game."
DO WHILE INKEY$ = ""
LOOP
LOCATE 10, 30
COLOR 4
PRINT "Ready!"
SLEEP 1
LOCATE 12, 30
COLOR 6
PRINT "Set!"
LOCATE 14, 30
COLOR 2
PRINT "GO!!!"
SLEEP 1
RANDOMIZE TIMER
guessnumber = INT(RND * guessmax) + guessmin
    
CLS
guessing:
guessnumberchances = guessnumberchances + 1
COLOR 3, 0
PRINT "What's your guess?  (it must be between"; guessmin; "and"; guessmax; ".";
INPUT "  ", whatguess
IF whatguess = guessnumber THEN PRINT "Good job!": SOUND 1000, 10: LET guessright = guessright + 1: SLEEP 3: CLS : GOTO done
IF whatguess <> guessnumber AND guesswrong <> guessnumberchances THEN PRINT "Sorry.": SOUND 100, 18: LET guesswrong = guesswrong + 1: SLEEP 3: GOTO guessing
GOTO guessing
        IF guesswrong = guessnumberchances THEN
                PRINT "Sorry, the number was"; guessnumber; "."
                SLEEP 3
                GOTO totaldone
                END IF
done:
SELECT CASE guesswrong

CASE 0
PRINT "WOW!  You got it on your first try!"
GOTO totaldone

CASE 1 TO 2
PRINT "Good Job!  You got"; guessright; "correct and"; guesswrong; "wrong."
GOTO totaldone

CASE 3 TO 4
PRINT "Well, you could have done worse, I guess.  You got"; guessright; " correct and"; guesswrong; "wrong."
GOTO totaldone

CASE 5 TO 20
PRINT "Not good. Nope. Not good at all.  You got"; guessright; "correct and"; guesswrong; "wrong."
GOTO totaldone

CASE ELSE
PRINT "Terrible!  You got"; guessright; "correct and"; guesswrong; "wrong."
GOTO totaldone

END SELECT
totaldone:
SLEEP 5
totaldonee:
CLS
LINE INPUT "Would you like to play again? y/n  ", playagain$
IF playagain$ = "y" OR playagain$ = "Y" THEN GOTO totaltop
IF playagain$ = "n" OR playagain$ = "N" THEN END
PRINT "You must type in a Y or a N."
SLEEP 3
GOTO totaldonee

