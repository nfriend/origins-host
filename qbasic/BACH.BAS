CLS
LOCATE 11, 34
COLOR 14
PRINT "Bach's Menuet 1"
LOCATE 13, 36
COLOR 9
PRINT "Right Hand"
f = 0
FOR i = 1 TO 2
IF i = 2 THEN PLAY "l4f.l8l16gab-ab->c"
PLAY "MB"
PLAY "t160"
PLAY "l8d<b-ab-fb->d<b->e-<b->f<b->c<agafa>c<f>d<f>e-<f"
PLAY ">d<a->e-<g>f<f>gfae-b-dce-dcd<b->c<agaf>e-"
PLAY "l8d<b-ab-fb->d<b->e-<b->f<b->c<agafa>c<f>d<f>e-<f"
PLAY ">dce<b->f<agb-fb-eb-a>c<afce"
NEXT i
PLAY "l2f."
FOR u = 1 TO 2
IF u = 2 THEN PLAY "MLl4b-l16b-MN>cde-fefg<"
PLAY "l8>afefcfafb-fafge-de-ce-fdfcf<b>"
PLAY "ce-f#cac<a>c<f#>c<d>c<b->e-d<b->c<al4g.l16ab-agfe-"
PLAY "l8db-ab->f<b->a-<b->g<b->f<b-e-b-ab->g<b-e-b-fb-gb->c<b->d<a->e-<g"
PLAY ">fe-gdacb-agfe-dc<b-agfe-d>fgfcf<b>f<a>f<g>f"
PLAY "<c>e-fe-<b->e-<a>e-<g>e-<f>e-dfd<l8b-l8fl8a"
NEXT u
PLAY "t160"
PLAY "mf"
PLAY "l2b-."

