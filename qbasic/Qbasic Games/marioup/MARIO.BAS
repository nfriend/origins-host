'
'--------------------------BY GILBERTO LIMA CORREIA----------------------
'                     E-MAIL : hacksnif@zipmail.com.br
'                  HOME PAGE : http://www.angelfire.com/mo/veget
'
'                            Para Quick Basic 4.5
'
' para que este programa rode voce tem que usar a biblioteca que veio
' no pacote do arquivo ZIP.
'
' DIGITE : qb /l mario.qlb
'
' se acharem (bug) no jogo, mande um e-mail avisando.
'
'
'
DECLARE SUB CapturaGraficos ()
DECLARE SUB CapturaMapa ()
DECLARE SUB Texture (XXX1%)
DECLARE SUB Soco ()
DECLARE SUB Credito ()
DECLARE SUB Mf (Tex$, Loca1%, Loca2%)
DECLARE SUB Paleta (x%)
DECLARE SUB Fim ()
DECLARE SUB TenCerte ()
DECLARE SUB Apresenta ()
DECLARE SUB GravaArray ()
DECLARE SUB Bline (dt%, db%, X1%, y1%, x2%, y2%, colr%)
DECLARE SUB MMC (Porreta%, Beto%, TsegLixo%, LixoSeg%)
DECLARE SUB Morte ()
DECLARE SUB Teclas ()
DECLARE SUB Tela ()
DECLARE SUB IniciaCodigo ()
DECLARE SUB Desliga ()
DECLARE SUB Liga ()
DECLARE SUB PasseMorte ()
DECLARE SUB Clare (Cor%, Tem%)
DECLARE SUB MMP (dt%, db%, st%, sb%, xpos%, ypos%, icol%)
DECLARE SUB MMG (dt%, db%, st%, sb%, X1%, y1%, x2%, y2%)
DECLARE SUB MapEMS (handle%, pageoffset%)
DECLARE FUNCTION PageFrame% ()
DECLARE SUB Df (X1$, LocX%, LocY%)
DECLARE SUB Atun ()
DECLARE SUB Obj ()
DECLARE SUB MMS (segment%, offset%, col%)
REM $INCLUDE: 'MARIO.BI'
DEFINT A-Z
CONST True = -1, Falso = NOT True
TYPE Pore
Verme AS INTEGER
Verde AS INTEGER
Azul AS INTEGER
END TYPE
REDIM SHARED DDE1(14), DDE2(21), DDE3(91), DDE4(76), DDE6(17), DDE7(25), DDE8(118), DDE9(14)
IniciaCodigo
REDIM SHARED Arra$(14)
REDIM SHARED Gr(14) AS STRING
REDIM SHARED Eu(4000), Blo(4000), Bo(0 TO 5000), Kbc(128), Kb(128)
REDIM SHARED Cor(255) AS Pore
REDIM SHARED Lava(-10 TO 60, -10 TO 60), Pino(1900), FONT(4565), Fmar(900)
REDIM SHARED Rast(900), Tex(8000), Rx1(2), Rx2(2), Rotulo(5000)
DIM SHARED Shit, y, f, Mort, Dire
DIM SHARED Tel1, Tel2, Tela1$, Tela2$, Fut$, Blocada$, VaiLixo
DIM SHARED MorL1$, MorL2$, TelM1$, TelM2$, Morloc1, Morloc2, Mortel1, Mortel2
DIM SHARED Saiam, Certeza, Rego$, Credo, F1, Eu1, Eu2
DIM SHARED Bo1, Blo1
DIM SHARED Rod, Tep, Now
CapturaGraficos

Eu1 = VARSEG(Eu(0)): Eu2 = VARPTR(Eu(0))
Bo1 = VARSEG(Bo(0)): Blo1 = VARSEG(Blo(0))

OPEN "MARIOLEV.DAT" FOR RANDOM AS #1 LEN = 500
FIELD #1, 22 AS Gr(1), 22 AS Gr(2), 22 AS Gr(3), 22 AS Gr(4), 22 AS Gr(5), 22 AS Gr(6), 22 AS Gr(7), 22 AS Gr(8), 22 AS Gr(9), 22 AS Gr(10), 22 AS Gr(11), 22 AS Gr(12), 22 AS Gr(13), 22 AS Gr(14), 3 AS Tela1$, 3 AS Tela2$, 4 AS MorL1$, 4 AS MorL2$,  _
3 AS TelM1$, 3 AS TelM2$, 4 AS Fut$, 5 AS Rego$

CapturaMapa

IF IsEMS THEN
ELSE
CLS
PRINT "ESTE JOGO REQUER MEMORIA EXPANDIDA (EMS) MEMORY !!!"
END
END IF
EMSH = AllocEMS(51200)
MapEMS EMSH, 0
F1 = PageFrame

DEF SEG = F1: BLOAD "MARIO.GRP", 0
OPEN "MARIOEDP.DAT" FOR RANDOM AS #2 LEN = 30
FIELD #2, 5 AS P1$, 5 AS P2$, 5 AS P3$, 5 AS P4$, 5 AS P5$
FOR Rege = 1 TO 1000
GET #2, Rege
IF EOF(2) THEN CLOSE #2: EXIT FOR
IF Rege < 20 OR Rege > 29 THEN MMG F1, 0, Blo1, VARPTR(Blo(VAL(P1$))), VAL(P2$), VAL(P3$), VAL(P4$), VAL(P5$)
IF Rege >= 20 AND Rege <= 29 THEN MMG F1, 0, Bo1, VARPTR(Bo(VAL(P1$))), VAL(P2$), VAL(P3$), VAL(P4$), VAL(P5$)
NEXT Rege
FOR p = 0 TO 35
MMG F1, 0, VARSEG(Fmar(0)), VARPTR(Fmar(Lara)), 4 + L, 110, 9 + L, 116
L = L + 7
Lara = Lara + 25
NEXT p
MMG F1, 0, Eu1, Eu2, 140, 6, 213, 99

DEF SEG = F1
BLOAD "MARIODUK.GRP", 0
MMG F1, 0, VARSEG(Rotulo(0)), VARPTR(Rotulo(0)), 11, 58, 282, 80

L = 0
FOR p = 0 TO 8
MMG F1, 0, VARSEG(Tex(0)), VARPTR(Tex(Rele)), 12 + L, 82, 43 + L, 113
L = L + 33
Rele = Rele + 550
NEXT p

FOR Po = 0 TO 6
MMG F1, 0, VARSEG(Pino(0)), VARPTR(Pino(Arra1)), 12 + V1, 36, 36 + V1, 56
V1 = V1 + 26
Arra1 = Arra1 + 270
NEXT Po

V1 = 0: Arra1 = 0
FOR Po = 0 TO 37
MMG F1, 0, VARSEG(FONT(0)), VARPTR(FONT(Arra1)), 12 + V1, 4 + V2, 26 + V1, 18 + V2
Arra1 = Arra1 + 115
V1 = V1 + 16
IF Po = 18 THEN V1 = 0: V2 = V2 + 16
NEXT Po

SCREEN 13
Teclas
Liga

Blast:
Apresenta
Tel1 = 0
Tel2 = 0
Inicio:
PasseMorte
Tel1 = Mortel1
Tel2 = Mortel2
So = 0: Lo = 0
Cai = 2
y = Morloc1
f = Morloc2
Poligono:
Paleta 1
Tela
Co1 = Bo1: Co2 = VARPTR(Bo(420))
MMG &HA000, 0, Co1, Co2, y - 2, f - 2, y + 21, f + 20
Fk = 1
DO
WAIT &H3DA, 8
Temp = Temp + 1
IF Temp = 7 THEN Ati = 1
IF Temp = 14 THEN Ati = 0: Temp = 0
IF f > 176 THEN Tel1 = Tel1 + 1: f = 2: Tela: GOTO Passe
IF f < 2 THEN Tel1 = Tel1 - 1: f = 178: Tela: GOTO Passe
IF y < 4 THEN Tel2 = Tel2 - 1: y = 294: Tela: GOTO Passe
IF y > 294 THEN Tel2 = Tel2 + 1: y = 6: Tela: GOTO Passe
MMP &HA000, 0, Co1, Co2, y - 2 + Lo, f - 2 + So, 250
Passe:
MMG &HA000, 0, Co1, Co2, y - 2, f - 2, y + 21, f + 20
IF Kb(75) = 0 AND Kb(77) = 0 THEN Lo = 0: VaiLixo = True
IF Kb(75) AND Kb(77) THEN Lo = 0: VaiLixo = True
Pela = y
IF Kb(75) AND Kb(77) = 0 THEN Dire = 1: y = y - 2: Lo = 2
IF Kb(77) AND Kb(75) = 0 THEN Dire = 0: y = y + 2: Lo = -2
IF y = Pela THEN Lo = 0
IF Kb(29) AND Cai = 0 AND Salte = Falso THEN Cai = -2: Salte = True
IF Kb(29) = 0 THEN Salte = Falso
IF Cai = -2 THEN Pulo = Pulo + 1
IF Pulo = 23 THEN Cai = 2: Pulo = 0
f = f + Cai
IF Cai = 0 THEN
IF POINT(y + 7, f + 20) <> 255 AND POINT(y + 4, f + 20) <> 255 AND POINT(y + 15, f + 20) <> 255 THEN Cai = 2: f = f + 2
END IF
IF POINT(y + 4, f + 4) = 255 THEN y = y + 2: Lo = 0: GOTO Bate
IF POINT(y + 4, f + 8) = 255 THEN y = y + 2: Lo = 0: GOTO Bate
IF POINT(y + 4, f + 16) = 255 THEN y = y + 2: Lo = 0: GOTO Bate
IF POINT(y + 14, f + 4) = 255 THEN Lo = 0: y = y - 2: GOTO Bate
IF POINT(y + 14, f + 8) = 255 THEN Lo = 0: y = y - 2: GOTO Bate
IF POINT(y + 14, f + 16) = 255 THEN Lo = 0: y = y - 2: GOTO Bate
Bate:
IF POINT(y + 14, f + 2) = 255 AND Cai = -2 THEN Cai = 2: So = 0: f = f + 4
IF POINT(y + 12, f + 2) = 255 THEN Cai = 2: So = 0: f = f + 4
IF POINT(y + 10, f + 2) = 255 THEN Cai = 2: So = 0: f = f + 4
IF POINT(y + 6, f + 2) = 255 THEN Cai = 2: So = 0: f = f + 4
IF POINT(y + 4, f + 2) = 255 AND Cai = -2 THEN Cai = 2: So = 0: f = f + 4
IF POINT(y + 14, f + 18) = 255 AND Cai = 2 THEN Cai = 0: f = f - 2
IF POINT(y + 12, f + 18) = 255 THEN Cai = 0: f = f - 2
IF POINT(y + 10, f + 18) = 255 THEN Cai = 0: f = f - 2
IF POINT(y + 6, f + 18) = 255 THEN Cai = 0: f = f - 2
IF POINT(y + 4, f + 18) = 255 AND Cai = 2 THEN Cai = 0: f = f - 2
IF POINT(y + 14, f + 16) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 10, f + 16) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 4, f + 16) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 4, f + 4) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 4, f + 8) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 4, f + 16) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 12, f + 2) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 10, f + 2) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 6, f + 2) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 14, f + 4) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 14, f + 8) = 254 THEN Morte: GOTO Inicio
IF POINT(y + 14, f + 16) = 254 THEN Morte: GOTO Inicio
IF Cai = 0 THEN So = 0: Pulo = 0
IF Cai = -2 THEN So = 2
IF Cai = 2 THEN So = -2

L% = L% + Fk
IF L% >= 63 THEN Fk = -2
IF L% <= 2 THEN Fk = 2
OUT &H3C8, 224
OUT &H3C9, L%
OUT &H3C9, 0
OUT &H3C9, 0

So1 = 0: So2 = 0
IF Cai = 2 AND Dire = 0 THEN Este = 1750: GOTO Puta
IF Cai = 2 AND Dire = 1 THEN Este = 2000: GOTO Puta
IF Cai = -2 AND Dire = 0 THEN Este = 1290: GOTO Puta
IF Cai = -2 AND Dire = 1 THEN Este = 1500: GOTO Puta
IF Kb(77) AND Kb(75) AND Dire = 1 AND Cai = 0 THEN Este = 800: GOTO Puta
IF Kb(77) AND Kb(75) AND Dire = 0 AND Cai = 0 THEN Este = 200: GOTO Puta
IF Dire = 0 AND Kb(77) = 0 AND Cai = 0 THEN Este = 200: GOTO Puta
IF Dire = 1 AND Kb(75) = 0 AND Cai = 0 THEN Este = 800: GOTO Puta
IF Ati = 0 AND Dire = 0 AND Kb(77) = 1 AND Kb(75) = 0 AND Cai = 0 THEN Este = 0: So1 = -1: So2 = -1: IF VaiLixo = True THEN Ati = 1: Temp = 13: VaiLixo = Falso
IF Ati = 1 AND Dire = 0 AND Kb(77) = 1 AND Kb(75) = 0 AND Cai = 0 THEN Este = 200: IF VaiLixo = True THEN Ati = 1: Temp = 13: VaiLixo = Falso
IF Ati = 0 AND Dire = 1 AND Kb(75) = 1 AND Kb(77) = 0 AND Cai = 0 THEN Este = 1050: So2 = -1: IF VaiLixo = True THEN Ati = 1: Temp = 13: VaiLixo = Falso
IF Ati = 1 AND Dire = 1 AND Kb(75) = 1 AND Kb(77) = 0 AND Cai = 0 THEN Este = 800: IF VaiLixo = True THEN Ati = 1: Temp = 13: VaiLixo = Falso
Puta:
Pi1 = Bo1: Pi2 = VARPTR(Bo(Este))
MMP &HA000, 0, Pi1, Pi2, y + So1, f + So2, 0
IF Kb(1) THEN TenCerte
IF Kb(16) AND Kb(56) THEN Desliga: Fim
IF Saiam = True THEN Saiam = Falso: GOTO Blast
LOOP
Dados:
DATA &HE9,&H1D,&H00,&HE9,&H3C,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
DATA &H00,&H00,&H00,&H00,&H1E,&H31,&HC0,&H8E,&HD8,&HBE,&H24,&H00,&H0E,&H07
DATA &HBF,&H14,&H00,&HFC,&HA5,&HA5,&H8C,&HC3,&H8E,&HC0,&HBF,&H24,&H00,&HB8
DATA &H56,&H00,&HFA,&HAB,&H89,&HD8,&HAB,&HFB,&H1F,&HCB,&H1E,&H31,&HC0,&H8E
DATA &HC0,&HBF,&H24,&H00,&HBE,&H14,&H00,&H0E,&H1F,&HFC,&HFA,&HA5,&HA5,&HFB
DATA &H1F,&HCB,&HFB,&H9C,&H50,&H53,&H51,&H52,&H1E,&H56,&H06,&H57,&HE4,&H60
DATA &HB4,&H01,&HA8,&H80,&H74,&H04,&HB4,&H00,&H24,&H7F,&HD0,&HE0,&H88,&HC3
DATA &HB7,&H00,&HB0,&H00,&H2E,&H03,&H1E,&H12,&H00,&H2E,&H8E,&H1E,&H10,&H00
DATA &H86,&HE0,&H89,&H07,&HE4,&H61,&H0C,&H82,&HE6,&H61,&H24,&H7F,&HE6,&H61
DATA &HB0,&H20,&HE6,&H20,&H5F,&H07,&H5E,&H1F,&H5A,&H59,&H5B,&H58,&H9D,&HCF
DATA -1

SUB Apresenta
Rx1(1) = 78: Rx2(1) = 74 - 8: Rx1(2) = 219: Rx2(2) = 75 - 8
MMS &HA000, 0, 0
Tuda:
MMS F1, 0, 0
Paleta 3
Texture 3

MMP F1, 0, VARSEG(Rotulo(0)), VARPTR(Rotulo(0)), 27, 18, 0
MMP F1, 0, VARSEG(Rotulo(0)), VARPTR(Rotulo(0)), 27, 160, 0
Df "m a r i o u p", 87, 22
Df "mastersoft", 90, 164

Df " jogar", 110, 80 - 9
Df " ajuda", 110, 96 - 9
Df " sobre", 110, 112 - 9
Df " sair", 117, 128 - 9

MMC F1, 0, &HA000, 0
MMG &HA000, 0, VARSEG(Rast(0)), VARPTR(Rast(0)), Rx1(1) - 1, Rx2(1) - 1, Rx1(1) + 27, Rx2(1) + 27
MMG &HA000, 0, VARSEG(Rast(0)), VARPTR(Rast(450)), Rx1(2) - 1, Rx2(2) - 1, Rx1(2) + 27, Rx2(2) + 27
DO
'LOCATE 1, 1: PRINT Rx1(1), Rx2(1)
IF Kb(72) AND Prek1 = 0 THEN Rx2(1) = Rx2(1) - 17: Rx2(2) = Rx2(2) - 17: Atun: Prek1 = 1
IF Kb(80) AND Prek2 = 0 THEN Rx2(1) = Rx2(1) + 17: Rx2(2) = Rx2(2) + 17: Atun: Prek2 = 1
IF Kb(72) = 0 THEN Prek1 = 0
IF Kb(80) = 0 THEN Prek2 = 0
IF Rx2(1) = 83 AND Kb(28) AND Kb(1) = 0 THEN Soco: GOTO Tuda
IF Rx2(1) = 74 - 8 AND Kb(28) THEN MMS &HA000, 0, 0: EXIT DO
IF Rx2(1) = 125 - 8 AND Kb(28) THEN Desliga: Fim
IF Rx2(1) = 108 - 8 AND Kb(28) AND Kb(1) = 0 THEN Credito: GOTO Tuda
Obj
LOOP
MMS F1, 0, 0
END SUB

SUB Atun
IF Rx2(1) < 74 - 8 THEN Rx2(1) = 125 - 8
IF Rx2(2) < 75 - 8 THEN Rx2(2) = 126 - 8
IF Rx2(1) > 125 - 8 THEN Rx2(1) = 74 - 8
IF Rx2(2) > 126 - 8 THEN Rx2(2) = 75 - 8
MMC F1, 0, &HA000, 0
FOR T = 1 TO 2
IF T = 1 THEN Pol = 0
IF T = 2 THEN Pol = 450
MMG &HA000, 0, VARSEG(Rast(0)), VARPTR(Rast(Pol)), Rx1(T) - 1, Rx2(T) - 1, Rx1(T) + 25, Rx2(T) + 25
NEXT T
Now = 1
Obj
END SUB

SUB Bline (dt, db, X1, y1, x2, y2, colr)
DEF SEG = VARSEG(DDE8(0))
CALL ABSOLUTE(BYVAL dt, BYVAL db, BYVAL X1, BYVAL y1, BYVAL x2, BYVAL y2, BYVAL colr, VARPTR(DDE8(0)))
DEF SEG
END SUB

SUB CapturaGraficos

END SUB

SUB CapturaMapa
DO
NReg = NReg + 1
GET #1, NReg
IF EOF(1) THEN EXIT DO
Regg& = VAL(Rego$)
IF Regg& <> 0 THEN Lava(VAL(Tela1$), VAL(Tela2$)) = Regg&
Regg& = 0
LOOP
END SUB

SUB Clare (Cor%, Tem)
FOR L = 0 TO 63 STEP Tem
FOR H = 1 TO 500: NEXT
WAIT &H3DA, 8
OUT &H3C8, Cor%
OUT &H3C9, L
OUT &H3C9, L
OUT &H3C9, L
NEXT L
FOR L = 63 TO 0 STEP -Tem
FOR H = 1 TO 500: NEXT
WAIT &H3DA, 8
OUT &H3C8, Cor%
OUT &H3C9, L
OUT &H3C9, L
OUT &H3C9, L
NEXT L
END SUB

SUB Credito
MMS F1, 0, 0
Credo = True
Tel1 = -4: Tel2 = 0
Tela
Fk = 1
DO
WAIT &H3DA, 8
Poru% = Poru% + 1
IF Poru% = 7 THEN L% = L% + Fk: Poru% = 0
IF L% >= 63 THEN Fk = -1
IF L% <= 30 THEN Fk = 1
OUT &H3C8, 240
OUT &H3C9, L
OUT &H3C9, 0
OUT &H3C9, 0
IF Kb(16) AND Kb(56) THEN Desliga: Fim
IF Kb(1) AND Kb(28) = 0 THEN EXIT DO
LOOP
MMS &HA000, 0, 0
Paleta 3
Credo = Falso
END SUB

SUB Delay (KKK!)
DDD! = TIMER
DO
IF DDD! + KKK! >= TIMER THEN EXIT DO
LOOP
END SUB

SUB Desliga
IF (Shit = 0) THEN EXIT SUB
Shit = 0
DEF SEG = VARSEG(Kbc(0))
CALL ABSOLUTE(3)
DEF SEG
END SUB

SUB Df (X1$, LocX, LocY)
L1 = 1
Ret:
FOR E1 = 1 TO 38
Ft$ = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ+ "
IF MID$(UCASE$(X1$), L1, 1) = MID$(Ft$, E1, 1) THEN
IF E1 = 38 THEN E2 = E2 + 7: GOTO Passo
Num = E1 - 1
E2 = E2 + 12
IF E1 = 19 THEN E2 = E2 - 4
IF E1 = 2 THEN E2 = E2 - 3
MMP F1, 0, VARSEG(FONT(0)), VARPTR(FONT(Num * 115)), LocX + E2, LocY, 255
Passo:
L1 = L1 + 1
GOTO Ret
END IF
NEXT E1
END SUB

SUB Fim
REDIM Lava(0, 0)
REDIM DDE1(0), DDE2(0), DDE3(0), DDE4(0), DDE6(0), DDE7(0), DDE8(0), DDE9(0)
REDIM Eu(0)
REDIM Arra$(0)
REDIM Gr(0)  AS STRING
REDIM Blo(0)
REDIM Bo(0)
REDIM Cor(0) AS Pore
REDIM Kbc(0), Kb(0)
REDIM Fu(0)
MapEMS EMSH, 0
CALL FreeEMS(EMSH)
SCREEN 12
SCREEN 0
PRINT "      By Gilberto Lima Correia   E-MAIL: hacksnif@zipmail.com.br"
PRINT "             HOME PAGE: http://www.angelfire.com/mo/veget       "
END
END SUB

SUB GravaArray
FOR k = 1 TO 14
Arra$(k) = Gr(k)
NEXT k
END SUB

SUB IniciaCodigo
DDE$ = "1E5589E58B460E8ED88B760C8B460A8EC08B7E08B9007DF3A55D1FCA0800"
DEF SEG = VARSEG(DDE1(0))
FOR i = 0 TO 29
d = VAL("&h" + MID$(DDE$, i * 2 + 1, 2))
POKE VARPTR(DDE1(0)) + i, d
NEXT i
DEF SEG
DDE$ = "1E5589E58B46108ED88B760AB106D3E689F3B102D3E601DE8B5E0C01DE8B5E0E01DE8A460888045D1FCA0A00"
DEF SEG = VARSEG(DDE2(0))
FOR i = 0 TO 43
d = VAL("&h" + MID$(DDE$, i * 2 + 1, 2))
POKE VARPTR(DDE2(0)) + i, d
NEXT i
DEF SEG
DDE$ = "1E5589E58B460C508B460A508B46108ED88B760E8B04B103D3E8508B5EFE"
DDE$ = DDE$ + "01C3895EFE8B4402508B5EFC01C3895EFC83C60489760E89E58B46188ED8"
DDE$ = DDE$ + "8B76168A04468976163A4610743DBB0000395E147C35395E127C30BB3F01"
DDE$ = DDE$ + "395E147F28BBC700395E127F208B5E1C8EDB8B7612B106D3E689F3B102"
DDE$ = DDE$ + "D3E601DE8B5E1401DE8B5E1A01DE88048B4614408946148B460639461475"
DDE$ = DDE$ + "A18B46142B46028946148B4612408946128B46043946127589585858585D"
DDE$ = DDE$ + "1FCA0E00"
DEF SEG = VARSEG(DDE3(0))
FOR i = 0 TO 182
d = VAL("&h" + MID$(DDE$, i * 2 + 1, 2))
POKE VARPTR(DDE3(0)) + i, d
NEXT i
DEF SEG
DDE$ = "1E5589E58B460A508B4608508B460A2B460E40508B46082B460C40508B46128ED8"
DDE$ = DDE$ + "8B76108B46FABB0800F7E3890446468B46F88904464689761089E58B5E"
DDE$ = DDE$ + "1E8EDB8B7614B106D3E689F3B102D3E601DE8B5E1601DE8B5E1C01DE8A"
DDE$ = DDE$ + "048B5E1A8EDB8B76188804468976188B4616408946168B460639461676"
DDE$ = DDE$ + "C38B46162B46028946168B4614408946148B460439461476AB58585858"
DDE$ = DDE$ + "5D1FCA1000C20200"
DEF SEG = VARSEG(DDE4(0))
FOR i = 0 TO 153
d = VAL("&h" + MID$(DDE$, i * 2 + 1, 2))
POKE VARPTR(DDE4(0)) + i, d
NEXT i
DEF SEG
DDE$ = "1E5589E58B460C8ED88B760A8B460888C4B900FA890483C60283E90275F65D1FCA0600"
DEF SEG = VARSEG(DDE6(0))
FOR i = 0 TO 34
d = VAL("&h" + MID$(DDE$, i * 2 + 1, 2))
POKE VARPTR(DDE6(0)) + i, d
NEXT i
DEF SEG
DDE$ = "1E5589E58B46128ED88B760CB106D3E689F3B102D3E601DE8B5E0C01DE8B5E100"
DDE$ = DDE$ + "1DE8A1C8B460A8ED88B7608881C5D1FCA0C00"
DEF SEG = VARSEG(DDE7(0))
FOR i = 0 TO 50
d = VAL("&h" + MID$(DDE$, i * 2 + 1, 2))
POKE VARPTR(DDE7(0)) + i, d
NEXT i
DEF SEG
DDE$ = "1E5589E58B460C2B4610508B460A2B460E50B8010050B840015089E58B46188B5E1439"
DDE$ = DDE$ + "D87E168B4602BBFFFFF7E38946028B4606BBFFFFF7E38946068B46168B5E"
DDE$ = DDE$ + "1239D87E168B4600BBFFFFF7E38946008B4604BBFFFFF7E38946048B46"
DDE$ = DDE$ + "1C8ED88B7616B106D3E689F3B102D3E601DE8B5E1801DE8B5E1A01DE"
DDE$ = DDE$ + "8B46068B5E0439D87E2FBB000089C13D00007F07B9FFFFF7E189C18A46"
DDE$ = DDE$ + "108804037602035E043B5E067C060376002B5E064983F9007DE4EB32B8"
DDE$ = DDE$ + "000089D983FB007F0C89D8B9FFFFF7E189C1B800008A5E10881C037600"
DDE$ = DDE$ + "0346063B46047C060376022B46044983F9007DE4585858585D1FCA0E00"
DEF SEG = VARSEG(DDE8(0))
FOR i = 0 TO 237
d = VAL("&h" + MID$(DDE$, i * 2 + 1, 2))
POKE VARPTR(DDE8(0)) + i, d
NEXT i
DEF SEG
DDE$ = "1E5589E58B46108ED88B760E8B460C8EC08B7E0A8B4E08F3A45D1FCA0A00"
DEF SEG = VARSEG(DDE9(0))
FOR i = 0 TO 29
d = VAL("&h" + MID$(DDE$, i * 2 + 1, 2))
POKE VARPTR(DDE9(0)) + i, d
NEXT i
DEF SEG
END SUB

SUB Liga
IF Shit THEN EXIT SUB
Shit = 1
DEF SEG = VARSEG(Kbc(0))
CALL ABSOLUTE(0)
DEF SEG
END SUB

SUB MapEMS (handle%, pageoffset%)
NumPages% = 4
Asm$ = ""
Asm$ = Asm$ + CHR$(85) + CHR$(137) + CHR$(229) + CHR$(139)
Asm$ = Asm$ + CHR$(86) + CHR$(8) + CHR$(139) + CHR$(126) + CHR$(6)
Asm$ = Asm$ + CHR$(139) + CHR$(118) + CHR$(10) + CHR$(177) + CHR$(0)
Asm$ = Asm$ + CHR$(48) + CHR$(237) + CHR$(180) + CHR$(68) + CHR$(136)
Asm$ = Asm$ + CHR$(200) + CHR$(137) + CHR$(243) + CHR$(205) + CHR$(103)
Asm$ = Asm$ + CHR$(70) + CHR$(65) + CHR$(57) + CHR$(249) + CHR$(117)
Asm$ = Asm$ + CHR$(242) + CHR$(93) + CHR$(203)
DEF SEG = VARSEG(Asm$)
CALL ABSOLUTE(BYVAL pageoffset%, BYVAL handle%, BYVAL NumPages%, SADD(Asm$))
DEF SEG
END SUB

SUB Mf (Tex$, Loca1, Loca2)
MarF$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
FOR k = 1 TO LEN(Tex$)
FOR H = 1 TO 37
IF MID$(MarF$, H, 1) = MID$(UCASE$(Tex$), k, 1) THEN
MMP F1, 0, VARSEG(Fmar(0)), VARPTR(Fmar((H - 1) * 25)), Bost + Loca1, Loca2, 0
EXIT FOR
END IF
NEXT H
Bost = Bost + 7
NEXT k
END SUB

SUB MMC (Porreta%, Beto%, TsegLixo%, LixoSeg%)
DEF SEG = VARSEG(DDE1%(0))
CALL ABSOLUTE(BYVAL Porreta%, BYVAL Beto%, BYVAL TsegLixo%, BYVAL LixoSeg%, VARPTR(DDE1%(0)))
DEF SEG
END SUB

SUB MMG (dt, db, st, sb, X1, y1, x2, y2)
DEF SEG = VARSEG(DDE4(0))
CALL ABSOLUTE(BYVAL dt, BYVAL db, BYVAL st, BYVAL sb, BYVAL X1, BYVAL y1, BYVAL x2, BYVAL y2, VARPTR(DDE4(0)))
DEF SEG
END SUB

SUB MMP (dt, db, st, sb, xpos, ypos, icol)
DEF SEG = VARSEG(DDE3(0))
CALL ABSOLUTE(BYVAL dt, BYVAL db, BYVAL st, BYVAL sb, BYVAL xpos, BYVAL ypos, BYVAL icol, VARPTR(DDE3(0)))
DEF SEG
END SUB

SUB MMS (segment%, offset%, col%)
DEF SEG = VARSEG(DDE6%(0))
CALL ABSOLUTE(BYVAL segment%, BYVAL offset%, BYVAL col%, VARPTR(DDE6%(0)))
DEF SEG
END SUB

SUB Morte
IF Dire = 0 THEN
MMP &HA000, 0, Bo1, VARPTR(Bo(2450)), y, f, 0
GOSUB Clarao
Mort = True
EXIT SUB
ELSE
MMP &HA000, 0, Bo1, VARPTR(Bo(2250)), y + 1, f, 0
GOSUB Clarao
Mort = True
EXIT SUB
END IF
Clarao:
Clare 241, 1
RETURN
END SUB

SUB Obj
Tep = Tep + 1
IF Rod > 6 THEN Rod = 0
FOR J = 1 TO 2
IF Now = 0 THEN WAIT &H3DA, 8
IF J = 1 THEN Fui = 0
IF J = 2 THEN Fui = 450
MMP &HA000, 0, VARSEG(Rast(0)), VARPTR(Rast(Fui)), Rx1(J) - 1, Rx2(J) - 1, 255
MMG &HA000, 0, VARSEG(Rast(0)), VARPTR(Rast(Fui)), Rx1(J) - 1, Rx2(J) - 1, Rx1(J) + 24, Rx2(J) + 20
MMP &HA000, 0, VARSEG(Pino(0)), VARPTR(Pino(Rod * 270)), Rx1(J), Rx2(J), 255
NEXT J
IF Tep = 2 THEN Tep = 0: Rod = Rod + 1
Now = 0
END SUB

FUNCTION PageFrame%
Asm$ = ""
Asm$ = Asm$ + CHR$(85) + CHR$(137) + CHR$(229) + CHR$(180)
Asm$ = Asm$ + CHR$(65) + CHR$(205) + CHR$(103) + CHR$(139) + CHR$(126)
Asm$ = Asm$ + CHR$(6) + CHR$(137) + CHR$(29) + CHR$(93) + CHR$(203)
PageFrameAddr% = 0
DEF SEG = VARSEG(Asm$)
CALL ABSOLUTE(PageFrameAddr%, SADD(Asm$))
DEF SEG
PageFrame% = PageFrameAddr%
END FUNCTION

SUB Paleta (x)
DEF SEG = VARSEG(Cor(0))
SELECT CASE x
CASE 1: BLOAD "MARIO.PAL", VARPTR(Cor(0))
CASE 2: BLOAD "MARIOBE.PAL", VARPTR(Cor(0))
CASE 3: BLOAD "MARIODUK.PAL", VARPTR(Cor(0))
END SELECT
OUT &H3C8, 0
FOR J = 0 TO 255
OUT &H3C9, Cor(J).Verme
OUT &H3C9, Cor(J).Verde
OUT &H3C9, Cor(J).Azul
NEXT J
END SUB

SUB PasseMorte
GET #1, Lava(Tel1, Tel2)
Morloc1 = VAL(MorL1$)
Morloc2 = VAL(MorL2$)
Mortel1 = VAL(TelM1$)
Mortel2 = VAL(TelM2$)
END SUB

SUB Ps (T, b, xpos, ypos, col)
DEF SEG = VARSEG(DDE2(0))
CALL ABSOLUTE(BYVAL T, BYVAL b, BYVAL xpos, BYVAL ypos, BYVAL col, VARPTR(DDE2(0)))
DEF SEG
END SUB

SUB Soco
MMS F1, 0, 0
Texture 1
Df "setas para mover o mario", 13, 15
Df "ctrl direito ou esquerdo", 13, 32
Df "para o mario pular", 45, 48
Df "alt + q sai do jogo", 44, 64
Df "este jogo foi programado", 9, 94
Df "em quickbasic45", 62, 110
Df "E MAIL", 116, 140
Df "hacksnif Q zipmail com br", 12, 156
MMC F1, 0, &HA000, 0
DO
IF Kb(16) AND Kb(56) THEN Desliga: Fim
IF Kb(1) AND Kb(28) = 0 THEN EXIT DO
LOOP
END SUB

SUB Teclas
RESTORE Dados
DEF SEG = VARSEG(Kbc(0))
i& = 0
GOTO Proxima
DO
POKE i&, Q
i& = i& + 1
Proxima:
READ Q
LOOP WHILE Q > -1
i& = 16
n& = VARSEG(Kb(0)): L& = n& AND 255: H& = ((n& AND &HFF00) \ 256): POKE i&, L&: POKE i& + 1, H&: i& = i& + 2
n& = VARPTR(Kb(0)): L& = n& AND 255: H& = ((n& AND &HFF00) \ 256): POKE i&, L&: POKE i& + 1, H&: i& = i& + 2
DEF SEG
END SUB

SUB Tela
GET #1, Lava(Tel1, Tel2)
IF Bit7 = 0 THEN GravaArray: Blocada$ = RTRIM$(Fut$)

col = 4: Lin = 0
Fund$ = "*()|+"
REDIM KKT(1 TO 5)
KKT(1) = 200: KKT(2) = 660: KKT(3) = 1290: KKT(4) = 1570: KKT(5) = 1680

FOR J = 1 TO 14
FOR H = 1 TO LEN(Arra$(J))
FOR KK = 1 TO 5
IF Blocada$ = MID$(Fund$, KK, 1) THEN Shite = KKT(KK): EXIT FOR ELSE Shite = -1111
NEXT KK
IF Shite <> -1111 THEN MMP F1, 0, Blo1, VARPTR(Blo(Shite)), col, Lin, 0: col = col + 14
NEXT H
col = 4
Lin = Lin + 14
NEXT J
col = 4: Lin = 0
Bline F1, 0, 4, 1, 4, 195, 0: Bline F1, 0, 312, 1, 312, 195, 0
Bline F1, 0, 0, 196, 320, 196, 0: Bline F1, 0, 0, 0, 320, 0, 0

Fund$ = " #QqWwEeSsZ@%^"
REDIM KKT(1 TO 14)
KKT(12) = 370: KKT(13) = 485: KKT(14) = 540
FOR KK = 1 TO 10
KKT(KK) = -111
NEXT KK

FOR J = 1 TO 14
FOR H = 1 TO LEN(Arra$(J))
FOR KK = 1 TO 14
IF KK <= 11 AND MID$(Arra$(J), H, 1) = MID$(Fund$, KK, 1) THEN col = col + 14: Shite = -111: EXIT FOR
IF KK >= 12 AND MID$(Arra$(J), H, 1) = MID$(Fund$, KK, 1) THEN Shite = KKT(KK): EXIT FOR ELSE Shite = -111
NEXT KK
IF MID$(Arra$(J), H, 1) = "!" THEN MMP F1, 0, Blo1, VARPTR(Blo(310)), col, Lin + 8, 0: col = col + 14
IF MID$(Arra$(J), H, 1) = "$" THEN MMP F1, 0, Blo1, VARPTR(Blo(430)), col + 8, Lin, 0: col = col + 14
IF Shite <> -111 THEN MMP F1, 0, Blo1, VARPTR(Blo(Shite)), col, Lin, 0: col = col + 14
NEXT H
col = 4
Lin = Lin + 14
NEXT J

col = 4: Lin = 0
Fund$ = "#QqWwesZ"
KKT(1) = 0: KKT(2) = 770: KKT(3) = 885: KKT(4) = 1000: KKT(5) = 1115
KKT(6) = 1400: KKT(7) = 1790: KKT(8) = 1910

FOR J = 1 TO 14
FOR H = 1 TO LEN(Arra$(J))
FOR KK = 1 TO 9
IF MID$(Arra$(J), H, 1) = MID$(Fund$, KK, 1) THEN
Porcaria = True: Shite = KKT(KK): EXIT FOR
ELSE
Porcaria = Falso: Shite = -111
END IF
NEXT KK

IF Shite <> -111 THEN MMP F1, 0, Blo1, VARPTR(Blo(Shite)), col, Lin, 0: col = col + 14
IF MID$(Arra$(J), H, 1) = "E" THEN MMP F1, 0, Blo1, VARPTR(Blo(1230)), col, Lin + 2, 0: col = col + 14: Porcaria = True
IF MID$(Arra$(J), H, 1) = "S" THEN MMP F1, 0, Blo1, VARPTR(Blo(1515)), col + 4, Lin, 0: col = col + 14: Porcaria = True

IF Porcaria = Falso THEN col = col + 14
Porcaria = Falso
NEXT H
col = 4
Lin = Lin + 14
NEXT J

IF Certeza = True THEN Mf "Deseja Sair S ou N", 100, 80: Certeza = Falso

IF Credo = True THEN
MMP F1, 0, Eu1, Eu2, 24, 18, 0
MMP F1, 0, Eu1, Eu2, 219, 18, 0
Mf " FASES ", 134, 78
Mf "PROGRAMA", 131, 88
Mf "ALGUNS-GRAF", 121, 98

Mf "  MARIO", 127, 25
Mf " UPGRADE", 127, 35




Mf "PROGRAMADO POR GILBERTO LIMA CORREIA", 33, 172
Mf "MASTERSOFT", 125, 130
Mf "1999", 144, 143
Paleta 2
END IF
MMC F1, 0, &HA000, 0
END SUB

SUB TenCerte
Certeza = True
Tela
DO
IF Kb(31) THEN Saiam = True: EXIT SUB
IF Kb(49) THEN Tela: EXIT SUB
LOOP
END SUB

SUB Texture (XXX1)
f = -13
p = 0
FOR L = 1 TO 7
FOR G = 1 TO 10
MMP F1, 0, VARSEG(Tex(0)), VARPTR(Tex(XXX1 * 550)), p, f, 4
p = p + 32
NEXT G
p = 0
f = f + 32
NEXT L
END SUB

