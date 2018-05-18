10 SCREEN 1
LINE (0, 0)-(320, 5), 2, BF
LINE (315, 0)-(320, 200), 2, BF
LINE (320, 195)-(0, 200), 2, BF
LINE (295, 10)-(300, 190), 1, BF
15 x = 160: y = 100: db = 9: py = 90
DIM th(40)
pc = 3: GOSUB 1000
100 IF db = 1 THEN x = x - 1: y = y + 1
120 IF db = 3 THEN x = x + 1: y = y + 1
150 IF db = 7 THEN x = x - 1: y = y - 1
170 IF db = 9 THEN x = x + 1: y = y - 1
200 c = 1: GOSUB 500
pm$ = INKEY$
IF pm$ = "" THEN GOTO 210
pc = 0: GOSUB 1000
IF pm$ = "8" THEN py = py - 10
IF pm$ = "2" THEN py = py + 10
pc = 3: GOSUB 1000
210 IF db = 1 AND y > 188 THEN db = 7
240 IF db = 7 AND y < 7 THEN db = 1
250 IF db = 9 AND y < 7 THEN db = 3
260 IF db = 9 AND x > 308 THEN db = 7
270 IF db = 3 AND x > 308 THEN db = 1
280 IF db = 3 AND y > 188 THEN db = 9
300 IF x > 21 THEN GOTO 350
310 IF y >= py AND y <= py + 20 AND db = 7 THEN db = 9
320 IF y >= py AND y <= py + 20 AND db = 1 THEN db = 3
330 IF x < 15 THEN END
340 REM chck hit target
350 IF x < 290 THEN GOTO 400
g = INT((y + 5) / 10) * 2
IF db = 9 AND x = 290 AND th(g) = 0 THEN th(g) = 1: db = 7: LINE (295, g * 5)-(300, (g * 10) + 5), 0, BF
IF db = 3 AND x = 290 AND th(g) = 0 THEN th(g) = 1: db = 1: LINE (295, g * 5)-(300, (g * 10) + 5), 0, BF
IF db = 1 AND x = 301 AND th(g) = 0 THEN th(g) = 1: db = 3: LINE (295, g * 5)-(300, (g * 10) + 5), 0, BF
IF db = 7 AND x = 301 AND th(g) = 0 THEN th(g) = 1: db = 9: LINE (295, g * 5)-(300, (g * 10) + 5), 0, BF
FOR g = 2 TO 37
IF th(g) = 0 THEN LINE (295, g * 5)-(300, (g * 5) + 5), 1, BF
NEXT g
400 c = 0: GOSUB 500

GOTO 100
500 LINE (x, y)-(x + 5, y + 5), c, BF
RETURN
1000 LINE (15, py)-(20, py + 20), pc, BF
RETURN

