DECLARE SUB sphere ()
DECLARE SUB cylinder ()
DECLARE SUB cone ()
DECLARE SUB prism ()
DECLARE SUB pyramid ()
CONST PI = 3.1459265#
top:
CLS
PRINT "What shape would you like to find its volume?  "
PRINT
PRINT "    1) Rectangular Prism"
PRINT "    2) Rectangular Pyramid"
PRINT "    3) Cylinder"
PRINT "    4) Cone"
PRINT "    5) Sphere"
LOCATE 1, 47
INPUT " ", what

SELECT CASE what
CASE 1
        prism

CASE 2
        pyramid

CASE 3
        cylinder

CASE 4
        cone

CASE 5
        sphere

CASE ELSE
        GOTO top

END SELECT

SUB cone
CLS
INPUT "Radius?  ", r
INPUT "Heigth?  ", h
LET fraction = 1 / 3
LET answer = PI * (r * r) * h * fraction
PRINT "The volume of the cone is "; answer; "."
END SUB

SUB cylinder
CLS
INPUT "Radius?  ", r
INPUT "Heigth?  ", h
LET answer = PI * (r * r) * h
PRINT "The volume of the cylinder is "; answer; "."
END SUB

SUB prism
CLS
INPUT "Length?  ", l
INPUT "Width?  ", w
INPUT "Heigth?  ", h
LET answer = l * w * h
PRINT
PRINT "The volume of the rectangular prism is"; answer; "."
END SUB

SUB pyramid
CLS
INPUT "Length?  ", l
INPUT "Width?  ", w
INPUT "Heigth?  ", h
LET fraction = 1 / 3
LET answer = fraction * l * w * h
PRINT "The volume of the rectangular prism is"; answer; "."
END SUB

SUB sphere
CLS
INPUT "Radius?  ", r
LET fraction = 1 / 3 + 1
LET answer = PI * (r * r * r) * fraction
PRINT "The volume of the sphere is "; answer; "."
END SUB

