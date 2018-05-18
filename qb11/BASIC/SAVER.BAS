x(1) = 20: y(1) = 90
WHILE INKEY$ = ""
CLS
SCREEN 1
x(2) = INT(RND(1) * 320) + 1
y(2) = INT(RND(1) * 200) + 1
c = INT(RND(1) * 15) + 1
PALETTE 1, c
LINE (x(1), y(1))-(x(2), y(2)), 1
FOR tim = 1 TO 500: NEXT tim
x(1) = x(2): y(1) = y(2)
WEND

