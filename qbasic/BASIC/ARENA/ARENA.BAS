1 CLS : atu = 0
2 PRINT "Welcome to the Arena."
5 PRINT "Please enter your name."
INPUT name$
8 INPUT "Would you like to restore an o-old game or start a n-new one?", yn$
9 IF yn$ = "n" THEN GOTO 20
file$ = "./save/arena/save/" + name$
10 OPEN file$ FOR INPUT AS #1
12 INPUT #1, pro$
13 INPUT #1, stam, ag, inte, str, spe, per, ste
14 CLOSE #1
16 PRINT "Your data has been retrieved."
18 GOTO 50
20 PRINT "Would you like to be a warrior, ninja, magician, thief, mercenery, or hunter?"
INPUT pro$
22 IF pro$ = "warrior" THEN stam = 7: ag = 4: inte = 1: str = 7: spe = 4: per = 4: ste = 3: GOTO 50
24 IF pro$ = "ninja" THEN stam = 3: ag = 7: inte = 4: str = 1: spe = 7: per = 4: ste = 4: GOTO 50
26 IF pro$ = "magician" THEN stam = 3: ag = 4: inte = 8: str = 1: spe = 5: per = 5: ste = 4: GOTO 50
28 IF pro$ = "thief" THEN stam = 4: ag = 4: inte = 4: str = 1: spe = 5: per = 5: ste = 7: GOTO 50
30 IF pro$ = "mercenery" THEN stam = 6: ag = 4: inte = 3: str = 6: spe = 4: per = 4: ste = 3: GOTO 50
32 IF pro$ = "hunter" THEN stam = 4: ag = 4: inte = 4: str = 4: spe = 4: per = 5: ste = 5: GOTO 50
34 GOTO 20
50 PRINT "please enter a number from 1-10"
51 INPUT thnr
52 mhc = 0
54 FOR rng = 1 TO thnr
56 nothing = RND * 6
58 NEXT rng
FOR tim = 1 TO 4
ehide(i) = 0: ehc(i) = 0
hide(i) = 0: hc(i) = 0
NEXT tim
mp = inte * 2
59 hp = stam * 2: PRINT "stamina is"; stam; ", agility is"; ag; ", intelligence is"; inte; ",strength is"; str; ", speed is"; spe; ", perception is"; per; ", stealth is"; ste; ", hit points are "; hp; ", magic points are "; mp
60 PRINT "You are now ready to enter the arena "
ravg = ((stam + ag + inte + str + spe + per + ste) / 7)
avg = INT(ravg)
62 FOR en = 1 TO 4
65 di = INT(RND * 2) + 1
IF di = 1 THEN estam(en) = avg - ((INT(RND * 3)) + 1) ELSE estam(en) = avg + ((INT(RND * 3)) + 1)
IF estam(en) < 1 THEN estam(en) = 1
75 di = INT(RND * 2) + 1
IF di = 1 THEN eag(en) = avg - ((INT(RND * 3)) + 1) ELSE eag(en) = avg + ((INT(RND * 3)) + 1)
IF eag(en) < 1 THEN eag(en) = 1
85 di = INT(RND * 2) + 1
IF di = 1 THEN einte(en) = avg - ((INT(RND * 3)) + 1) ELSE einte(en) = avg + ((INT(RND * 3)) + 1)
IF einte(en) < 1 THEN einte(en) = 1
95 di = INT(RND * 2) + 1
IF di = 1 THEN estr(en) = avg - ((INT(RND * 3)) + 1) ELSE estr(en) = avg + ((INT(RND * 3)) + 1)
IF estr(en) < 1 THEN estr(en) = 1
105 di = INT(RND * 2) + 1
IF di = 1 THEN espe(en) = avg - ((INT(RND * 3)) + 1) ELSE espe(en) = avg + ((INT(RND * 3)) + 1)
IF espe(en) < 1 THEN espe(en) = 1
115 di = INT(RND * 2) + 1
IF di = 1 THEN eper(en) = avg - ((INT(RND * 3)) + 1) ELSE eper(en) = avg + ((INT(RND * 3)) + 1)
IF eper(en) < 1 THEN eper(en) = 1
125 di = INT(RND * 2) + 1
IF di = 1 THEN este(en) = avg - ((INT(RND * 3)) + 1) ELSE este(en) = avg + ((INT(RND * 3)) + 1)
IF este(en) < 1 THEN este(en) = 1
130 eavg(en) = (este(en) + eper(en) + espe(en) + estr(en) + einte(en) + eag(en) + estam(en)) / 7
135 IF eavg(en) > ravg + 2 THEN GOTO 65
ehp(en) = estam(en) * 2
emp(en) = einte(en) * 2
PRINT estam(en); eag(en); einte(en); estr(en); espe(en); eper(en); este(en); ehp(en)
NEXT en
INPUT nonsense
200 'place enemies
206 SCREEN 1
207 COLOR 8, 0
PALETTE 2, 8
VIEW (1, 1)-(318, 160), 2, 1
PALETTE 3, 4
210 FOR i = 1 TO 4
220 ex(i) = (INT(RND * 32) + 1) * 10: ey(i) = (INT(RND * 16) + 1) * 10
230 NEXT i
400 'graphics setup
425 mcx = 160 + l: mcy = 100 + u
433 FOR i = 1 TO 4
IF mcx = ex(i) AND mcy = ey(i) THEN l = l + 10
NEXT i
435 LINE (mcx + 4, mcy + 1)-(mcx + 4, mcy + 5), 3
436 LINE (mcx + 3, mcy + 1)-(mcx + 5, mcy + 1), 3
437 LINE (mcx + 3, mcy + 3)-(mcx + 3, mcy + 8), 3
438 LINE (mcx + 5, mcy + 3)-(mcx + 5, mcy + 5), 3
439 LINE (mcx + 6, mcy + 3)-(mcx + 7, mcy + 3), 3
440 LINE (mcx + 6, mcy + 6)-(mcx + 6, mcy + 8), 3
441 LINE (mcx + 8, mcy + 1)-(mcx + 8, mcy + 2), 3
465 GOSUB 1000
470 BEEP: blo = 0: cou = 0
472 IF myblind > 0 THEN myblind = myblind - 1
474 FOR mm = 1 TO INT(spe / 2)
475 LOCATE 23, 1: PRINT "                                      "
476 DO
480 g$ = INKEY$
500 LOOP UNTIL g$ <> ""
IF g$ = "8" THEN u = u - 10: GOTO 515
507 IF g$ = "4" THEN l = l - 10: GOTO 515
509 IF g$ = "2" THEN u = u + 10: GOTO 515
511 IF g$ = "6" THEN l = l + 10: GOTO 515
514 GOTO 5000
515 FOR x = 1 TO 10
520 FOR y = 1 TO 10
530 PRESET (mcx + x, mcy + y)
535 NEXT y
540 NEXT x
550 GOTO 600
600 'move
610 mcx = (160 + l): mcy = (100 + u)
635 LINE (mcx + 4, mcy + 1)-(mcx + 4, mcy + 5), 3
636 LINE (mcx + 3, mcy + 1)-(mcx + 5, mcy + 1), 3
637 LINE (mcx + 3, mcy + 3)-(mcx + 3, mcy + 8), 3
638 LINE (mcx + 5, mcy + 3)-(mcx + 5, mcy + 5), 3
639 LINE (mcx + 6, mcy + 3)-(mcx + 7, mcy + 3), 3
640 LINE (mcx + 6, mcy + 6)-(mcx + 6, mcy + 8), 3
641 LINE (mcx + 8, mcy + 1)-(mcx + 8, mcy + 2), 3
680 GOSUB 1000
690 NEXT mm
LOCATE 23, 1: PRINT "Please Wait..."
691 atu = 0
692 FOR i = 1 TO 4
694 eblo(i) = 0: ecou(i) = 0
696 NEXT i
700 GOTO 2000
1000 'checking
1010 FOR j = 1 TO 4
1012 IF ek(j) = 1 THEN GOTO 1030
1020 IF ((SQR((ex(j) - mcx) ^ 2 + (ey(j) - mcy) ^ 2)) / 10) < (per - este(j)) OR ((SQR((ex(j) - mcx) ^ 2 + (ey(j) - mcy) ^ 2)) / 10) < 2 THEN GOTO 1200
1021 FOR x = 1 TO 10
1022 FOR y = 1 TO 20
1023 PRESET (ex(j) + x, ey(j) + y)
1024 NEXT y
1025 NEXT x
1027 si(j) = 0
1030 NEXT j
1040 RETURN
1200 IF myblind = 1 THEN GOTO 1030
si(j) = 1
1201 IF este(i) > 2 * per THEN ehide(i) = 1 AND ehc(i) = ehc(i) + 1
1202 IF ehide(i) = 1 AND ehc(i) < 3 THEN GOTO 1030
1235 LINE (ex(j) + 4, ey(j) + 1)-(ex(j) + 4, ey(j) + 5), 1
1236 LINE (ex(j) + 3, ey(j) + 1)-(ex(j) + 5, ey(j) + 1), 1
1237 LINE (ex(j) + 3, ey(j) + 3)-(ex(j) + 3, ey(j) + 8), 1
1238 LINE (ex(j) + 5, ey(j) + 3)-(ex(j) + 5, ey(j) + 5), 1
1239 LINE (ex(j) + 6, ey(j) + 3)-(ex(j) + 7, ey(j) + 3), 1
1240 LINE (ex(j) + 6, ey(j) + 6)-(ex(j) + 6, ey(j) + 8), 1
1241 LINE (ex(j) + 8, ey(j) + 1)-(ex(j) + 8, ey(j) + 2), 1
1250
SELECT CASE j
        CASE IS = 1
                LINE (ex(j) + 5, ey(j) + 10)-(ex(j) + 5, ey(j) + 16), 1
        CASE IS = 2
                LINE (ex(j) + 3, ey(j) + 10)-(ex(j) + 6, ey(j) + 10), 1
                LINE (ex(j) + 6, ey(j) + 11)-(ex(j) + 6, ey(j) + 13), 1
                LINE (ex(j) + 6, ey(j) + 13)-(ex(j) + 3, ey(j) + 16), 1
                LINE (ex(j) + 3, ey(j) + 16)-(ex(j) + 6, ey(j) + 16), 1
        CASE IS = 3
                LINE (ex(j) + 3, ey(j) + 10)-(ex(j) + 6, ey(j) + 10), 1
                LINE (ex(j) + 6, ey(j) + 11)-(ex(j) + 6, ey(j) + 16), 1
                LINE (ex(j) + 3, ey(j) + 16)-(ex(j) + 6, ey(j) + 16), 1
                LINE (ex(j) + 3, ey(j) + 13)-(ex(j) + 6, ey(j) + 13), 1
        CASE IS = 4
                LINE (ex(j) + 3, ey(j) + 10)-(ex(j) + 3, ey(j) + 13), 1
                LINE (ex(j) + 3, ey(j) + 13)-(ex(j) + 7, ey(j) + 13), 1
                LINE (ex(j) + 6, ey(j) + 10)-(ex(j) + 6, ey(j) + 16), 1
END SELECT
1300 GOTO 1030
2000 'enemy moves
2010 FOR i = 1 TO 4
2012 IF ek(i) = 1 THEN GOTO 2490
2013 IF poi(i) = 1 THEN ehp(i) = ehp(i) - poidam
2014 IF ehp(i) < 1 THEN po = 2000: LOCATE 23, 1: PRINT "Enemy "; i; " has died from poison.": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                               ": GOTO 9500
2015 em = INT(espe(i) / 2)
2017 IF em = 0 THEN em = 1
IF ehp(i) < stam AND emp(i) > 3 AND einte(i) > 10 AND INT(RND(1) * 2) = 0 THEN espell$ = "heal": GOTO 4100
2018 IF blind(i) > 0 THEN blind(i) = blind(i) - 1
2019 IF ste > eper(i) * 2 THEN hc(i) = hc(i) + 1: hide(i) = 1
2020 FOR et = 1 TO em
2021 FOR x = 1 TO 10
2022 FOR y = 1 TO 20
2025 PRESET (ex(i) + x, ey(i) + y)
2026 NEXT y
2027 NEXT x
2028
2029 IF hide(i) = 1 AND hc(i) < 2 THEN LOCATE 23, 1: PRINT "The enemy "; i; "fails to notice you!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 2: PRINT "                                    ": GOTO 2040
2030 IF ((SQR((ex(i) - mcx) ^ 2 + (ey(i) - mcy) ^ 2)) / 10) < (eper(i) - ste) OR ((SQR((ex(i) - mcx) ^ 2 + (ey(i) - mcy) ^ 2)) / 10) < 2 THEN GOSUB 2500
2040 ed = INT(RND * 4)
2050 IF ed = 0 THEN ex(i) = ex(i) + 10: ef(i) = 90
2060 IF ed = 1 THEN ex(i) = ex(i) - 10: ef(i) = 270
2070 IF ed = 2 THEN ey(i) = ey(i) - 10: ef(i) = 180
2080 IF ed = 3 THEN ey(i) = ey(i) + 10: ef(i) = 0
2082 IF ex(i) < 10 THEN ex(i) = 10
2084 IF ex(i) > 310 THEN ex(i) = 310
2086 IF ey(i) < 10 THEN ey(i) = 10
2088 IF ey(i) > 150 THEN ey(i) = 150
2090 GOSUB 1000
2100 NEXT et
2110 eatu = 0
2490 NEXT i
2495 GOTO 470
2500 'they see me
2505 IF blind(i) > 0 THEN GOTO 2040
2510 IF ((SQR((ex(i) - mcx) ^ 2 + (ey(i) - mcy) ^ 2)) / 10) < 2 AND ex(i) = mcx THEN GOTO 3000
2512 IF ((SQR((ex(i) - mcx) ^ 2 + (ey(i) - mcy) ^ 2)) / 10) < 2 AND ey(i) = mcy THEN GOTO 3000
2520 IF mcx > ex(i) THEN ex(i) = ex(i) + 10: GOTO 2090
2530 IF mcx < ex(i) THEN ex(i) = ex(i) - 10: GOTO 2090
2540 IF mcy > ey(i) THEN ey(i) = ey(i) + 10: GOTO 2090
2550 IF mcy < ey(i) THEN ey(i) = ey(i) - 10: GOTO 2090
2560 PRINT CHR$(7); "2560"
2570 GOTO 2560
3000 'attack
3005 IF eag(i) > estr(i) THEN eatt$(i) = "eag" ELSE eatt$(i) = "estr"
IF em = 1 THEN GOTO 3013
3009 IF eatu = 1 THEN GOTO 3700
3012 IF em = et AND einte(i) > avg THEN GOTO 3700
3013 IF emp(i) > 2 AND einte(i) > 7 AND INT(RND(1) * 3) + 1 = 1 THEN espell$ = "zap": GOTO 4100
IF emp(i) > 4 AND einte(i) > 14 AND INT(RND(1) * 2) = 0 AND myblind = 0 THEN espell$ = "blind": GOTO 4100
3014 IF eatt$(i) = "estr" THEN GOTO 3500
3020 'jab
3021 LOCATE 23, 1: PRINT "the enemy attacks!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                    "
3022 eatu = 1
3030 IF ag > eag(i) * 3 THEN LOCATE 23, 1: PRINT "he missed!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "           ": GOTO 3090
3040 IF ag > eag(i) AND INT(RND * 6) + 1 = 6 THEN LOCATE 23, 1: PRINT "he missed!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "           ": GOTO 3090
3050 edam = INT(eag(i) / 3) + INT(RND * 3) + 1
3052 IF blo = 1 THEN edam = 1
3060 hp = hp - edam
3065 IF hp < 1 THEN GOTO 20000
3070 LOCATE 23, 1: PRINT "you lost "; edam; " points. hp="; hp: FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                   "
3090 IF cou = 0 THEN GOTO 4000
3100 dam = INT(ag / 4) + INT(RND * 2)
3105 LOCATE 23, 1: PRINT "You did "; dam; " counter damage."
3107 FOR tim = 1 TO 5000: NEXT tim
3108 LOCATE 23, 1: PRINT "                                 "
3110 ehp(i) = ehp(i) - dam
3120 IF ehp(i) < 1 THEN po = 3000: GOTO 9500
3130 GOTO 2090
3500 'punch
3505 eatu = 1
3510 LOCATE 23, 1: PRINT "the enemy attacks!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                    "
3530 IF ag > eag(i) * 3 THEN LOCATE 23, 1: PRINT "he missed!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "           ": GOTO 3590
3540 IF ag > eag(i) AND INT(RND * 6) + 1 = 6 THEN LOCATE 23, 1: PRINT "he missed!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "           ": GOTO 3590
3550 edam = INT(estr(i) / 3) + INT(RND * 3) + 1
3552 IF blo = 1 THEN edam = 1
3560 hp = hp - edam
3565 IF hp < 1 THEN GOTO 20000
3570 LOCATE 23, 1: PRINT "you lost "; edam; " points. hp="; hp
3580 FOR tim = 1 TO 5000: NEXT tim
3585 LOCATE 23, 1: PRINT "                                      "
3590 IF cou = 0 THEN GOTO 4000
3600 dam = INT(ag / 4) + INT(RND * 2)
3605 LOCATE 23, 1: PRINT "You did "; dam; " counter damage."
3607 FOR tim = 1 TO 5000: NEXT tim
3608 LOCATE 23, 1: PRINT "                                 "
3610 ehp(i) = ehp(i) - dam
3620 IF ehp(i) < 1 THEN : po = 3000: GOTO 9500
3630 GOTO 2090

3700 'block or counter
3710 IF eatt$(i) = "eag" THEN GOTO 3750
3720 eblo(i) = 1
3730 GOTO 2090
3750 ecou(i) = 1
3760 GOTO 2090
4000 GOTO 2090
4100 REM enemy magic
  SELECT CASE espell$
        CASE IS = "heal"
                emp(i) = emp - 3
                ehp(i) = ehp(i) + INT(RND(1) * 4) + 1
                LOCATE 23, 1: PRINT "The enemy heals himself.": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                            "
        CASE IS = "zap"
                emp(i) = emp(i) - 2
                edam = INT(RND(1) * 4) + 3
                LOCATE 23, 1: PRINT "The enemy casts zap on you!"
                FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "The enemy did "; edam; "damage!"
                FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                               "
                hp = hp - edam
                LOCATE 23, 1: PRINT "HP is now "; hp: FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                  "
                IF hp < 1 THEN GOTO 20000
        CASE IS = "blind"
                emp(i) = emp(i) - 5
                LOCATE 23, 1: PRINT "You are blinded by the enemy!": FOR tim = 1 TO 4000: NEXT tim
                myblind = 4
                GOSUB 1000
                LOCATE 23, 1: PRINT "                               "

  END SELECT
  GOTO 2100

5000 'attack or other
5005 IF g$ = "h" THEN GOTO 5090
5010 IF g$ = "j" THEN GOTO 5100
5020 IF g$ = "p" THEN GOTO 5200
5030 IF g$ = "k" THEN GOTO 5300
5040 IF g$ = "b" THEN GOTO 5400
5050 IF g$ = "c" THEN GOTO 5500
5060 IF g$ = "f" THEN GOTO 5600
5075 IF g$ = "s" THEN GOTO 7000
5080 GOTO 475
5090 LOCATE 23, 1: PRINT "hp="; hp; "     mp="; mp: FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                         ": GOTO 475
5100 'jab
5102 IF atu = 1 THEN LOCATE 23, 1: PRINT "You've already attacked": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                         ": GOTO 475
5110 LOCATE 23, 1: PRINT "Which enemy?": LOCATE 23, 15: INPUT j
5115 LOCATE 23, 1: PRINT "                           "
5120  IF ((SQR((ex(j) - mcx) ^ 2 + (ey(j) - mcy) ^ 2)) / 10) < 2 AND ex(j) = mcx THEN GOTO 5127
5122 IF ((SQR((ex(j) - mcx) ^ 2 + (ey(j) - mcy) ^ 2)) / 10) < 2 AND ey(j) = mcy THEN GOTO 5127
5125 LOCATE 23, 1: PRINT "you can't": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "         ": GOTO 470
5127 IF pro$ = "ninja" THEN atu = atu + .5 ELSE atu = 1
5130 IF ag * 3 < eag(j) THEN LOCATE 23, 1: PRINT "You missed!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "             ": GOTO 9000
5132 IF eag(j) > ag AND INT(RND * 6) + 1 = 6 THEN LOCATE 23, 1: PRINT "You missed!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "          ": GOTO 9000
5140 dam = INT(ag / 3) + INT(RND * 3) + 1
5145 IF eblo(j) = 1 THEN dam = 1
5147 IF eblo(j) = 1 THEN LOCATE 23, 1: PRINT "He blocked your attack!": FOR tim = 1 TO 5000: NEXT tim
5150 ehp(j) = ehp(j) - dam
5155 IF ehp(j) < 1 THEN po = 5000: GOTO 9500
5160 LOCATE 23, 1: PRINT "you did "; dam; " damage": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                        "
5170 IF ecou(j) = 0 THEN GOTO 5195
5175 edam = INT(eag(j) / 4) + INT(RND * 2)
5180 LOCATE 23, 1: PRINT "He countered your attack!": FOR tim = 1 TO 5000: NEXT tim
5185 LOCATE 23, 1: PRINT "He did "; edam; " damage. HP="; hp - edam
5187 FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                            "
5190 hp = hp - edam
5195 GOTO 9000
5200 'punch
5202 IF atu = 1 THEN LOCATE 23, 1: PRINT "You've already attacked": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                         ": GOTO 475
5210 LOCATE 23, 1: PRINT "Which enemy?": LOCATE 23, 15: INPUT j
5220 IF ((SQR((ex(j) - mcx) ^ 2 + (ey(j) - mcy) ^ 2)) / 10) < 2 AND ex(j) = mcx THEN GOTO 5227
5222 IF ((SQR((ex(j) - mcx) ^ 2 + (ey(j) - mcy) ^ 2)) / 10) < 2 AND ey(j) = mcy THEN GOTO 5227
5225 LOCATE 23, 1: PRINT "you can't": GOTO 470
5227 IF pro$ = "ninja" THEN atu = atu + .5 ELSE atu = 1
5230 IF ag * 3 < eag(j) THEN LOCATE 23, 1: PRINT "You missed!": GOTO 9000
5232 IF eag(j) > ag AND INT(RND * 6) + 1 = 6 THEN LOCATE 23, 1: PRINT "You missed!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "             ": GOTO 9000
5240 dam = INT(str / 3) + INT(RND * 3) + 1
5242 IF eblo(j) = 1 THEN LOCATE 23, 1: PRINT "He blocked your attack!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                              "
5244 IF eblo(j) = 1 THEN dam = 1
5250 ehp(j) = ehp(j) - dam
5260 IF ehp(j) < 1 THEN po = 5000: GOTO 9500
5270 LOCATE 23, 1: PRINT "You did "; dam; " damage": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                              "
5272 IF ecou(j) = 0 THEN GOTO 5295
5274 LOCATE 23, 1: PRINT "He countered your attack!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                               "
5277 edam = INT(eag(j) / 4) + INT(RND * 2)
5280 hp = hp - edam
5282 IF hp < 1 THEN GOTO 20000
5285 LOCATE 23, 1: PRINT "He did "; edam; " damage. HP="; hp: FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                              "
5295 GOTO 9000
5300 'kick
5302 IF atu = 1 THEN LOCATE 23, 1: PRINT "You've already attacked": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                         ": GOTO 475
5310 LOCATE 23, 1: PRINT "Which enemy?": LOCATE 23, 15: INPUT j
5320  IF ((SQR((ex(j) - mcx) ^ 2 + (ey(j) - mcy) ^ 2)) / 10) < 2 AND ex(j) = mcx THEN GOTO 5327
5324  IF ((SQR((ex(j) - mcx) ^ 2 + (ey(j) - mcy) ^ 2)) / 10) < 2 AND ey(j) = mcy THEN GOTO 5327
5325 LOCATE 23, 1: PRINT "you can't": GOTO 470
5327 IF pro$ = "ninja" THEN atu = atu + .5 ELSE atu = 1
5330 IF ag * 3 < eag(j) THEN LOCATE 23, 1: PRINT "You missed!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "             ": GOTO 9000
5332 IF eag(j) > ag AND INT(RND * 6) + 1 = 6 THEN LOCATE 23, 1: PRINT "You missed!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "             ": GOTO 9000
5340 dam = INT(((str + ag) / 2) / 4) + INT(RND * 6) + 1
5345 IF eblo(j) = 1 THEN dam = 1
5347 IF eblo(j) = 1 THEN LOCATE 23, 1: PRINT "He blocked!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "            "
5350 ehp(j) = ehp(j) - dam
5360 IF ehp(j) < 1 THEN po = 5000: GOTO 9500
5370 LOCATE 23, 1: PRINT "You did "; dam; " damage"
5372 FOR tim = 1 TO 5000: NEXT tim
5374 LOCATE 23, 1: PRINT "                        "
5380 GOTO 9000
5400 'block
5410 LOCATE 23, 1: PRINT "You prepare to block the attack"
5420 blo = 1
5430 FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                "
5440 GOTO 9000
5500 'counter
5510 LOCATE 23, 1: PRINT "You prepare to counter his attack"
5520 cou = 1
5525 FOR tim = 1 TO 5000: NEXT tim
5527 LOCATE 23, 1: PRINT "                                  "
5530 GOTO 9000
5600 'fatality
SELECT CASE pro$
        CASE IS = "thief"
                'poison
                IF inte < 6 THEN LOCATE 23, 1: PRINT "You are too dumb!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                             ": GOTO 475
                LOCATE 23, 1: PRINT "Which enemy?": LOCATE 23, 14: INPUT sptar
                IF NOT ((SQR((ex(sptar) - mcx) ^ 2 + (ey(sptar) - mcy) ^ 2)) / 10) < 2 THEN LOCATE 23, 1: PRINT "You can't!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "           ": GOTO 475
                IF ey(sptar) <> mcy THEN ps = ps + 1
                IF ex(sptar) <> mcx THEN ps = ps + 1
                IF ps <> 1 THEN LOCATE 23, 1: PRINT "You can't!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                  ": GOTO 475
                IF hide(sptar) <> 1 THEN LOCATE 23, 1: PRINT "You aren't hidden!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                      ": GOTO 475
                IF hc > 2 THEN LOCATE 23, 1: PRINT "You are no longer hidden!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                          ": GOTO 475
                poi(sptar) = 1
                poidam = inte / 3 - 1
                LOCATE 23, 1: PRINT "The enemy has been poisoned!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                   "
                GOTO 9000
        CASE IS = "magician"
                LOCATE 23, 1: PRINT "Magicians don't have a special!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                  ": GOTO 475
        CASE IS = "ninja"
                LOCATE 23, 1: PRINT "Ninjas don't have a special!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                 ": GOTO 475
        CASE IS = "warrior"
                cs = 0
                IF atu = 1 THEN LOCATE 23, 1: PRINT "You've already attacked!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                          ": GOTO 475
                IF str < 10 THEN LOCATE 23, 1: PRINT "You aren't strong enough!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                            ": GOTO 475
                LOCATE 23, 1: PRINT "Which enemy?": LOCATE 23, 15: INPUT crtar
                IF NOT ((SQR((ex(crtar) - mcx) ^ 2 + (ey(crtar) - mcy) ^ 2)) / 10) < 2 THEN LOCATE 23, 1: PRINT "You can't!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "           ": GOTO 475
                IF ey(crtar) <> mcy THEN cs = cs + 1
                IF ex(crtar) <> mcx THEN cs = cs + 1
                IF cs <> 1 THEN LOCATE 23, 1: PRINT "You can't!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "              ": GOTO 475
                LOCATE 23, 1: PRINT "You attempt to crush the enemy!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                  "
                atu = 1
                dam = INT(((str - estr(crtar)) / 10) * ehp(crtar))
                IF dam < 2 THEN dam = 2
                LOCATE 23, 1: PRINT "You did "; dam; " damage.": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                       "
                ehp(crtar) = ehp(crtar) - dam
                IF ehp(crtar) < 1 THEN j = crtar: GOTO 9500
        END SELECT
6990 GOTO 9000
7000 'spells
7020 LOCATE 23, 1: PRINT "Which spell? enter 1-10"
7022 DO
7024 g$ = INKEY$
7026 LOOP UNTIL g$ <> ""
7028 IF VAL(g$) < 1 OR VAL(g$) > 10 OR INT(VAL(g$)) <> VAL(g$) THEN GOTO 7020
7030 LOCATE 23, 1: PRINT "                              "
SELECT CASE g$
  CASE IS = "1"
     'zap
     bs = 0
     IF inte < 7 THEN LOCATE 23, 1: PRINT "You don't have high enough intelligence.": LOCATE 23, 1: INPUT nth$: GOTO 475
     IF mp < 2 THEN LOCATE 23, 1: PRINT "You don't have enough magic points left!": LOCATE 23, 1: INPUT nth$: GOTO 475
     LOCATE 23, 1: PRINT "Which enemy": LOCATE 23, 15: INPUT sptar
     IF sptar < 1 OR sptar > 4 OR sptar <> INT(sptar) THEN LOCATE 23, 1: INPUT "No such enemy!", nth$: GOTO 475
     IF NOT ((SQR((ex(sptar) - mcx) ^ 2 + (ey(sptar) - mcy) ^ 2)) / 10) < 2 THEN LOCATE 23, 1: PRINT "You can't!"
     IF ey(sptar) <> mcy THEN bs = bs + 1
     IF ex(sptar) <> mcx THEN bs = bs + 1
     IF bs = 2 THEN LOCATE 23, 1: PRINT "You can't!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "           ": GOTO 475
     dam = INT(RND(1) * 4) + 3
     mp = mp - 2
     ehp(sptar) = ehp(sptar) - dam
     LOCATE 23, 1: PRINT "You did "; dam; " damage to the enemy": FOR tim = 1 TO 5000: NEXT tim:
     IF ehp(sptar) < 1 THEN po = 7000: GOTO 9500
  CASE IS = "2"
     'heal
     IF inte < 10 THEN : LOCATE 23, 1: PRINT "You don't have high enough inteligence!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                        ": GOTO 475
     IF mp < 3 THEN : LOCATE 23, 1: PRINT "You don't have enough magic points.": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                    ": GOTO 475
     mp = mp - 3
     helpo = 3 + INT(RND(1) * 3)
     hp = hp + helpo
     IF hp > stam * 2 THEN hp = stam * 2
     LOCATE 23, 1: PRINT "You received "; helpo; "points.  HP is now "; hp
     FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                                   "
  CASE IS = "3"
     'check
     IF NOT pro$ = "magician" THEN LOCATE 23, 1: PRINT "You are not a magician!": FOR tim = 1 TO 5000: NEXT tim: PRINT "                                     ": GOTO 475
     IF inte < 13 THEN : LOCATE 23, 1: PRINT "You don't have high enough inteligence!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                        ": GOTO 475
     IF mp < 3 THEN : LOCATE 23, 1: PRINT "You don't have enough magic points.": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                    ": GOTO 475
     mp = mp - 3
     LOCATE 23, 1: PRINT "Check which enemy?"
     LOCATE 23, 20: INPUT star
     IF star < 1 OR star > 4 OR INT(star) <> star THEN GOTO 475
     j = star
     LINE (ex(j) + 4, ey(j) + 1)-(ex(j) + 4, ey(j) + 5), 1
     LINE (ex(j) + 3, ey(j) + 1)-(ex(j) + 5, ey(j) + 1), 1
     LINE (ex(j) + 3, ey(j) + 3)-(ex(j) + 3, ey(j) + 8), 1
     LINE (ex(j) + 5, ey(j) + 3)-(ex(j) + 5, ey(j) + 5), 1
     LINE (ex(j) + 6, ey(j) + 3)-(ex(j) + 7, ey(j) + 3), 1
     LINE (ex(j) + 6, ey(j) + 6)-(ex(j) + 6, ey(j) + 8), 1
     LINE (ex(j) + 8, ey(j) + 1)-(ex(j) + 8, ey(j) + 2), 1

     SELECT CASE j
        CASE IS = 1
                LINE (ex(j) + 5, ey(j) + 10)-(ex(j) + 5, ey(j) + 16), 1
        CASE IS = 2
                LINE (ex(j) + 3, ey(j) + 10)-(ex(j) + 6, ey(j) + 10), 1
                LINE (ex(j) + 6, ey(j) + 11)-(ex(j) + 6, ey(j) + 13), 1
                LINE (ex(j) + 6, ey(j) + 13)-(ex(j) + 3, ey(j) + 16), 1
                LINE (ex(j) + 3, ey(j) + 16)-(ex(j) + 6, ey(j) + 16), 1
        CASE IS = 3
                LINE (ex(j) + 3, ey(j) + 10)-(ex(j) + 6, ey(j) + 10), 1
                LINE (ex(j) + 6, ey(j) + 11)-(ex(j) + 6, ey(j) + 16), 1
                LINE (ex(j) + 3, ey(j) + 16)-(ex(j) + 6, ey(j) + 16), 1
                LINE (ex(j) + 3, ey(j) + 13)-(ex(j) + 6, ey(j) + 13), 1
        CASE IS = 4
                LINE (ex(j) + 3, ey(j) + 10)-(ex(j) + 3, ey(j) + 13), 1
                LINE (ex(j) + 3, ey(j) + 13)-(ex(j) + 7, ey(j) + 13), 1
                LINE (ex(j) + 6, ey(j) + 10)-(ex(j) + 6, ey(j) + 16), 1
        END SELECT
        LOCATE 23, 1: PRINT "The enemy's stamina is "; estam(j): LOCATE 23, 29: INPUT nth$
        LOCATE 23, 1: PRINT "The enemy's agility is "; eag(j): LOCATE 23, 29: INPUT nth$
        LOCATE 23, 1: PRINT "The enemy's intelligence is "; einte(j): LOCATE 23, 32: INPUT nth$
        LOCATE 23, 1: PRINT "The enemy's strength is "; estr(j): LOCATE 23, 24: INPUT nth$
        LOCATE 23, 1: PRINT "The enemy's speed is "; espe(j): LOCATE 23, 24: INPUT nth$
        LOCATE 23, 1: PRINT "The enemy's perception is "; eper(j): LOCATE 23, 29: INPUT nth$
        LOCATE 23, 1: PRINT "The enemy's stealth is "; este(j): LOCATE 23, 23: INPUT nth$
      
    CASE IS = "4"
        'blind-3 turns
        IF NOT pro$ = "magician" THEN LOCATE 23, 1: PRINT "You are not a magician!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                 ": GOTO 475
        IF inte < 15 THEN LOCATE 23, 1: PRINT "You don't have high enough intelligence!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                                                ": GOTO 475
        IF mp < 5 THEN LOCATE 23, 1: PRINT "You don't have enough mp.": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                              ": GOTO 475
        IF si(j) = 0 THEN LOCATE 23, 1: PRINT "You can't see that enemy!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                    "
        LOCATE 23, 1: PRINT "Which enemy": LOCATE 23, 13: INPUT sptar
        IF sptar < 1 OR sptar > 4 OR sptar <> INT(sptar) THEN LOCATE 23, 1: PRINT "Nope.": GOTO 475
        mp = mp - 5
        blind(sptar) = 4
        LOCATE 23, 1: PRINT "The enemy has been blinded!": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                                   "

        
        END SELECT


8900
8902 LOCATE 23, 1: PRINT "                                 "
9000 GOTO 690 'my next move
9500 'enemy dies
9510 LOCATE 23, 1: PRINT "the enemy has given up": FOR tim = 1 TO 5000: NEXT tim: LOCATE 23, 1: PRINT "                        "
9515 IF po = 3000 THEN ek(i) = 1: FOR x = 1 TO 10: FOR y = 1 TO 10: PRESET (ex(i) + x, ey(i) + y): NEXT y: NEXT x: GOTO 9575
9518 IF po = 7000 THEN j = sptar
9519 IF po = 2000 THEN j = i
9520 ek(j) = 1
9525 IF ek(1) = 1 AND ek(2) = 1 AND ek(3) = 1 AND ek(4) = 1 THEN GOTO 15000
9530 FOR x = 1 TO 10
9540 FOR y = 1 TO 20
9550 PRESET (ex(j) + x, ey(j) + y)
9560 NEXT y
9570 NEXT x
9575 IF po = 3000 THEN cou = 0: GOTO 2490
9580 GOTO 9000
15000 'I win
15010 SCREEN 0
15020 PRINT "You have won the battle! You recieve 4 points to add to one of your attributes."
15015 FOR ti = 1 TO 4
15030 PRINT "Place a point on the area you want to improve - stamina,strength,agility,speed,perception,stealth,or intelligence. Please enter the first 3 letters of the area you want to improve."
15040 INPUT ic$
15050 IF ic$ = "sta" THEN stam = stam + 1: PRINT "Stamina is now "; stam: GOTO 15200
15060 IF ic$ = "str" THEN str = str + 1: PRINT "Strength is now "; str: GOTO 15200
15070 IF ic$ = "agi" THEN ag = ag + 1: PRINT "Agility is now "; ag: GOTO 15200
15080 IF ic$ = "spe" THEN spe = spe + 1: PRINT "Speed is now "; spe: GOTO 15200
15090 IF ic$ = "per" THEN per = per + 1: PRINT "Perception is now "; per: GOTO 15200
15100 IF ic$ = "ste" THEN ste = ste + 1: PRINT "Stealth is now "; ste: GOTO 15200
15110 IF ic$ = "int" THEN inte = inte + 1: PRINT "Intelligence is now "; inte: GOTO 15200
15120 GOTO 15030
15200 NEXT ti
file$ = "./save/arena/save/" + name$
15210 OPEN file$ FOR OUTPUT AS #1
15230 PRINT #1, pro$
15235 PRINT #1, stam, ag, inte, str, spe, per, ste
15240 CLOSE #1
15250 PRINT "Your status has now been saved."
15300 PRINT "Very well, back to the Arena with you."
15301 INPUT nothing$
15310 FOR i = 1 TO 4
15320 ek(i) = 0
15350 NEXT i
15360 l = 0
15370 u = 0

15400 GOTO 50
20000 'I die
20010 LOCATE 23, 1: PRINT "You have been defeated by the enemy."



