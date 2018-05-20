CLS
SCREEN 9
top:
IF INKEY$ = "q" OR INKEY$ = "Q" THEN END
RANDOMIZE TIMER
r = INT(RND * 1000) + 0
a = INT(RND * 640) + 0
b = INT(RND * 640) + 0
c = INT(RND * 345) + 0
d = INT(RND * 345) + 0
cc = INT(RND * 16) + 0
ss = INT(RND * 30) + 0

IF r < 500 THEN GOTO one
IF r > 499 THEN GOTO two
one:
IF a < b THEN GOTO ab
IF b < a THEN GOTO ba
two:
IF c < d THEN GOTO cd
IF d < c THEN GOTO dc

ab:
CIRCLE (a, c), ss, cc
LET a = a + 1
IF a = b THEN GOTO top
IF a <> b THEN GOTO ab

ba:
CIRCLE (b, d), ss, cc
LET b = b + 1
IF b = a THEN GOTO top
IF b <> a THEN GOTO ba

cd:
CIRCLE (a, c), ss, cc
LET c = c + 1
IF c = d THEN GOTO top
IF c <> d THEN GOTO cd

dc:
CIRCLE (b, d), ss, cc
LET d = d + 1
IF d = c THEN GOTO top
IF d <> c THEN GOTO dc

