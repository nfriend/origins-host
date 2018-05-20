'
'--------------------------BY GILBERTO LIMA CORREIA----------------------
'                     E-MAIL : hacksnif@zipmail.com.br
'                  HOME PAGE : http://www.angelfire.com/mo/veget
'
'                       Para Quick Basic 1.1/4.5/7.1
'
'Este editor permite escolher o fundo de tela, e os blocos, deleta-los
'e inseri-los, e tamb‚m permite que voce escolha a localidade da tela e
'a tela de quando o mario morre onde ele ir  nascer se ser  na mesma tela
'ou em outra.
'
' ----------------------------------HELP---------------------------------
'
' (M) --> MOSTRA O MAPA DE TODO O JOGO, E PERMITE QUE VOCE PULE PARA
'         QUALQUER TELA DA FASE.
' (D) --> DELETA O BLOCO ATIVO.
' (ESP€O) --> INSERE OS BLOCOS --> MAS ANTES E' NESCESSARIO SELECIONA-LO
' (V) --> SELECIONA OS BLOCOS, OU A TELA DE FUNDO.
' (KEYPAD) --> MOVIMENTA O SELETOR
' (KEYPAD NUMERICO) --> MOVIMENTA DE UMA TELA PARA OUTRA
' (T) --> VISUALIZA A TELA E O RESGISTRO DO ARQUIVO EM QUE ELA ESTA
'         GRAVADA, O ARQUIVO E' DE ACESSO ALEATORIO- RANDOM
' (E) --> EXCLUI A TELA ATUAL DO ARQUIVO.
' (C) --> LIMPA A TELA ATUAL, PARA UMA NOVA EDI€AO.
' (L) --> ATIVA O MODO DE ESCOLHA ONDE O MARIO IRA NASCER QUANDO MORRER,
'         E EM QUE TELA. OBS: QUANDO ESSE MODO ESTIVER ATIVADO, AS TECLAS
'         (+) E (-), DEFINEM OS SALTOS DE LOCALIZA€AO DO MARIO.
' (A+KEYPAD NUMERICO) --> ACRESCENTA UMA NOVA TELA, DEVE-SE APERTAR O (A) E
' DEPOIS O KEYPAD NUM, N„O DEVE HAVER TELAS PRONTAS PARA O LADO QUE VOCE
' ESCOLHER.
'
'------------------------------------------------------------------------
'
DECLARE SUB Igua ()
DECLARE SUB Mapa ()
DECLARE SUB Exclui ()
DECLARE SUB Conf ()
DECLARE SUB bcls (segment%, offset%, Col%)
DECLARE SUB GravaMorte ()
DECLARE SUB deixa ()
DECLARE SUB Checa ()
DECLARE SUB Passa ()
DECLARE SUB Gravando ()
DECLARE SUB Seletor ()
DECLARE SUB Constroi ()
DECLARE SUB CopyFu ()
DECLARE SUB DesenhaFundo ()
DECLARE SUB Tela ()
DECLARE SUB Bline (dsegment%, doffset%, X1%, Y1%, X2%, Y2%, colr%)
DECLARE SUB LoadPal ()
DECLARE SUB LoadImg ()
DECLARE SUB InitLib ()
DECLARE SUB Bcopy (fsegment%, foffset%, tsegment%, toffset%)
DECLARE SUB Bget (dsegment%, doffset%, ssegment%, soffset%, X1%, Y1%, X2%, Y2%)
DECLARE SUB Bput (dsegment%, doffset%, ssegment%, soffset%, xpos%, ypos%, icol%)
DEFINT A-Z
SCREEN 13
''ON ERROR GOTO Erro
TYPE Pore
Verme AS INTEGER
Verde AS INTEGER
Azul AS INTEGER
END TYPE
DIM SHARED code1(14), code2(21), code3(91), code4(76), code6(17), code7(25), code8(118), code9(14)
InitLib
CONST True = -1, Falso = NOT True
REDIM SHARED Reser(14) AS STRING * 22
REDIM SHARED Arrai(14) AS STRING
REDIM SHARED Grava(14) AS STRING
REDIM SHARED Blo(4000)
REDIM SHARED Cor(255) AS Pore
REDIM SHARED Kbc(128), Kb(128)
REDIM SHARED Fu(31999)
REDIM SHARED Fu1(31999)
REDIM SHARED Bo(400)
DIM SHARED Shit, Cai, Pulo, So, Lo, Dire, Y, f, Temp, Ati, Mort
DIM SHARED X1, Y1, X2, Y2, Colu, Lina, Colu1, Lina1, Bloco AS STRING
DIM SHARED Tel1, Tel2, Te1$, Te2$, NumReg, Constru, Deleta, Limpado
DIM SHARED Acre, Achou, MorL1$, MorL2$, TelM1$, TelM2$, Fut$, Blocada$
DIM SHARED Morloc1, Morloc2, Mortel1, Mortel2, NumRegM, Temp1, Temp2
DIM SHARED Turbo, NoNo, Telp1, Telp2, Rego$

FILES "MARIOLEV.DAT"

LoadImg
Bget &HA000, 0, VARSEG(Bo(0)), VARPTR(Bo(0)), 43, 34, 62, 53

Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(0)), 126, 119, 140, 133
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(200)), 228, 119, 242, 133
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(310)), 67, 96, 81, 102
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(370)), 84, 92, 90, 106
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(430)), 93, 92, 99, 106
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(485)), 103, 97, 117, 103
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(540)), 93, 76, 107, 90
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(660)), 245, 119, 259, 133
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(770)), 143, 119, 157, 133
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(885)), 177, 119, 191, 133
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1000)), 160, 119, 174, 133
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1115)), 194, 119, 208, 133
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1230)), 126, 135, 140, 141
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1290)), 211, 119, 225, 133
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1400)), 296, 119, 310, 133
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1515)), 143, 135, 149, 149
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1570)), 160, 135, 174, 149
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1680)), 194, 135, 208, 149
Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1790)), 177, 135, 191, 149

Bget &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1910)), 228, 136, 242, 150


LoadPal

'SLEEP 2387
'PALETTE 0, 63
'bcls &HA000, 0, 15
'Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1910)), 100, 100, 2
'END
'Mapa

DesenhaFundo
Telp1 = 0
Telp2 = 0
Inicio:
CLOSE #1
OPEN "MARIOLEV.DAT" FOR RANDOM AS #1 LEN = 500
FIELD #1, 22 AS Grava(1), 22 AS Grava(2), 22 AS Grava(3), 22 AS Grava(4), 22 AS Grava(5), 22 AS Grava(6), 22 AS Grava(7), 22 AS Grava(8), 22 AS Grava(9), 22 AS Grava(10), 22 AS Grava(11), 22 AS Grava(12), 22 AS Grava(13), 22 AS Grava(14), 3 AS Te1$ _
, 3 AS Te2$, 4 AS MorL1$, 4 AS MorL2$, 3 AS TelM1$, 3 AS TelM2$, 4 AS Fut$, 5 AS Rego$
NumReg = 1
Colu1 = 4
Lina1 = 0
X2 = 1
Y2 = 1
Colu = 4
Lina = 0
X1 = 1
Y1 = 1
'Tel1 = 16
'Tel2 = 32
Tel1 = Telp1
Tel2 = Telp2

Passa
Tela
DO
D$ = INKEY$
LINE (0 + Colu, 0 + Lina)-(14 + Colu, 14 + Lina), 15, B
SELECT CASE D$
CASE CHR$(0) + "H": Lina = Lina - 14: CopyFu: X1 = X1 - 1
CASE CHR$(0) + "P": Lina = Lina + 14: CopyFu: X1 = X1 + 1
CASE CHR$(0) + "K": Colu = Colu - 14: CopyFu: Y1 = Y1 - 1
CASE CHR$(0) + "M": Colu = Colu + 14: CopyFu: Y1 = Y1 + 1
CASE "8": Igua: Tel1 = Tel1 - 1: Checa: IF Achou = True OR Acre = True THEN Passa ELSE Tel1 = Tel1 + 1
CASE "2": Igua: Tel1 = Tel1 + 1: Checa: IF Achou = True OR Acre = True THEN Passa ELSE Tel1 = Tel1 - 1
CASE "4": Igua: Tel2 = Tel2 - 1: Checa: IF Achou = True OR Acre = True THEN Passa ELSE Tel2 = Tel2 + 1
CASE "6": Igua: Tel2 = Tel2 + 1: Checa: IF Achou = True OR Acre = True THEN Passa ELSE Tel2 = Tel2 - 1
CASE CHR$(27): END
CASE CHR$(32): Constru = True: Constroi
CASE "V", "v": Seletor
CASE "D", "d": Deleta = True: Constroi
CASE "C", "c": Conf: IF NoNo = Falso THEN Limpado = True: Gravando ELSE NoNo = Falso
CASE "A", "a": Acre = True
CASE "E", "e": Exclui: GOTO Inicio
CASE "L", "l": deixa
CASE "M", "m": Mapa: Passa: Tela
CASE "T", "t"
GET #1, NumReg
LOCATE 1, 1: PRINT "TELA1 = "; Tel1; "TELA2 = "; Tel2; " "; NumReg; " "; Rego$
END SELECT
IF X1 < 1 THEN Lina = 182: X1 = 14
IF X1 > 14 THEN Lina = 0: X1 = 1
IF Y1 < 1 THEN Colu = 298: Y1 = 22
IF Y1 > 22 THEN Colu = 4: Y1 = 1
LOOP
Erro:
IF ERR = 53 THEN
OPEN "MARIOLEV.DAT" FOR RANDOM AS #1 LEN = 500
FIELD #1, 22 AS Grava(1), 22 AS Grava(2), 22 AS Grava(3), 22 AS Grava(4), 22 AS Grava(5), 22 AS Grava(6), 22 AS Grava(7), 22 AS Grava(8), 22 AS Grava(9), 22 AS Grava(10), 22 AS Grava(11), 22 AS Grava(12), 22 AS Grava(13), 22 AS Grava(14), 3 AS Te1$ _
, 3 AS Te2$, 4 AS MorL1$, 4 AS MorL2$, 3 AS TelM1$, 3 AS TelM2$, 4 AS Fut$, 6 AS Rego$
FOR K = 1 TO 14
LSET Grava(K) = SPACE$(22)
NEXT K
PUT #1, 1
CLOSE #1
RESUME NEXT
END IF
STOP
RETURN

SUB bcls (segment, offset, Col)
DEF SEG = VARSEG(code6(0))
CALL ABSOLUTE(BYVAL segment, BYVAL offset, BYVAL Col, VARPTR(code6(0)))
DEF SEG
END SUB

SUB Bcopy (fsegment%, foffset%, tsegment%, toffset%)
IF tsegment% = &HA000 THEN WAIT &H3DA, 8
DEF SEG = VARSEG(code1%(0))
CALL ABSOLUTE(BYVAL fsegment%, BYVAL foffset%, BYVAL tsegment%, BYVAL toffset%, VARPTR(code1%(0)))
DEF SEG
END SUB

SUB Bget (dsegment, doffset, ssegment, soffset, X1, Y1, X2, Y2)
DEF SEG = VARSEG(code4(0))
CALL ABSOLUTE(BYVAL dsegment, BYVAL doffset, BYVAL ssegment, BYVAL soffset, BYVAL X1, BYVAL Y1, BYVAL X2, BYVAL Y2, VARPTR(code4(0)))
DEF SEG
END SUB

SUB Bline (dsegment, doffset, X1, Y1, X2, Y2, colr)
DEF SEG = VARSEG(code8(0))
CALL ABSOLUTE(BYVAL dsegment, BYVAL doffset, BYVAL X1, BYVAL Y1, BYVAL X2, BYVAL Y2, BYVAL colr, VARPTR(code8(0)))
DEF SEG
END SUB

SUB Bput (dsegment, doffset, ssegment, soffset, xpos, ypos, icol)
DEF SEG = VARSEG(code3(0))
CALL ABSOLUTE(BYVAL dsegment, BYVAL doffset, BYVAL ssegment, BYVAL soffset, BYVAL xpos, BYVAL ypos, BYVAL icol, VARPTR(code3(0)))
DEF SEG
END SUB

SUB Checa
FOR K# = 1 TO 10000
GET #1, K#
IF Tel1 = VAL(Te1$) AND Tel2 = VAL(Te2$) THEN Achou = True: EXIT SUB
IF EOF(1) THEN Achou = Falso: EXIT SUB
NEXT K#
END SUB

SUB Conf
LOCATE 10, 10: PRINT "Tem certeza que deseja limpar esta tela"
LOCATE 12, 18: PRINT "(S/N)"
DO
D$ = INKEY$
IF D$ = "s" OR D$ = "S" THEN EXIT SUB
IF D$ = "N" OR D$ = "n" OR D$ = CHR$(27) THEN NoNo = True: Tela: EXIT SUB
LOOP
END SUB

SUB Constroi
Tela
END SUB

SUB CopyFu
Bcopy VARSEG(Fu(0)), VARPTR(Fu(0)), &HA000, 0
END SUB

SUB deixa
FOR L = 1 TO 14
Reser(L) = Arrai(L)
NEXT L
Tela
NumRegM = NumReg
GET #1, NumReg
Temp1 = Tel1
Temp2 = Tel2
IF VAL(MorL1$) = 0 AND VAL(MorL2$) = 0 THEN
Morloc1 = 162
Morloc2 = 82
ELSE
Tel1 = VAL(TelM1$)
Tel2 = VAL(TelM2$)
Morloc1 = VAL(MorL1$)
Morloc2 = VAL(MorL2$)
Passa
Tela
END IF
Anda = 10
DO
D$ = INKEY$
SELECT CASE D$
CASE CHR$(0) + "H": Morloc2 = Morloc2 - Anda: Tela
CASE CHR$(0) + "P": Morloc2 = Morloc2 + Anda: Tela
CASE CHR$(0) + "K": Morloc1 = Morloc1 - Anda: Tela
CASE CHR$(0) + "M": Morloc1 = Morloc1 + Anda: Tela
CASE "8": Tel1 = Tel1 - 1: Checa: IF Achou = True OR Acre = True THEN Passa ELSE Tel1 = Tel1 + 1
CASE "2": Tel1 = Tel1 + 1: Checa: IF Achou = True OR Acre = True THEN Passa ELSE Tel1 = Tel1 - 1
CASE "4": Tel2 = Tel2 - 1: Checa: IF Achou = True OR Acre = True THEN Passa ELSE Tel2 = Tel2 + 1
CASE "6": Tel2 = Tel2 + 1: Checa: IF Achou = True OR Acre = True THEN Passa ELSE Tel2 = Tel2 - 1
CASE "+": IF Anda <= 10 THEN Anda = Anda + 2: LOCATE 11, 20: PRINT Anda
CASE "-": IF Anda >= 4 THEN Anda = Anda - 2: LOCATE 11, 20: PRINT Anda
CASE CHR$(32): GravaMorte: Tel1 = Temp1: Tel2 = Temp2: Passa: Tela: EXIT SUB
CASE CHR$(27): Tel1 = Temp1: Tel2 = Temp2: Passa: Tela: EXIT SUB
END SELECT
IF Morloc2 < 2 THEN Morloc2 = 176
IF Morloc2 > 176 THEN Morloc2 = 2
IF Morloc1 > 294 THEN Morloc1 = 4
IF Morloc1 < 4 THEN Morloc1 = 294
Bput &HA000, 0, VARSEG(Bo(0)), VARPTR(Bo(0)), Morloc1, Morloc2, 0
LOOP
END SUB

SUB DesenhaFundo
Col = 4
Lin = 0
FOR J = 1 TO 14
FOR H = 1 TO 22
IF Blocada$ = "*" THEN
Bput VARSEG(Fu1(0)), VARPTR(Fu1(0)), VARSEG(Blo(0)), VARPTR(Blo(200)), Col, Lin, 251: Col = Col + 14
ELSEIF Blocada$ = "(" THEN Bput VARSEG(Fu1(0)), VARPTR(Fu1(0)), VARSEG(Blo(0)), VARPTR(Blo(660)), Col, Lin, 251: Col = Col + 14
ELSEIF Blocada$ = ")" THEN Bput VARSEG(Fu1(0)), VARPTR(Fu1(0)), VARSEG(Blo(0)), VARPTR(Blo(1290)), Col, Lin, 251: Col = Col + 14
ELSEIF Blocada$ = "|" THEN Bput VARSEG(Fu1(0)), VARPTR(Fu1(0)), VARSEG(Blo(0)), VARPTR(Blo(1570)), Col, Lin, 251: Col = Col + 14
ELSEIF Blocada$ = "+" THEN Bput VARSEG(Fu1(0)), VARPTR(Fu1(0)), VARSEG(Blo(0)), VARPTR(Blo(1680)), Col, Lin, 251: Col = Col + 14
ELSE
bcls VARSEG(Fu1(0)), VARPTR(Fu1(0)), 0: EXIT SUB
END IF

NEXT H
Col = 4
Lin = Lin + 14
NEXT J
Blocada$ = ""
Bline VARSEG(Fu1(0)), VARPTR(Fu1(0)), 4, 1, 4, 195, 0
Bline VARSEG(Fu1(0)), VARPTR(Fu1(0)), 312, 1, 312, 195, 0
Bline VARSEG(Fu1(0)), VARPTR(Fu1(0)), 0, 196, 320, 196, 0
Bline VARSEG(Fu1(0)), VARPTR(Fu1(0)), 0, 0, 320, 0, 0
END SUB

SUB Exclui
LOCATE 10, 10: PRINT "Tem certeza que deseja Excluir esta tela"
LOCATE 12, 18: PRINT "(S/N)"
DO
D$ = INKEY$
IF D$ = "s" OR D$ = "S" THEN
GET #1, NumReg
FOR K = 1 TO 14
Grava(K) = ""
NEXT K
LSET Te1$ = "EX"
LSET Te2$ = ""
LSET MorL1$ = ""
LSET MorL2$ = ""
LSET TelM1$ = ""
LSET TelM2$ = ""
LSET Fut$ = ""
PUT #1, NumReg
Tel1 = Telp1: Tel2 = Telp2
Passa
Tela
EXIT SUB
END IF
IF D$ = "N" OR D$ = "n" OR D$ = CHR$(27) THEN Tela: EXIT SUB
LOOP
END SUB

SUB GravaMorte
FOR K = 1 TO 14
LSET Grava(K) = Reser(K)
NEXT K
LSET MorL1$ = STR$(Morloc1)
LSET MorL2$ = STR$(Morloc2)
LSET TelM1$ = STR$(Tel1)
LSET TelM2$ = STR$(Tel2)
LSET Te1$ = STR$(Temp1)
LSET Te2$ = STR$(Temp2)
PUT #1, NumRegM
END SUB

SUB Gravando
IF Limpado = True THEN
FOR K = 1 TO 14
LSET Grava(K) = SPACE$(22)
NEXT K
LSET Te1$ = STR$(Tel1)
LSET Te2$ = STR$(Tel2)
LSET Rego$ = STR$(NumReg)
PUT #1, NumReg
Limpado = Falso
Tela
ELSE
FOR K = 1 TO 14
LSET Grava(K) = Arrai(K)
NEXT K
LSET Te1$ = STR$(Tel1)
LSET Te2$ = STR$(Tel2)
LSET Rego$ = STR$(NumReg)
IF Bloco = "*" OR Bloco = "(" OR Bloco = ")" OR Bloco = "|" OR Bloco = "+" THEN
LSET Fut$ = Bloco
END IF
PUT #1, NumReg
END IF
END SUB

SUB Igua
Telp1 = Tel1
Telp2 = Tel2
END SUB

SUB InitLib
code$ = "1E5589E58B460E8ED88B760C8B460A8EC08B7E08B9007DF3A55D1FCA0800"
DEF SEG = VARSEG(code1(0))
FOR I = 0 TO 29
D = VAL("&h" + MID$(code$, I * 2 + 1, 2))
POKE VARPTR(code1(0)) + I, D
NEXT I
DEF SEG
code$ = "1E5589E58B46108ED88B760AB106D3E689F3B102D3E601DE8B5E0C01DE8B5E0E01DE8A460888045D1FCA0A00"
DEF SEG = VARSEG(code2(0))
FOR I = 0 TO 43
D = VAL("&h" + MID$(code$, I * 2 + 1, 2))
POKE VARPTR(code2(0)) + I, D
NEXT I
DEF SEG
code$ = "1E5589E58B460C508B460A508B46108ED88B760E8B04B103D3E8508B5EFE"
code$ = code$ + "01C3895EFE8B4402508B5EFC01C3895EFC83C60489760E89E58B46188ED8"
code$ = code$ + "8B76168A04468976163A4610743DBB0000395E147C35395E127C30BB3F01"
code$ = code$ + "395E147F28BBC700395E127F208B5E1C8EDB8B7612B106D3E689F3B102"
code$ = code$ + "D3E601DE8B5E1401DE8B5E1A01DE88048B4614408946148B460639461475"
code$ = code$ + "A18B46142B46028946148B4612408946128B46043946127589585858585D"
code$ = code$ + "1FCA0E00"
DEF SEG = VARSEG(code3(0))
FOR I = 0 TO 182
D = VAL("&h" + MID$(code$, I * 2 + 1, 2))
POKE VARPTR(code3(0)) + I, D
NEXT I
DEF SEG
code$ = "1E5589E58B460A508B4608508B460A2B460E40508B46082B460C40508B46128ED8"
code$ = code$ + "8B76108B46FABB0800F7E3890446468B46F88904464689761089E58B5E"
code$ = code$ + "1E8EDB8B7614B106D3E689F3B102D3E601DE8B5E1601DE8B5E1C01DE8A"
code$ = code$ + "048B5E1A8EDB8B76188804468976188B4616408946168B460639461676"
code$ = code$ + "C38B46162B46028946168B4614408946148B460439461476AB58585858"
code$ = code$ + "5D1FCA1000"
DEF SEG = VARSEG(code4(0))
FOR I = 0 TO 153
D = VAL("&h" + MID$(code$, I * 2 + 1, 2))
POKE VARPTR(code4(0)) + I, D
NEXT I
DEF SEG
code$ = "1E5589E58B460C8ED88B760A8B460888C4B900FA890483C60283E90275F65D1FCA0600"
DEF SEG = VARSEG(code6(0))
FOR I = 0 TO 34
D = VAL("&h" + MID$(code$, I * 2 + 1, 2))
POKE VARPTR(code6(0)) + I, D
NEXT I
DEF SEG
code$ = "1E5589E58B46128ED88B760CB106D3E689F3B102D3E601DE8B5E0C01DE8B5E100"
code$ = code$ + "1DE8A1C8B460A8ED88B7608881C5D1FCA0C00"
DEF SEG = VARSEG(code7(0))
FOR I = 0 TO 50
D = VAL("&h" + MID$(code$, I * 2 + 1, 2))
POKE VARPTR(code7(0)) + I, D
NEXT I
DEF SEG
code$ = "1E5589E58B460C2B4610508B460A2B460E50B8010050B840015089E58B46188B5E1439"
code$ = code$ + "D87E168B4602BBFFFFF7E38946028B4606BBFFFFF7E38946068B46168B5E"
code$ = code$ + "1239D87E168B4600BBFFFFF7E38946008B4604BBFFFFF7E38946048B46"
code$ = code$ + "1C8ED88B7616B106D3E689F3B102D3E601DE8B5E1801DE8B5E1A01DE"
code$ = code$ + "8B46068B5E0439D87E2FBB000089C13D00007F07B9FFFFF7E189C18A46"
code$ = code$ + "108804037602035E043B5E067C060376002B5E064983F9007DE4EB32B8"
code$ = code$ + "000089D983FB007F0C89D8B9FFFFF7E189C1B800008A5E10881C037600"
code$ = code$ + "0346063B46047C060376022B46044983F9007DE4585858585D1FCA0E00"
DEF SEG = VARSEG(code8(0))
FOR I = 0 TO 237
D = VAL("&h" + MID$(code$, I * 2 + 1, 2))
POKE VARPTR(code8(0)) + I, D
NEXT I
DEF SEG
code$ = "1E5589E58B46108ED88B760E8B460C8EC08B7E0A8B4E08F3A45D1FCA0A00"
DEF SEG = VARSEG(code9(0))
FOR I = 0 TO 29
D = VAL("&h" + MID$(code$, I * 2 + 1, 2))
POKE VARPTR(code9(0)) + I, D
NEXT I
DEF SEG
END SUB

SUB LoadImg
DEF SEG = &HA000
BLOAD "MARIO.GRP", 0
END SUB

SUB LoadPal
DEF SEG = VARSEG(Cor(0))
BLOAD "MARIO.PAL", VARPTR(Cor(0))
OUT &H3C8, 0
FOR J = 0 TO 255
OUT &H3C9, Cor(J).Verme
OUT &H3C9, Cor(J).Verde
OUT &H3C9, Cor(J).Azul
NEXT J
END SUB

SUB Mapa
CLS
FOR L = 0 TO 200 STEP 3
LINE (0, L)-(318, L), 3
NEXT L
FOR L = 0 TO 320 STEP 3
LINE (L, 0)-(L, 198), 3
NEXT L
K = 159
O = 99
K = K + (Tel2 * 3)
O = O + (Tel1 * 3)
TelMap1 = 0
TelMap2 = 0
Tela1 = 0
Tela2 = 0
Kc# = 1
FOR Kc# = 1 TO 100000
GET #1, Kc#
IF EOF(1) THEN EXIT FOR
M1 = 0
M2 = 0
TelMap2 = -53
TelMap1 = -33
Pata1 = Falso
Pata2 = Falso
DO
IF Pata1 = Falso THEN TelMap2 = TelMap2 + 1: M2 = M2 + 1
IF Pata1 = Falso THEN IF TelMap2 = VAL(Te2$) THEN Pata1 = True
IF Pata2 = Falso THEN TelMap1 = TelMap1 + 1: M1 = M1 + 1
IF Pata2 = Falso THEN IF TelMap1 = VAL(Te1$) THEN Pata2 = True
IF Pata1 AND Pata2 = True THEN EXIT DO
LOOP
PAINT (M2 * 3 + 1, M1 * 3 + 1), 14, 3
NEXT Kc#
TelMap1 = Tel1
TelMap2 = Tel2
DO
D$ = INKEY$
IF K > 315 THEN K = 0: TelMap2 = -53
IF O > 195 THEN O = 0: TelMap1 = -33
IF K < 0 THEN K = 315: LINE (0, 0)-(0, 198), 3, B: TelMap2 = 52
IF O < 0 THEN O = 195: LINE (0, 0)-(318, 0), 3, B: TelMap1 = 32
LINE (K, O)-(K + 3, O + 3), 15, B
SELECT CASE D$
CASE CHR$(0) + "H": O = O - 3: LINE (K, O)-(K + 3, O + 6), 3, B: TelMap1 = TelMap1 - 1
CASE CHR$(0) + "P": O = O + 3: LINE (K, O - 3)-(K + 3, O), 3, B: TelMap1 = TelMap1 + 1
CASE CHR$(0) + "K": K = K - 3: LINE (K, O)-(K + 6, O + 3), 3, B: TelMap2 = TelMap2 - 1
CASE CHR$(0) + "M": K = K + 3: LINE (K - 3, O)-(K, O + 3), 3, B: TelMap2 = TelMap2 + 1
CASE CHR$(27): EXIT DO
CASE CHR$(32): Tel1 = TelMap1: Tel2 = TelMap2: Checa: IF Achou = True THEN EXIT DO ELSE Achou = Falso
END SELECT
LOOP
Achou = Falso
END SUB

SUB Passa
FOR K# = 1 TO 10000
VolMax:
GET #1, K#
IF Acre = True AND RTRIM$(Te1$) = "EX" THEN GOTO Acrescente
IF Acre = Falso AND RTRIM$(Te1$) = "EX" THEN K# = K# + 1: GOTO VolMax
IF Tel1 = VAL(Te1$) AND Tel2 = VAL(Te2$) THEN NumReg = K#: Tela: EXIT FOR
IF EOF(1) AND Acre = True THEN
Acrescente:
Acre = Falso
FOR K = 1 TO 14
LSET Grava(K) = SPACE$(22)
NEXT K
PUT #1, K#
NumReg = K#: CLS : EXIT FOR
END IF
Achou = Falso
NEXT K#
Bcopy &HA000, 0, VARSEG(Fu(0)), VARPTR(Fu(0))
END SUB

SUB Seletor
CLS
Col = 4
Lin = 0
REDIM Poli$(14)
Poli$(1) = "!@$%^#QqWwEeSsZ"
Poli$(2) = "*()|+"

FOR J = 1 TO 2
FOR H = 1 TO LEN(Poli$(J))
IF MID$(Poli$(J), H, 1) = " " THEN Col = Col + 14
IF MID$(Poli$(J), H, 1) = "#" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(0)), Col, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "Q" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(770)), Col, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "q" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(885)), Col, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "W" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1000)), Col, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "w" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1115)), Col, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "E" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1230)), Col, Lin + 2, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "e" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1400)), Col, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "S" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1515)), Col + 4, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "s" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1790)), Col, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "Z" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1910)), Col, Lin, 0: Col = Col + 14

IF MID$(Poli$(J), H, 1) = "!" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(310)), Col, Lin + 8, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "@" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(370)), Col, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "$" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(430)), Col + 8, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "%" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(485)), Col, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "^" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(540)), Col, Lin, 0: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "*" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(200)), Col, Lin, 251: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "(" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(660)), Col, Lin, 251: Col = Col + 14
IF MID$(Poli$(J), H, 1) = ")" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1290)), Col, Lin, 251: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "|" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1570)), Col, Lin, 251: Col = Col + 14
IF MID$(Poli$(J), H, 1) = "+" THEN Bput &HA000, 0, VARSEG(Blo(0)), VARPTR(Blo(1680)), Col, Lin, 251: Col = Col + 14
NEXT H
Col = 4
Lin = Lin + 14
NEXT J

DO
D$ = INKEY$
LINE (0 + Colu1, 0 + Lina1)-(14 + Colu1, 14 + Lina1), 15, B
SELECT CASE D$
CASE CHR$(0) + "H": Lina1 = Lina1 - 14: X2 = X2 - 1: LINE (0 + Colu1, 0 + Lina1)-(14 + Colu1, Lina1 + 28), 0, B
CASE CHR$(0) + "P": Lina1 = Lina1 + 14: X2 = X2 + 1: LINE (0 + Colu1, 0 + Lina1)-(14 + Colu1, Lina1 - 14), 0, B
CASE CHR$(0) + "K": Colu1 = Colu1 - 14: Y2 = Y2 - 1: LINE (0 + Colu1, 0 + Lina1)-(28 + Colu1, Lina1 + 14), 0, B
CASE CHR$(0) + "M": Colu1 = Colu1 + 14: Y2 = Y2 + 1: LINE (Colu1 - 14, Lina1)-(Colu1, Lina1 + 14), 0, B
CASE CHR$(27): CopyFu: EXIT SUB
CASE CHR$(32)
CopyFu
Bloco = MID$(Poli$(X2), Y2, 1)
IF Bloco = "" THEN Bloco = " "
IF Bloco = "*" OR Bloco = "(" OR Bloco = ")" OR Bloco = "|" THEN DesenhaFundo: Gravando: Tela: Bloco = " "
IF Bloco = "+" THEN DesenhaFundo: Gravando: Tela: Bloco = " "
EXIT SUB

END SELECT
IF X2 < 1 THEN Lina1 = 182: X2 = 14: LINE (4, 0)-(14 + Colu1, Lina1 + 14), 0, B
IF X2 > 14 THEN Lina1 = 0: X2 = 1
IF Y2 < 1 THEN Colu1 = 298: Y2 = 22: LINE (4, 0)-(14 + Colu1, Lina1 + 14), 0, B
IF Y2 > 22 THEN Colu1 = 4: Y2 = 1

LOOP

END SUB

SUB Tela
GET #1, NumReg
Blocada$ = RTRIM$(Fut$)
FOR K = 1 TO 14
Arrai(K) = Grava(K)
NEXT K
DesenhaFundo
Bcopy VARSEG(Fu1(0)), VARPTR(Fu1(0)), VARSEG(Fu(0)), VARPTR(Fu(0))

IF Deleta = True THEN MID$(Arrai(X1), Y1, 1) = " ": Deleta = Falso: Gravando
IF Constru = True THEN MID$(Arrai(X1), Y1, 1) = Bloco: Constru = Falso: Gravando

Col = 4
Lin = 0

FOR J = 1 TO 14
FOR H = 1 TO LEN(Arrai(J))
IF MID$(Arrai(J), H, 1) = " " THEN Col = Col + 14
IF MID$(Arrai(J), H, 1) = "#" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(0)), Col, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "!" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(310)), Col, Lin + 8, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "@" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(370)), Col, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "$" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(430)), Col + 8, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "%" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(485)), Col, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "^" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(540)), Col, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "Q" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(770)), Col, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "q" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(885)), Col, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "W" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(1000)), Col, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "w" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(1115)), Col, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "E" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(1230)), Col, Lin + 2, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "e" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(1400)), Col, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "S" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(1515)), Col + 4, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "s" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(1790)), Col, Lin, 0: Col = Col + 14
IF MID$(Arrai(J), H, 1) = "Z" THEN Bput VARSEG(Fu(0)), VARPTR(Fu(0)), VARSEG(Blo(0)), VARPTR(Blo(1910)), Col, Lin, 0: Col = Col + 14
NEXT H
Col = 4
Lin = Lin + 14
NEXT J

Bcopy VARSEG(Fu(0)), VARPTR(Fu(0)), &HA000, 0
END SUB

