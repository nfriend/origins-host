CLS
LOCATE 11, 34
COLOR 14
PRINT "Bach's Menuet 1"
LOCATE 13, 37
COLOR 9
PRINT "Left Hand"
FOR u = 1 TO 2
IF u = 2 THEN PLAY "l8<fa>cfga>>l4"
PLAY "t160"
PLAY "MS"
PLAY "l4"
PLAY "<<b-fd<b->cd<a>cfal8b-agf"
PLAY "l4b->cde-fgab-<b->f<fa"
PLAY "b-fd<b->cd<a>cfal8b-agf"
PLAY "l4b->cd<edcf<b->c"
NEXT u

PLAY "fc<a"

FOR y = 1 TO 2
IF y = 2 THEN PLAY "l8<b->dc<b-ag"
PLAY "l4f>cfe-d<b->e-ga-dg<g"
PLAY ">cagf#df#g<b->d<l8gab->cde-"
PLAY "l4fe-dfe-dgfe-gfe-a-b->c"
PLAY "de-fgab-f<fa>d<dfgab"
PLAY ">c<ce-fgab-e-f"
NEXT y
PLAY "<t80l2b-."

