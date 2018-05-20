CLS
SCREEN 12
top:
INPUT "What is the highest mark on the graph?  ", m
IF m <= 0 THEN CLS : GOTO top
subtop:
INPUT "How much is the thing you are graphing?  ", t
IF m <= 0 THEN CLS : GOTO subtop


percent = t / m
liner = 250 * percent

h = 350 - liner
LINE (300, 100)-(330, 350), 7, BF

LINE (300, 350)-(330, h), 13, BF
PALETTE 13, 63

