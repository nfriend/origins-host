CLS
OPEN "./save/dctionry.txt" FOR APPEND AS #1
here:
INPUT "Word?  ", word$
IF word$ = "9" THEN CLOSE : END
PRINT #1, word$
RANDOMIZE TIMER
n = INT(RND * 9) + 3

RANDOMIZE TIMER
where = INT(RND * 42) + 1
IF where = 1 THEN GOTO normletter: LET what$ = "beginning"
IF where = 2 THEN GOTO doubleletter: LET what$ = "beginning"

DO UNTIL f = 5
IF f = n THEN GOTO ending
normletter:
f = f + 1
IF f >= n THEN GOTO ending
RANDOMIZE TIMER
letter = INT(RND * 26) + 1
IF letter = 1 THEN LET letter$ = "a"
IF letter = 2 THEN LET letter$ = "b"
IF letter = 3 THEN LET letter$ = "c"
IF letter = 4 THEN LET letter$ = "d"
IF letter = 5 THEN LET letter$ = "e"
IF letter = 6 THEN LET letter$ = "f"
IF letter = 7 THEN LET letter$ = "g"
IF letter = 8 THEN LET letter$ = "h"
IF letter = 9 THEN LET letter$ = "i"
IF letter = 10 THEN LET letter$ = "j"
IF letter = 11 THEN LET letter$ = "k"
IF letter = 12 THEN LET letter$ = "l"
IF letter = 13 THEN LET letter$ = "m"
IF letter = 14 THEN LET letter$ = "n"
IF letter = 15 THEN LET letter$ = "o"
IF letter = 16 THEN LET letter$ = "p"
IF letter = 17 THEN LET letter$ = "q"
IF letter = 18 THEN LET letter$ = "r"
IF letter = 19 THEN LET letter$ = "s"
IF letter = 20 THEN LET letter$ = "t"
IF letter = 21 THEN LET letter$ = "u"
IF letter = 22 THEN LET letter$ = "v"
IF letter = 23 THEN LET letter$ = "w"
IF letter = 24 THEN LET letter$ = "x"
IF letter = 25 THEN LET letter$ = "y"
IF letter = 26 THEN LET letter$ = "z"
PRINT #1, letter$;
IF letter$ = "a" OR letter$ = "e" OR letter$ = "i" OR letter$ = "o" OR letter$ = "u" AND what$ = "beginning" THEN GOTO normletter
GOTO vowel



doubleletter:
f = f + 1
IF f >= n THEN GOTO ending
RANDOMIZE TIMER
letter = INT(RND * 15) + 1
IF letter = 1 THEN LET letter$ = "ch"
IF letter = 2 THEN LET letter$ = "sl"
IF letter = 3 THEN LET letter$ = "sp"
IF letter = 4 THEN LET letter$ = "sn"
IF letter = 5 THEN LET letter$ = "sm"
IF letter = 6 THEN LET letter$ = "sw"
IF letter = 7 THEN LET letter$ = "st"
IF letter = 8 THEN LET letter$ = "scr"
IF letter = 9 THEN LET letter$ = "sh"
IF letter = 10 THEN LET letter$ = "tr"
IF letter = 11 THEN LET letter$ = "pl"
IF letter = 12 THEN LET letter$ = "pr"
IF letter = 13 THEN LET letter$ = "kn"
IF letter = 14 THEN LET letter$ = "cl"
IF letter = 15 THEN LET letter$ = "cr"
GOTO normletter
PRINT #1, letter$;

ending:
f = f + 1

RANDOMIZE TIMER
letter = INT(RND * 9) + 1
IF letter = 1 THEN LET letter$ = "ch"
IF letter = 2 THEN LET letter$ = "ple"
IF letter = 3 THEN LET letter$ = "cle"
IF letter = 4 THEN LET letter$ = "cr"
IF letter = 5 THEN LET letter$ = "ck"
IF letter = 6 THEN LET letter$ = "lp"
IF letter = 7 THEN LET letter$ = "wn"
IF letter = 8 THEN LET letter$ = "er"
IF letter = 8 THEN LET letter$ = "ke"
PRINT #1, letter$;
GOTO here

vowel:
f = f + 1
IF f >= n THEN GOTO ending
RANDOMIZE TIMER
letter = INT(RND * 5) + 1
IF letter = 1 THEN LET letter$ = "a"
IF letter = 2 THEN LET letter$ = "e"
IF letter = 3 THEN LET letter$ = "i"
IF letter = 4 THEN LET letter$ = "o"
IF letter = 5 THEN LET letter$ = "u"
PRINT #1, letter$;
GOTO normletter
LOOP























