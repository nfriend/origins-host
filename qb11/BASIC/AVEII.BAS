5 i = 0
6 s = 0
10 INPUT x
15 IF x = 11111 THEN 50
21 s = s + x
25 i = i + 1
30 GOTO 10
50 PRINT "the average is"; s / i
PRINT "do you want to average more numbers?"
PRINT "y/n"
INPUT a$
IF a$ = "y" THEN 5
 

