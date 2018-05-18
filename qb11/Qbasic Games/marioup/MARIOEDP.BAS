'
'--------------------------BY GILBERTO LIMA CORREIA----------------------
'                     E-MAIL : hacksnif@zipmail.com.br
'                  HOME PAGE : http://www.angelfire.com/mo/veget
'
'                       Para Quick Basic 1.1/4.5/7.1
'
' Este programa permite que voce edite as localidades de captura€ao de
' cada esprite grafico do jogo mario.
'
DEFINT A-Z
CLS
Reg = 1
LOCATE 1, 1: PRINT "Registro de numero : "; Reg
LOCATE 3, 1: PRINT "MEMO     1     2     3     4"
H = 4
OPEN "MARIOEDP.DAT" FOR RANDOM AS #1 LEN = 30
FIELD #1, 5 AS P1$, 5 AS P2$, 5 AS P3$, 5 AS P4$, 5 AS P5$
GOSUB Printa

DO
LOCATE 1, 1: PRINT "Registro de numero : "; Reg
D$ = INKEY$
IF H > 28 THEN H = 4
IF H < 4 THEN H = 28
LOCATE 2, H: PRINT "|"
SELECT CASE D$
CASE CHR$(0) + "H": IF Reg > 1 THEN Reg = Reg - 1: GOSUB Printa
CASE CHR$(0) + "P": Reg = Reg + 1: GOSUB Printa
CASE CHR$(0) + "K": H = H - 6: LOCATE 2, H + 6: PRINT " "
CASE CHR$(0) + "M": H = H + 6: LOCATE 2, H - 6: PRINT " "
CASE CHR$(27): END
CASE CHR$(13): GOSUB Edita
END SELECT
LOOP

Edita:
LOCATE 4, H: INPUT "", A$
 IF H = 4 THEN LSET P1$ = A$
IF H = 10 THEN LSET P2$ = A$
IF H = 16 THEN LSET P3$ = A$
IF H = 22 THEN LSET P4$ = A$
IF H = 28 THEN LSET P5$ = A$
PUT #1, Reg
RETURN


Printa:
GET #1, Reg
LOCATE 4, 4: PRINT P1$
LOCATE 4, 10: PRINT P2$
LOCATE 4, 16: PRINT P3$
LOCATE 4, 22: PRINT P4$
LOCATE 4, 28: PRINT P5$
RETURN

