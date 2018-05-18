PRINT "input yearly interest rate"
INPUT i
PRINT "input amount of money owed"
INPUT a
10 t = (i / 12) * a
PRINT "the interest for this month is"; t
PRINT "the amount owed is"; a + t
pa = a + t
PRINT "what is the payment on the amount owed?"
INPUT p
a = pa - p
PRINT "the amount owed is now"; a
GOTO 10



