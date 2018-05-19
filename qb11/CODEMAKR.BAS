
CLS
DIM small$(97 TO 122)
DIM capital$(65 TO 90)
DIM punc1$(33 TO 47)
DIM punc2$(58 TO 64)
DIM punc3$(91 TO 96)
DIM punc4$(123 TO 126)
DIM number$(48 TO 57)

PRINT "Welcome to CODE PRINTER"
SLEEP 2
CLS

LINE INPUT "Code name?    ", codename$
code$ = MID$(codename$, 1, 8)
file$ = "./save/CODES/" + code$ + ".txt"

OPEN file$ FOR OUTPUT AS #1
PRINT #1, codename$

FOR i = 97 TO 122
PRINT ""; CHR$(i); "?  ";
LINE INPUT "", small$(i)
PRINT #1, small$(i)
NEXT i

FOR c = 65 TO 90
PRINT ""; CHR$(c); "?  ";
LINE INPUT "", capital$(c)
PRINT #1, capital$(c)
NEXT c

FOR p1 = 33 TO 47
PRINT ""; CHR$(p1); "?  ";
LINE INPUT "", punc1$(p1)
PRINT #1, punc1$(p1)
NEXT p1

FOR p2 = 58 TO 64
PRINT ""; CHR$(p2); "?  ";
LINE INPUT "", punc2$(p2)
PRINT #1, punc2$(p2)
NEXT p2

FOR p3 = 91 TO 96
PRINT ""; CHR$(p3); "?  ";
LINE INPUT "", punc3$(p3)
PRINT #1, punc3$(p3)
NEXT p3

FOR p4 = 123 TO 126
PRINT ""; CHR$(p4); "?  ";
LINE INPUT "", punc4$(p4)
PRINT #1, punc4$(p4)
NEXT p4

FOR numb = 48 TO 57
PRINT ""; CHR$(numb); "?  ";
LINE INPUT "", number$(numb)
PRINT #1, number$(numb)
NEXT numb

CLOSE

CLS
PRINT "Code name:   "; codename$; ""

FOR a = 101 TO 122 STEP 5
PRINT CHR$(a - 4); " = "; small$(a - 4),
PRINT CHR$(a - 3); " = "; small$(a - 3),
PRINT CHR$(a - 2); " = "; small$(a - 2),
PRINT CHR$(a - 1); " = "; small$(a - 1),
PRINT CHR$(a); " = "; small$(a)
NEXT a

PRINT "z = "; small$(122)
PRINT

FOR b = 69 TO 90 STEP 5
PRINT ""; CHR$(b - 4); " = "; capital$(b - 4),
PRINT ""; CHR$(b - 3); " = "; capital$(b - 3),
PRINT ""; CHR$(b - 2); " = "; capital$(b - 2),
PRINT ""; CHR$(b - 1); " = "; capital$(b - 1),
PRINT ""; CHR$(b); " = "; capital$(b)
NEXT b

PRINT "Z = "; capital$(90)
PRINT

FOR c = 37 TO 47 STEP 5
PRINT ""; CHR$(c - 4); " = "; punc1$(c - 4),
PRINT ""; CHR$(c - 3); " = "; punc1$(c - 3),
PRINT ""; CHR$(c - 2); " = "; punc1$(c - 2),
PRINT ""; CHR$(c - 1); " = "; punc1$(c - 1),
PRINT ""; CHR$(c); " = "; punc1$(c)
NEXT c


FOR d = 62 TO 64 STEP 5
PRINT ""; CHR$(d - 4); " = "; punc2$(d - 4),
PRINT ""; CHR$(d - 3); " = "; punc2$(d - 3),
PRINT ""; CHR$(d - 2); " = "; punc2$(d - 2),
PRINT ""; CHR$(d - 1); " = "; punc2$(d - 1),
PRINT ""; CHR$(d); " = "; punc2$(d)
NEXT d

FOR e = 96 TO 96 STEP 5
PRINT ""; CHR$(e - 4); " = "; punc3$(e - 4),
PRINT ""; CHR$(e - 3); " = "; punc3$(e - 3),
PRINT ""; CHR$(e - 2); " = "; punc3$(e - 2),
PRINT ""; CHR$(e - 1); " = "; punc3$(e - 1),
PRINT ""; CHR$(e); " = "; punc3$(e)
NEXT e


FOR f = 127 TO 126 STEP 5
PRINT ""; CHR$(f - 4); " = "; punc4$(f - 4),
PRINT ""; CHR$(f - 3); " = "; punc4$(f - 3),
PRINT ""; CHR$(f - 2); " = "; punc4$(f - 2),
PRINT ""; CHR$(f - 1); " = "; punc4$(f - 1),
PRINT ""; CHR$(f); " = "; punc4$(f)
NEXT f


FOR g = 52 TO 57 STEP 5
PRINT ""; CHR$(g - 4); " = "; number$(g - 4),
PRINT ""; CHR$(g - 3); " = "; number$(g - 3),
PRINT ""; CHR$(g - 2); " = "; number$(g - 2),
PRINT ""; CHR$(g - 1); " = "; number$(g - 1),
PRINT ""; CHR$(g); " = "; number$(g)
NEXT g

