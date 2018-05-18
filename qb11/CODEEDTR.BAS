CLS

DIM small$(97 TO 122)
DIM capital$(65 TO 90)
DIM punc1$(33 TO 47)
DIM punc2$(58 TO 64)
DIM punc3$(91 TO 96)
DIM punc4$(123 TO 126)
DIM number$(48 TO 57)
DIM key$(1 TO 102)

PRINT "When you are finished, press ENTER without typing in anything."
PRINT

FOR i = 1 TO 102
LINE INPUT "What key would you like to edit?  ", key$(i)
IF key$(i) = "" THEN EXIT FOR: LET key$(i) = ""
NEXT i



OPEN "c:/QSAVE/CODES/HJK.txt" FOR INPUT AS #1

LINE INPUT #1, codename$

FOR in = 97 TO 122
LET b = 0
FOR inn = 1 TO 102
IF key$(inn) = CHR$(in) THEN PRINT ""; CHR$(in); "?   "; : LINE INPUT "", small$(in): LET b = 1: LINE INPUT #1, kk$
NEXT inn
IF b = 0 THEN LINE INPUT #1, small$(in)
NEXT in

FOR in2 = 65 TO 90
LET b = 0
FOR inn2 = 1 TO 102
IF key$(inn2) = CHR$(in2) THEN PRINT ""; CHR$(in2); "?   "; : LINE INPUT "", capital$(in2): LET b = 1: LINE INPUT #1, kk$
NEXT inn2
IF b = 0 THEN LINE INPUT #1, capital$(in2)
NEXT in2

FOR in3 = 33 TO 47
LET b = 0
FOR inn3 = 1 TO 102
IF key$(inn3) = CHR$(in3) THEN PRINT ""; CHR$(in3); "?   "; : LINE INPUT "", punc1$(in3): LET b = 1: LINE INPUT #1, kk$
NEXT inn3
IF b = 0 THEN LINE INPUT #1, punc1$(in3)
NEXT in3


FOR in4 = 58 TO 64
LET b = 0
FOR inn4 = 1 TO 102
IF key$(inn4) = CHR$(in4) THEN PRINT ""; CHR$(in4); "?   "; : LINE INPUT "", punc2$(in4): LET b = 1: LINE INPUT #1, kk$
NEXT inn4
IF b = 0 THEN LINE INPUT #1, punc2$(in4)
NEXT in4


FOR in5 = 91 TO 96
LET b = 0
FOR inn5 = 1 TO 102
IF key$(inn5) = CHR$(in5) THEN PRINT ""; CHR$(in5); "?   "; : LINE INPUT "", punc3$(in5): LET b = 1: LINE INPUT #1, kk$
NEXT inn5
IF b = 0 THEN LINE INPUT #1, punc3$(in5)
NEXT in5

FOR in6 = 123 TO 126
LET b = 0
FOR inn6 = 1 TO 102
IF key$(inn6) = CHR$(in6) THEN PRINT ""; CHR$(in6); "?   "; : LINE INPUT "", punc4$(in6): LET b = 1: LINE INPUT #1, kk$
NEXT inn6
IF b = 0 THEN LINE INPUT #1, punc4$(in6)
NEXT in6

FOR in7 = 48 TO 57
LET b = 0
FOR inn7 = 1 TO 102
IF key$(inn7) = CHR$(in7) THEN PRINT ""; CHR$(in7); "?   "; : LINE INPUT "", number$(in7): LET b = 1: LINE INPUT #1, kk$
NEXT inn7
IF b = 0 THEN LINE INPUT #1, number$(in7)
NEXT in7
      

CLOSE
OPEN "c:/QSAVE/CODES/HJK.txt" FOR OUTPUT AS #1
PRINT "Code name:   "; codename$; ""
PRINT #1, codename$

FOR a = 101 TO 122 STEP 5
PRINT CHR$(a - 4); " = "; small$(a - 4),
PRINT CHR$(a - 3); " = "; small$(a - 3),
PRINT CHR$(a - 2); " = "; small$(a - 2),
PRINT CHR$(a - 1); " = "; small$(a - 1),
PRINT CHR$(a); " = "; small$(a)
PRINT #1, small$(a - 4)
PRINT #1, small$(a - 3)
PRINT #1, small$(a - 2)
PRINT #1, small$(a - 1)
PRINT #1, small$(a)
NEXT a

PRINT "z = "; small$(122)
PRINT #1, small$(122)
PRINT

FOR b = 69 TO 90 STEP 5
PRINT ""; CHR$(b - 4); " = "; capital$(b - 4),
PRINT ""; CHR$(b - 3); " = "; capital$(b - 3),
PRINT ""; CHR$(b - 2); " = "; capital$(b - 2),
PRINT ""; CHR$(b - 1); " = "; capital$(b - 1),
PRINT ""; CHR$(b); " = "; capital$(b)
PRINT #1, capital$(b - 4)
PRINT #1, capital$(b - 3)
PRINT #1, capital$(b - 2)
PRINT #1, capital$(b - 1)
PRINT #1, capital$(b)

NEXT b

PRINT "Z = "; capital$(90)
PRINT

FOR c = 37 TO 47 STEP 5
PRINT ""; CHR$(c - 4); " = "; punc1$(c - 4),
PRINT ""; CHR$(c - 3); " = "; punc1$(c - 3),
PRINT ""; CHR$(c - 2); " = "; punc1$(c - 2),
PRINT ""; CHR$(c - 1); " = "; punc1$(c - 1),
PRINT ""; CHR$(c); " = "; punc1$(c)
PRINT #1, punc1$(c - 4)
PRINT #1, punc1$(c - 3)
PRINT #1, punc1$(c - 2)
PRINT #1, punc1$(c - 1)
PRINT #1, punc1$(c)
NEXT c

FOR d = 62 TO 64 STEP 5
PRINT ""; CHR$(d - 4); " = "; punc2$(d - 4),
PRINT ""; CHR$(d - 3); " = "; punc2$(d - 3),
PRINT ""; CHR$(d - 2); " = "; punc2$(d - 2),
PRINT ""; CHR$(d - 1); " = "; punc2$(d - 1),
PRINT ""; CHR$(d); " = "; punc2$(d)
PRINT #1, punc2$(d - 4)
PRINT #1, punc2$(d - 3)
PRINT #1, punc2$(d - 2)
PRINT #1, punc2$(d - 1)
PRINT #1, punc2$(d)
NEXT d

PRINT ""; CHR$(63); " = "; punc2$(63)
PRINT ""; CHR$(64); " = "; punc2$(64)
PRINT #1, punc1$(63)
PRINT #1, punc1$(64)

FOR e = 96 TO 96 STEP 5
PRINT ""; CHR$(e - 4); " = "; punc3$(e - 4),
PRINT ""; CHR$(e - 3); " = "; punc3$(e - 3),
PRINT ""; CHR$(e - 2); " = "; punc3$(e - 2),
PRINT ""; CHR$(e - 1); " = "; punc3$(e - 1),
PRINT ""; CHR$(e); " = "; punc3$(e)
PRINT #1, punc3$(e - 4)
PRINT #1, punc3$(e - 3)
PRINT #1, punc3$(e - 2)
PRINT #1, punc3$(e - 1)
PRINT #1, punc3$(e)
NEXT e


FOR f = 127 TO 126 STEP 5
PRINT ""; CHR$(f - 4); " = "; punc4$(f - 4),
PRINT ""; CHR$(f - 3); " = "; punc4$(f - 3),
PRINT ""; CHR$(f - 2); " = "; punc4$(f - 2),
PRINT ""; CHR$(f - 1); " = "; punc4$(f - 1),
PRINT ""; CHR$(f); " = "; punc4$(f)
PRINT #1, punc4$(f - 4)
PRINT #1, punc4$(f - 3)
PRINT #1, punc4$(f - 2)
PRINT #1, punc4$(f - 1)
PRINT #1, punc4$(f)
NEXT f

PRINT

FOR g = 52 TO 57 STEP 5
PRINT ""; CHR$(g - 4); " = "; number$(g - 4),
PRINT ""; CHR$(g - 4); " = "; number$(g - 4),
PRINT ""; CHR$(g - 4); " = "; number$(g - 4),
PRINT ""; CHR$(g - 4); " = "; number$(g - 4),
PRINT ""; CHR$(g); " = "; number$(g)
PRINT #1, number$(g - 4)
PRINT #1, number$(g - 3)
PRINT #1, number$(g - 2)
PRINT #1, number$(g - 1)
PRINT #1, number$(g)
NEXT g

CLOSE

