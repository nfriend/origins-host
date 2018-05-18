number = 0
CLS
SCREEN 9
SLEEP 3
top: LINE (250, 295)-(390, 30), , B
FOR y = 1 TO 45
CIRCLE (320, 242.5), y, 2
NEXT y
SLEEP 5: CLS : LINE (250, 295)-(390, 30), , B
FOR i = 0 TO 45
CIRCLE (320, 162.5), i, 14
NEXT i
SLEEP 2: CLS : LINE (250, 295)-(390, 30), , B
FOR g = 0 TO 45
CIRCLE (320, 82.5), g, 12
NEXT g
SLEEP 5: CLS : LINE (250, 295)-(390, 30), , B
number = number + 1: IF number = 3 THEN END: IF number <> 3 THEN GOTO top
GOTO top

