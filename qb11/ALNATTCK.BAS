DECLARE SUB littleman ()

CALL littleman
SCREEN 9
SLEEP 2
FOR u = -30 TO 200
FOR t = 1 TO 5
NEXT t
e = u - 1
CIRCLE (e, 40), 20, 0, , , .1
PAINT (e, 40), 0, 0
CIRCLE (u, 40), 20, 10, , , .1
PAINT (u, 40), 10, 10
FOR hj = 1 TO 50
NEXT hj
NEXT u

CIRCLE (u - 1, 40), 20, 0
CIRCLE (u, 40), 20, 0
PAINT (u, 40), 0, 0
r = 40
FOR u = 200 TO 300
r = r + 1
n = r - 1
w = u - 1
CIRCLE (w, n), 20, 0, , , .1
PAINT (w, r), 0, 0
CIRCLE (u, r), 20, 10, , , .1
PAINT (u, r), 10, 10
FOR hj = 1 TO 50
NEXT hj
NEXT u

CIRCLE (u - 1, r), 20, 0
PAINT (u - 1, r), 0, 0
FOR r = 141 TO 200
y = r - 1
CIRCLE (u, y), 20, 0, , , .1
PAINT (u, y), 0, 0
CIRCLE (u, r), 20, 10, , , .1
PAINT (u, r), 10, 10
FOR hj = 1 TO 50
NEXT hj
NEXT r

b = 300
c = 300
FOR y = 200 TO 360
b = b - .3
c = c + .3
FOR timewaster = 1 TO 40
NEXT timewaster
LINE (c, y)-(b, y), 4
NEXT y

b = 251
c = 349
FOR y = 360 TO 200 STEP -1
b = b + .3
c = c - .3
FOR timewaster = 1 TO 40
NEXT timewaster
LINE (b, y)-(c, y), 0
NEXT y

CIRCLE (u, r), 20, 0, , , .1
CIRCLE (u, r - 1), 20, 0, , , .1
PAINT (u, r), 10, 0
FOR k = u + 1 TO 690
e = k - 1
CIRCLE (e, r), 20, 0, , , .1
PAINT (e, r), 0, 0
CIRCLE (k, r), 20, 10, , , .1
PAINT (k, r), 10, 10
FOR hj = 1 TO 50
NEXT hj
NEXT k

SUB littleman
SCREEN 9
FOR y = 348 TO 346 STEP -1
PSET (318, y), 1
PSET (322, y), 1
NEXT y

FOR g = 345 TO 344 STEP -1
PSET (319, g), 1
PSET (321, g), 1
NEXT g

FOR s = 343 TO 342 STEP -1
PSET (320, s), 4
NEXT s

f = 321
t = 319
FOR i = 341 TO 339 STEP -1
PSET (f, i), 4
PSET (t, i), 4
f = f + 2
t = t - 2
NEXT i
CIRCLE (320, 339), 1, 14
END SUB

