

PRINT "Would you like to s-start a new game or r-restore an old one?"
INPUT sr$
IF sr$ = "s" THEN GOTO 1
IF sr$ = "r" THEN GOTO 2900
1 CLS 0

PRINT "Welcome to War, you must now define your character.  You have 18 points to put on 3 different attribute areas.  These areas are endurance (endu), which is how hardy and durable you are, strength (str), which is how strong you are,"
PRINT "and agility (ag) which is how fast and quick-acting you are.  Now choose and choose wisely."
2 PRINT "type your endurance"
INPUT endu
IF endu < 1 OR endu > 16 THEN GOTO 2
hp = 8 * endu
3 PRINT "type your strength"
INPUT str
IF str < 1 OR str > 16 THEN GOTO 3
4 PRINT "type your ag"
INPUT ag
IF ag < 1 OR ag > 16 THEN GOTO 4
exn = 20
ex = 0
gold = 5
5 IF endu + str + ag = 18 THEN GOTO 7 ELSE GOTO 6
6 PRINT "Incorrect numbers, you put on too many points, or didn't put on enough, try again."
GOTO 2
7 PRINT "Character defined"
exn = 10
8 CLS
PRINT "You have"; gold; "gold, "; ex; "experience points, and"; hp; "hit points."
9 PRINT "Do you want to go into town or adventure more?"
10 INPUT ta$
IF ta$ = "t" GOTO 11
IF ta$ = "a" GOTO 40
GOTO 9
11
IF ex > exn THEN GOTO 12 ELSE GOTO 15
12 exn = exn + 30
endu = endu + (INT(RND * 2) + 1)
str = str + (INT(RND * 2) + 1)
ag = ag + (INT(RND * 2) + 1)

PRINT "You are now on the next level, endurance is now"; endu; ",str is now"; str; ",agility is now"; ag; "."
GOTO 11
15 PRINT "do you want to b- buy weapons or armor, i-go to the inn, l-leave town, e-try to defeat the end enemy, or q-quit?"
INPUT bi$
IF bi$ = "b" THEN GOTO 17
IF bi$ = "i" THEN GOTO 35
IF bi$ = "l" THEN GOTO 40
IF bi$ = "q" THEN GOTO 2800
IF bi$ = "e" THEN GOTO 3500
17 PRINT "You can buy d-a dagger for 20 gold, s-a sword for 40 gold, b-a battleaxe for 60 gold, a-armor for 50 gold, h-a helmet for 20 gold, or l-leave the store.  You have "; gold; "gold."
INPUT dsb$
IF dsb$ = "d" THEN GOTO 19
IF dsb$ = "s" THEN GOTO 21
IF dsb$ = "b" THEN GOTO 23
IF dsb$ = "a" THEN GOTO 25
IF dsb$ = "h" THEN GOTO 27
IF dsb$ = "l" THEN GOTO 15
19 IF gold >= 20 THEN str = str + 6 ELSE GOTO 30
PRINT "You buy a good fighting dagger."
gold = gold - 20
GOTO 17
21 IF gold >= 40 THEN str = str + 12 ELSE GOTO 30
PRINT "You buy a sword"
gold = gold - 40
GOTO 17
23 IF gold >= 60 THEN str = str + 25 ELSE GOTO 30
PRINT "You buy an excellant battleaxe."
gold = gold - 60
GOTO 17
25 IF gold >= 50 THEN endu = endu + 5 ELSE GOTO 30
PRINT "You buy a quality suit of armor."
gold = gold - 50
GOTO 17
27 IF gold >= 20 THEN endu = endu + 2 ELSE GOTO 30
PRINT "You buy some cheap protection in the form of a helmet."
gold = gold - 20
GOTO 17
30 PRINT "Oops, you don't have enough money.  Buy something else."
GOTO 17
35 IF gold < 5 THEN GOTO 36 ELSE gold = gold - 5
hp = endu * 8
PRINT "You go to the inn and feel refreshed after resting there.  Your hp is now"; hp
GOTO 15
36 PRINT "You find that you don't have enough gold to pay for a night at the inn."
GOTO 15
40 d% = INT(RND * 20) + 1
IF d% = 1 THEN GOTO 50
IF d% = 2 THEN GOTO 150
IF d% = 3 THEN GOTO 250
IF d% = 4 THEN GOTO 350
IF d% = 5 THEN GOTO 450
IF d% = 6 THEN GOTO 550
IF d% = 7 THEN GOTO 650
IF d% = 8 THEN GOTO 750
IF d% = 9 THEN GOTO 850
IF d% = 10 THEN GOTO 950
IF d% = 11 THEN GOTO 1050
IF d% = 12 THEN GOTO 1150
IF d% = 13 THEN GOTO 1250
IF d% = 14 THEN GOTO 1350
IF d% = 15 THEN GOTO 1450
IF d% = 16 THEN GOTO 1550
IF d% = 17 THEN GOTO 1650
IF d% = 18 THEN GOTO 1750
IF d% = 19 THEN GOTO 1850
IF d% = 20 THEN GOTO 1950
50 name$ = "orc"
estr = 3
eag = 3
ehp = 15
eex = 1
eg = 1
GOTO 2550
150 name$ = "goblin"
estr = 5
eag = 5
ehp = 20
eex = 2
eg = 2
GOTO 2550
250 name$ = "thief"
estr = 2
eag = 7
ehp = 16
eex = 2
eg = 5
GOTO 2550
350 name$ = "brigand"
estr = 6
eag = 6
ehp = 25
eex = 3
eg = 3
GOTO 2550
450 name$ = "ogre"
estr = 12
eag = 3
ehp = 35
eex = 5
eg = 5
GOTO 2550
550 name$ = "wolf"
estr = 6
eag = 6
ehp = 30
eex = 6
eg = 0
GOTO 2550
650 name$ = "zombie"
estr = 3
eag = 3
ehp = 65
eex = 5
eg = 1
GOTO 2550
750 name$ = "scorpion"
estr = 3
eag = 8
ehp = 25
eex = 5
eg = 0
GOTO 2550
850 name$ = "bandit"
estr = 4
eag = 7
ehp = 40
eex = 4
eg = 10
GOTO 2550
950  name$ = "black soldier"
estr = 7
eag = 7
ehp = 56
eex = 5
eg = 5
GOTO 2550
1050 name$ = "kobold"
estr = 4
eag = 7
ehp = 20
eex = 2
eg = 3
GOTO 2550
1150 name$ = "gnome"
estr = 5
eag = 5
ehp = 25
eex = 2
eg = 3
GOTO 2550
1250 name$ = "wyvern"
estr = 10
eag = 10
ehp = 70
eex = 8
eg = 8
GOTO 2550
1350 name$ = "ghoul"
estr = 5
eag = 1
ehp = 100
eex = 6
eg = 1
GOTO 2550
1450 name$ = "rogue"
estr = 7
eag = 7
ehp = 35
eex = 4
eg = 5
GOTO 2550
1550 name$ = "assasin"
estr = 1
eag = 12
ehp = 30
eex = 6
eg = 6
GOTO 2550
1650 name$ = "troll"
estr = 15
eag = 2
ehp = 50
eex = 10
eg = 10
GOTO 2550
1750 name$ = "giant"
estr = 15
eag = 2
ehp = 50
eex = 10
eg = 10
GOTO 2550
1850 name$ = "griffin"
estr = 8
eag = 8
ehp = 45
eex = 7
eg = 0
GOTO 2550
1950 name$ = "panther"
estr = 5
eag = 10
ehp = 30
eex = 6
eg = 0
GOTO 2550
2550 PRINT "You were wandering around the countryside when a "; name$; " approaches you!"
2554 IF ag >= eag THEN GOTO 2555 ELSE GOTO 2600
2555 PRINT "It is your turn, what would you like to do, attack or run?"
INPUT a$
IF a$ = "r" THEN GOTO 2565
IF a$ = "a" THEN GOTO 2570
GOTO 2555
2565 IF ag + INT((RND * 6) + 1) <= eag + INT((RND * 6) + 1) THEN GOTO 2567 ELSE GOTO 2566
2566 PRINT "You run away."
PRINT "Press enter to continue"
INPUT nonsense
GOTO 8
2567 PRINT "You cannot escape from the "; name$; ".  It attacks."
m = INT(RND * ag) + 1
IF m > .9 * ag THEN GOTO 2568
dam = estr + (INT(RND * 6) + 1)
hp = hp - dam
PRINT "Your hit points are now"; hp; "."
IF hp < 1 THEN GOTO 100000
2568 PRINT "You manage to dodge the monster's attack."
GOTO 2554
2569
2570 PRINT "You attack the "; name$; "."
IF ag > eag THEN GOTO 2572 ELSE GOTO 2575
2572 diff = INT(ag - eag)
GOTO 2576
2575 diff = 1
m = INT(RND * eag) + 1
IF m > .9 * eag THEN GOTO 2577
2576 edam = (2 * str + (INT(RND * 6) + 1) * diff)
ehp = ehp - edam
PRINT "You do"; edam; "points of damage.  The "; name$; " hp is now"; ehp; "."
IF ehp < 1 THEN GOTO 2645
GOTO 2578
2577 PRINT "The monster deftly dodges your attack."
2578 PRINT "The "; name$; " attacks."
m = INT(RND * ag) + 1
IF m > .9 * ag THEN GOTO 2585
dam = estr + (INT(RND * 6) + 1)
hp = hp - dam
PRINT "Your hit points are now"; hp
IF hp < 1 THEN GOTO 100000
GOTO 2554
2580 PRINT "The monster deftly dodges your attack."
GOTO 2554
2585 PRINT "You manage to dodge the monster's attack."
GOTO 2554

2600 PRINT "The "; name$; " attacks."
m = INT(RND * ag) + 1
IF m > .9 * ag THEN GOTO 2604
dam = estr + (INT(RND * 6) + 1)
hp = hp - dam
PRINT "Your hit points are now"; hp
IF hp < 1 THEN GOTO 100000
GOTO 2605
2604 PRINT "You manage to dodge the monster's attack."
2605 PRINT "Would you like to attack or run?"
INPUT vw$
IF vw$ = "a" THEN GOTO 2610
IF vw$ = "r" THEN GOTO 2630
GOTO 2605
2610 PRINT "You attack the "; name$; "."
IF ag > eag THEN GOTO 2612 ELSE GOTO 2615
2612 diff = INT(ag - eag)
GOTO 2616
2615 diff = 1
m = INT(RND * eag) + 1
IF m > .9 * eag THEN GOTO 2618
2616 edam = (2 * str + (INT(RND * 6) + 1) * diff)
ehp = ehp - edam
PRINT "You do"; edam; "points of damage.  The "; name$; " hp is now"; ehp
IF ehp < 1 THEN GOTO 2645
GOTO 2554
2618 PRINT "The monster deftly dodges your attack."
GOTO 2554
2630 IF ag + (INT(RND * 6) + 1) <= eag + (INT(RND * 6) + 1) THEN GOTO 2632 ELSE GOTO 2631

2631 PRINT "You run away."
PRINT "Press enter to continue"
INPUT nonsense
GOTO 8
2632 PRINT "You can't escape from the monster."
GOTO 2554
2645 PRINT "The "; name$; " is dead.  You gain "; eex; " experience and "; eg; " gold"
ex = ex + eex
gold = gold + eg
PRINT "Press enter to continue"
INPUT nonsense
CLS 0
GOTO 8
2800 pstr = (str + 19) ^ 2
pag = (str + 19) ^ 2
pendu = (endu + 19) ^ 2
pgold = (gold + 19) ^ 2
pex = (ex + 19) ^ 2
php = (hp + 19) ^ 2
PRINT "A is"; pstr
PRINT "B is"; pag
PRINT "C is"; pendu
PRINT "D is"; pgold
PRINT "E is"; pex
PRINT "F is"; php
PRINT "G is"; INT(RND * 2000)
GOTO 100001
2900 PRINT "You must now enter your password."
PRINT "Enter A."
INPUT pstr
PRINT "Enter B."
INPUT pag
PRINT "Enter C."
INPUT pendu
PRINT "Enter D."
INPUT pgold
PRINT "Enter E."
INPUT pex
PRINT "Enter F."
INPUT php
PRINT "Enter G."
INPUT nonsense
str = SQR(pstr) - 19
ag = SQR(pag) - 19
endu = SQR(pendu) - 19
gold = SQR(pgold) - 19
ex = SQR(pex) - 19
hp = endu * 8
2920 IF str = INT(str) THEN GOTO 2950 ELSE GOTO 2921
2921 IF ag = INT(ag) THEN GOTO 2950 ELSE GOTO 2922
2922 IF endu = INT(endu) THEN GOTO 2950 ELSE GOTO 2923
2923 IF gold = INT(gold) THEN GOTO 2950 ELSE GOTO 2924
2924 IF ex = INT(ex) THEN GOTO 2950 ELSE GOTO 8
2950 PRINT "Incorrect password, try again."
GOTO 2900
3000 PRINT "You are now dead."
3001 PRINT "Bye!"
3002 END

3003
3004
3005
3006
3007
3008
3009
3500 PRINT "So you think you are good enough to defeat the firegiant, eh.  Well we will see about that.  You go to the cave of the firegiant and challenge him.  The fight begins."
name$ = "firegiant"
estr = 20
eag = 20
ehp = 200
eexp = 15
eg = 50
3550 att = INT(RND * 20) + 1
IF att = 20 GOTO 3800
IF att = 10 GOTO 3700
3600 IF ag > eag THEN GOTO 3650
PRINT "The Firegiant slashes at you with his sword!"
IF ag / 2 > eag THEN GOTO 3630
dam = estr + (INT(RND * 6) + 1)
hp = hp - dam
IF hp <= 0 THEN GOTO 100000
PRINT "You have been hit.  Your hp is now"; hp; ".  What would you like to do? a-attack, r-run."
INPUT idi$
IF idi$ = "r" GOTO 3645
3605 PRINT "You attack the enemy scum with all your might."
IF eag / 2 > ag THEN GOTO 3635
edam = str + (INT(RND * 6) + 1)
ehp = ehp - edam
IF ehp <= 0 THEN GOTO 3900
PRINT "You did"; edam; "damage. Enemy hp is now"; ehp; "."
GOTO 3550
3630 PRINT "Your finely honed reflexes saw the blow coming and you nimbly dodged it."
GOTO 3605
3635 PRINT "The monster is too fast for you! He quickly avoids your attack."
GOTO 3550
3645 PRINT "You attempt to run, but as you turn the firegiant thrusts his sword through your back.  No armor could help that."
GOTO 100000
3650 PRINT "What would you like to do? a-attack, r-run."
INPUT gtr$
IF gtr$ = "r" GOTO 3645
3655 PRINT "You attack the enemy scum with all your might."
IF eag / 2 > ag THEN GOTO 3685
edam = str + (INT(RND * 6) + 1)
ehp = ehp - edam
IF ehp <= 0 THEN GOTO 3900
PRINT "You did"; edam; "damage. Enemy hp is now"; ehp; "."
3665 PRINT "The Firegiant slashes at you with his sword!"
IF ag / 2 > eag THEN GOTO 3680
dam = estr + (INT(RND * 6) + 1)
hp = hp - dam
IF hp <= 0 THEN GOTO 100000
PRINT "You have been hit.  Your hp is now"; hp; "."
GOTO 3550
3680 PRINT "You quickly dodge his thrust."
GOTO 3550
3685 PRINT "The monster deftly dodges your deadly blow."
GOTO 3665
3700 PRINT "The monster suddenly drops his sword and uh-oh this could be bad-breathes fire at you!"
dam = INT(RND * 50) + 1
hp = hp - dam
IF hp <= 0 THEN GOTO 3750 ELSE GOTO 3550
3750 PRINT "You have been burned to death.  At least this giant is civilized enough that he cooks his food before he eats it!"
GOTO 100000
3800 PRINT "The firegiant reaches behind his back, and pulls a flaming dart out of his belt! He flings it at you."
dar = INT(RND * 10) + 1
IF dar = 6 THEN GOTO 3850
PRINT "The giant was a little off in his aim.  The dart whizzed by your ear.  That was close!"
GOTO 3550
3850 PRINT "The dart strikes you.  Suddenly, you feel a hot sensation that starts to spread throughout your body.  Within a few minutes, you are dead.  That was a poisoned dart."
GOTO 100000
3900 PRINT "You have defeated the firegiant!"
3901 hi = 1
3902 PRINT "You are the supreme warrior! You have saved the kingdom!"
3903 hi = hi + 1
3904 IF hi < 200 THEN GOTO 3902
3905 END

8008 PRINT "You have"; gold; "gold, "; ex; "experience points, and"; hp; "hit points."
4009 PRINT "Do you want to go into town or adventure more?"
4010 INPUT ta$
IF ta$ = "t" GOTO 4011
IF ta$ = "a" GOTO 4040
GOTO 4009
4011 IF ex > 9 THEN GOTO 4012 ELSE GOTO 4015
4012 endu = endu + (INT(RND * 2) + 1)
str = str + (INT(RND * 2) + 1)
ag = ag + (INT(RND * 2) + 1)
ex = ex - 10
PRINT "You are now on the next level, endurance is now"; endu; ",str is now"; str; ",agility is now"; ag; "."
GOTO 4011
4015 PRINT "do you want to b- buy weapons or armor, i-go to the inn, l-leave town, or q-quit?"
INPUT bi$
IF bi$ = "b" THEN GOTO 4017
IF bi$ = "i" THEN GOTO 4035
IF bi$ = "l" THEN GOTO 4040
IF bi$ = "q" THEN GOTO 100001
GOTO 4015
4017 PRINT "You can buy d-a dagger for 20 gold, s-a sword for 40 gold, b-a battleaxe for 60 gold, a-armor for 50 gold, h-a helmet for 20 gold, or l-leave the store.  You have "; gold; "gold."
INPUT dsb$
IF dsb$ = "d" THEN GOTO 4019
IF dsb$ = "s" THEN GOTO 4021
IF dsb$ = "b" THEN GOTO 4023
IF dsb$ = "a" THEN GOTO 4025
IF dsb$ = "h" THEN GOTO 4027
IF dsb$ = "l" THEN GOTO 4015
4019 IF gold >= 20 THEN str = str + 6 ELSE GOTO 4030
PRINT "You buy a good fighting dagger."
gold = gold - 20
GOTO 4017
4021 IF gold >= 40 THEN str = str + 12 ELSE GOTO 4030
PRINT "You buy a sword"
gold = gold - 40
GOTO 4017
4023 IF gold >= 60 THEN str = str + 25 ELSE GOTO 4030
PRINT "You buy an excellant battleaxe."
gold = gold - 60
GOTO 4017
4025 IF gold >= 50 THEN endu = endu + 5 ELSE GOTO 4030
PRINT "You buy a quality suit of armor."
gold = gold - 50
GOTO 4017
4027 IF gold >= 20 THEN endu = endu + 2 ELSE GOTO 4030
PRINT "You buy some cheap protection in the form of a helmet."
gold = gold - 20
GOTO 4017
4030 PRINT "Oops, you don't have enough money.  Buy something else."
GOTO 4017
4035 IF gold < 5 THEN GOTO 4036 ELSE gold = gold - 5
hp = endu * 8
PRINT "You go to the inn and feel refreshed after resting there.  Your hp is now"; hp
GOTO 4015
4036 PRINT "You find that you don't have enough gold to pay for a night at the inn."
GOTO 4015
4040 d% = INT(RND * 20) + 1
100000 PRINT "You are dead."
100001 PRINT "bye"

