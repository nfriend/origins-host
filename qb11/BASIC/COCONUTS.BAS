1 CLS
2 FOR q = 1 TO 1000
10 a = (q - 1) / 3
20 IF a = INT(a) THEN GOTO 30 ELSE GOTO 1000
30 b = 2 * a
40 c = (b - 1) / 3
50 IF c = INT(c) THEN GOTO 60 ELSE GOTO 1000
60 d = 2 * c
70 e = (d - 1) / 3
80 IF e = INT(e) THEN GOTO 90 ELSE GOTO 1000
90 f = 2 * e
100 g = (f - 1) / 3
110 IF g = INT(g) THEN GOTO 120 ELSE GOTO 1000
120 PRINT q, g

1000 NEXT q

