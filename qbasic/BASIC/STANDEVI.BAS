CLS
5 g = 0
a = 0
DIM v(30)
10 WHILE a = 0
20 g = g + 1
30 INPUT "enter a number"; v(g)
40 IF v(g) = 0 THEN a = 1
50 WEND
60 FOR n = 1 TO g - 1
70 summ = summ + v(n)
80 NEXT n
85 FOR n = 1 TO g - 1
PRINT n; " "; v(n)
NEXT n
INPUT "are these correct"; yn$
90 avg = summ / (g - 1)
100 PRINT "avg="; avg
110 INPUT nth$
120 FOR n = 1 TO (g - 1)
130 diff = (v(n) - avg) ^ 2
140 sum = sum + diff
150 NEXT n
160 devi = SQR(sum / (g - 2))
170 PRINT "standard deviation = "; devi


