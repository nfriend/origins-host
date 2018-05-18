10
'QUADRATIC PROGRAM: Colin Brue
CLS
LOCATE 4, 1
PRINT "Enter the coefficients of the quadratic equation a,b,c,"
INPUT a, b, c
d = 4 * a * c
e = b ^ 2
IF d > e THEN 20 ELSE 30

20
PRINT "No Real Solution": GOTO 100


30
s1 = (-b + SQR(b ^ 2 - 4 * a * c)) / 2 * a
s2 = (-b - SQR(b ^ 2 - 4 * a * c)) / 2 * a
PRINT "The solutions are   "; s1, s2

100
PRINT "evaluate another equation? (y/n)"
INPUT a$
IF a$ = "y" THEN 10
PRINT "goodbye"
END



