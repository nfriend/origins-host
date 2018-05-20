DECLARE SUB delete ()
DECLARE SUB morsecode ()
COMMON SHARED i$, morse$, column, c, typed$
DIM SHARED recent$(6000)
CLS
COLOR 15
column = 1
c = 1
PLAY "t200"
DO UNTIL i$ = CHR$(27)

i$ = INKEY$
IF i$ = CHR$(27) THEN END
IF i$ = CHR$(8) THEN delete
IF i$ <> "" THEN LET recent$(h) = i$: LET h = h + 1: morsecode
LOOP

SUB delete

DO UNTIL recent$(e) = ""
LET e = e + 1
LOOP

d = e - 1

LET length = LEN(recent$(d))

IF c = 1 THEN GOTO newlinedelete

j = c
jj = cc
c = c + 1

FOR i = j + length TO j STEP -1
        LOCATE column, c
        c = c - 1
        COLOR 0
        PRINT CHR$(219)
NEXT i

COLOR 15
LOCATE column, c
GOTO finish


newlinedelete:

LET column = column - 1

FOR i = jj + length TO jj STEP -1
        LOCATE column, cc
        cc = cc - 1
        COLOR 0
        PRINT CHR$(219)
NEXT i

LOCATE column, cc


finish:
LET recent$(d) = ""
COLOR 15
END SUB

SUB morsecode
IF i$ = "a" OR i$ = "A" THEN LET morse$ = "01"
IF i$ = "b" OR i$ = "B" THEN LET morse$ = "1000"
IF i$ = "c" OR i$ = "C" THEN LET morse$ = "1010"
IF i$ = "d" OR i$ = "D" THEN LET morse$ = "100"
IF i$ = "e" OR i$ = "E" THEN LET morse$ = "0"
IF i$ = "f" OR i$ = "F" THEN LET morse$ = "0010"
IF i$ = "g" OR i$ = "G" THEN LET morse$ = "110"
IF i$ = "h" OR i$ = "H" THEN LET morse$ = "0000"
IF i$ = "i" OR i$ = "I" THEN LET morse$ = "00"
IF i$ = "j" OR i$ = "J" THEN LET morse$ = "0111"
IF i$ = "k" OR i$ = "K" THEN LET morse$ = "101"
IF i$ = "l" OR i$ = "L" THEN LET morse$ = "0100"
IF i$ = "m" OR i$ = "M" THEN LET morse$ = "11"
IF i$ = "n" OR i$ = "N" THEN LET morse$ = "10"
IF i$ = "o" OR i$ = "O" THEN LET morse$ = "111"
IF i$ = "p" OR i$ = "P" THEN LET morse$ = "0110"
IF i$ = "q" OR i$ = "Q" THEN LET morse$ = "1101"
IF i$ = "r" OR i$ = "R" THEN LET morse$ = "010"
IF i$ = "s" OR i$ = "S" THEN LET morse$ = "000"
IF i$ = "t" OR i$ = "T" THEN LET morse$ = "1"
IF i$ = "u" OR i$ = "U" THEN LET morse$ = "001"
IF i$ = "v" OR i$ = "V" THEN LET morse$ = "0001"
IF i$ = "w" OR i$ = "W" THEN LET morse$ = "011"
IF i$ = "x" OR i$ = "X" THEN LET morse$ = "1001"
IF i$ = "y" OR i$ = "Y" THEN LET morse$ = "1011"
IF i$ = "z" OR i$ = "Z" THEN LET morse$ = "1100"

IF i$ = "0" THEN LET morse$ = "01111"
IF i$ = "1" THEN LET morse$ = "00111"
IF i$ = "2" THEN LET morse$ = "00011"
IF i$ = "3" THEN LET morse$ = "00001"
IF i$ = "4" THEN LET morse$ = "00000"
IF i$ = "5" THEN LET morse$ = "10000"
IF i$ = "6" THEN LET morse$ = "11000"
IF i$ = "7" THEN LET morse$ = "11100"
IF i$ = "8" THEN LET morse$ = "11110"
IF i$ = "9" THEN LET morse$ = "11111"

IF i$ = " " THEN PRINT "   "; : LET c = c + 3: GOTO done

LET tempmorse$ = morse$

IF c > 70 THEN
        LET cc = c
        LET column = column + 1
        LOCATE column, 1
        PRINT "";
        LET c = 1
END IF


FOR i = 1 TO LEN(morse$)
LET temp$ = MID$(morse$, i, 1)
IF temp$ = "0" THEN PRINT CHR$(249); " "; : LET c = c + 2
IF temp$ = "1" THEN PRINT "-"; " "; : LET c = c + 2
NEXT i


FOR i = 1 TO LEN(morse$)
LET temp$ = MID$(morse$, i, 1)
IF temp$ = "0" THEN PLAY "l24cp8"
IF temp$ = "1" THEN PLAY "l8cp8"
NEXT i




PRINT " "; : c = c + 1

LET i$ = ""
LET temp$ = ""
LET morse$ = ""
PLAY "p8"

done:
END SUB

