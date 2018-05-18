CLS
top:
INPUT "File name?  ", filename$
OPEN "c:/docume~1/friend~1/desktop/" + filename$ + ".txt" FOR INPUT AS #1
INPUT #1, password$
'FOR e = 1 TO LEN(password$)
'LET temp = ASC(MID$(password$, e, e))
'd$ = CHR$(temp + 5)
'LET npassword$ = npassword$ + d$
'NEXT e


FOR e = 1 TO LEN(password$)
LET temp = ASC(MID$(password$, e, e))
LET g = g + temp
NEXT e
CLS

DO UNTIL EOF(1)
INPUT #1, number
RANDOMIZE g
y = INT(RND * 255) + 1
PRINT y
SLEEP 1
LET letter = number - y
PRINT letter
SLEEP 1
PRINT CHR$(letter)
LET g = g + 17
PRINT CHR$(y);

LOOP

CLOSE

END

