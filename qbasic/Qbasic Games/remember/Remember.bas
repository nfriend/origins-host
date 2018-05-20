







'                          Press Alt, B, A to quit                           '









DECLARE FUNCTION einde ()
DECLARE FUNCTION herhaal ()
DECLARE FUNCTION foutje ()
DECLARE SUB tonen ()
COMMON SHARED toon%, reeks$, level%, fout%, score%
RANDOMIZE (TIMER)
PRINT "ready?"
DO: LOOP UNTIL INKEY$ <> ""
begin:
CLEAR : CLS : SCREEN 13: LOCATE 3, 11: COLOR 9: PRINT "The big remember-game": COLOR 31
LINE (60, 100)-(270, 150), 26, BF
LINE (60, 100)-(270, 150), 30, B
FOR x = 90 TO 240 STEP 30
LINE (x, 100)-(x, 150), 30
NEXT x
LOCATE 16, 10: PRINT "1"
LOCATE 16, 14: PRINT "2"
LOCATE 16, 18: PRINT "3"
LOCATE 16, 21: PRINT "4"
LOCATE 16, 25: PRINT "5"
LOCATE 16, 29: PRINT "6"
LOCATE 16, 33: PRINT "7"
DO
level% = level% + 1
fout% = 0
COLOR 14: LOCATE 1, 1: PRINT USING "level : ##"; level%: COLOR 31
tonen
IF herhaal THEN GOTO begin
LOOP
DATA Now thas was hard, Now you really had to think, Wow You can remember three in a row, Well well you are beginning to get smart, I really didn't expect you to come this far, This stuff isn't easy is it, This is claimed to be the average, Congratulations
DATA You should no be over the average, Do you have a photographic memory?, I think you're just writing them down, Are you gifted??

FUNCTION einde
CLS : LOCATE 10, 17: PRINT "THE END"
LOCATE 12, 3: PRINT USING "Well, you still got #### points"; score%
LOCATE 18, 10: PRINT "Again?"
DO: a$ = INKEY$: LOOP UNTIL a$ = "y" OR a$ = "n"
IF a$ = "n" THEN SYSTEM
einde = 1
END FUNCTION

FUNCTION foutje
IF fout% = 0 THEN LOCATE 10: PRINT "I hope that was a typing error."
IF fout% = 1 THEN LOCATE 10, 6: PRINT "Now is was really WRONG!": foutje = einde
fout% = 1
BEEP
SLEEP 3
LOCATE 10: PRINT STRING$(45, " "): LOCATE 8, 19: PRINT "    "
END FUNCTION

FUNCTION herhaal
LOCATE 5, 7: PRINT "Now repeat those keypresses."
FOR i% = 1 TO level%
fout% = 0
10
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "1" THEN PAINT (70, 120), 20, 30: LOCATE 16, 10: PRINT "1": PLAY "c": SLEEP 1: PAINT (70, 120), 26, 30: LOCATE 16, 10: PRINT "1": toon$ = "c"
IF a$ = "2" THEN PAINT (100, 120), 20, 30: LOCATE 16, 14: PRINT "2": PLAY "d": SLEEP 1: PAINT (100, 120), 26, 30: LOCATE 16, 14: PRINT "2": toon$ = "d"
IF a$ = "3" THEN PAINT (130, 120), 20, 30: LOCATE 16, 18: PRINT "3": PLAY "e": SLEEP 1: PAINT (130, 120), 26, 30: LOCATE 16, 18: PRINT "3": toon$ = "e"
IF a$ = "4" THEN PAINT (160, 120), 20, 30: LOCATE 16, 21: PRINT "4": PLAY "f": SLEEP 1: PAINT (160, 120), 26, 30: LOCATE 16, 21: PRINT "4": toon$ = "f"
IF a$ = "5" THEN PAINT (190, 120), 20, 30: LOCATE 16, 25: PRINT "5": PLAY "g": SLEEP 1: PAINT (190, 120), 26, 30: LOCATE 16, 25: PRINT "5": toon$ = "g"
IF a$ = "6" THEN PAINT (220, 120), 20, 30: LOCATE 16, 29: PRINT "6": PLAY "a": SLEEP 1: PAINT (220, 120), 26, 30: LOCATE 16, 29: PRINT "6": toon$ = "a"
IF a$ = "7" THEN PAINT (250, 120), 20, 30: LOCATE 16, 33: PRINT "7": PLAY "b": SLEEP 1: PAINT (250, 120), 26, 30: LOCATE 16, 33: PRINT "7": toon$ = "b"
IF a$ = CHR$(27) THEN END
IF a$ <> "1" AND a$ <> "2" AND a$ <> "3" AND a$ <> "4" AND a$ <> "5" AND a$ <> "6" AND a$ <> "7" THEN 10
con$ = LEFT$(reeks$, i% + 6)
con$ = RIGHT$(con$, 1)
IF toon$ <> con$ THEN LOCATE 8, 19: PRINT "Wrong": break% = foutje
herhaal = break%
IF break% GOTO eind
IF fout% = 1 THEN GOTO 10
score% = score% + 10 * level%
COLOR 74: LOCATE 1, 26: PRINT USING "Score : ####"; score%: COLOR 31
NEXT i%
LOCATE 10, 10: READ tekst$: PRINT tekst$
LOCATE 5, 7: PRINT STRING$(29, " ")
SLEEP 2
LOCATE 8, 19: PRINT STRING$(4, " ")
LOCATE 10: PRINT STRING$(100, " ")
eind:
END FUNCTION

SUB tonen
reeks$ = "o2 mf "
PLAY reeks$
FOR i% = 1 TO level%
toon% = INT(7 * RND) + 1
IF toon% = 1 THEN reeks$ = reeks$ + "c": PAINT (70, 120), 20, 30: LOCATE 16, 10: PRINT "1": PLAY "c": SLEEP 1: PAINT (70, 120), 26, 30: LOCATE 16, 10: PRINT "1"
IF toon% = 2 THEN reeks$ = reeks$ + "d": PAINT (100, 120), 20, 30: LOCATE 16, 14: PRINT "2": PLAY "d": SLEEP 1: PAINT (100, 120), 26, 30: LOCATE 16, 14: PRINT "2"
IF toon% = 3 THEN reeks$ = reeks$ + "e": PAINT (130, 120), 20, 30: LOCATE 16, 18: PRINT "3": PLAY "e": SLEEP 1: PAINT (130, 120), 26, 30: LOCATE 16, 18: PRINT "3"
IF toon% = 4 THEN reeks$ = reeks$ + "f": PAINT (160, 120), 20, 30: LOCATE 16, 21: PRINT "4": PLAY "f": SLEEP 1: PAINT (160, 120), 26, 30: LOCATE 16, 21: PRINT "4"
IF toon% = 5 THEN reeks$ = reeks$ + "g": PAINT (190, 120), 20, 30: LOCATE 16, 25: PRINT "5": PLAY "g": SLEEP 1: PAINT (190, 120), 26, 30: LOCATE 16, 25: PRINT "5"
IF toon% = 6 THEN reeks$ = reeks$ + "a": PAINT (220, 120), 20, 30: LOCATE 16, 29: PRINT "6": PLAY "a": SLEEP 1: PAINT (220, 120), 26, 30: LOCATE 16, 29: PRINT "6"
IF toon% = 7 THEN reeks$ = reeks$ + "b": PAINT (250, 120), 20, 30: LOCATE 16, 33: PRINT "7": PLAY "b": SLEEP 1: PAINT (250, 120), 26, 30: LOCATE 16, 33: PRINT "7"
NEXT i%
END SUB

