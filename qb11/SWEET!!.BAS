CLS
SCREEN 13
DIM newattr AS LONG

CIRCLE (165, 100), 50, 9
PAINT (165, 100), 4, 9

FOR u = 1 TO 10
FOR newattr = 0 TO 63
PALETTE 9, newattr
FOR time = 1 TO 4000: NEXT time
NEXT newattr

FOR newattr = 63 TO 0 STEP -1
PALETTE 9, newattr
FOR time = 1 TO 4000: NEXT time
NEXT newattr
NEXT u

