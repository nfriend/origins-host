CLS
top:

time = 10100
eagi = 12

FOR i = 10 TO 18
LOCATE i, 25
COLOR 9
PRINT STRING$(10, CHR$(219))
NEXT i

FOR i = 10 TO 18
LOCATE i, 44
COLOR 12
PRINT STRING$(10, CHR$(219))
NEXT i

DO UNTIL y$ = "j"
        y$ = INKEY$
                IF y$ = "a" OR y$ = "A" THEN
                        FOR u = 43 TO 35 STEP -1
                        LOCATE 16, u
                        COLOR 12
                        PRINT CHR$(219)
                        RANDOMIZE TIMER
                        e = INT(RND * 20) + 1
                        IF e <= eagi THEN
                       
                                COLOR 9
                                LOCATE 14, 35
                                PRINT CHR$(219)
                                FOR i = 14 TO 18
                                LOCATE i, 36
                                PRINT CHR$(219)
                                NEXT i

                        END IF
                       
                                COLOR 0
                                LOCATE 14, 35
                                PRINT CHR$(219)
                                FOR i = 14 TO 18
                                LOCATE i, 36
                                PRINT CHR$(219)
                                NEXT i
                       
                       
                       
                        FOR i = 1 TO time
                        NEXT i
                        NEXT u

                        FOR u = 35 TO 43
                        LOCATE 16, u
                        COLOR 0
                        PRINT CHR$(219)
                        FOR i = 1 TO time
                        NEXT i
                        NEXT u
        END IF
IF y$ = "q" THEN
                FOR u = 44 TO 35 STEP -1
                LOCATE 12, u
                COLOR 12
                PRINT CHR$(219)
                FOR i = 1 TO time
                NEXT i
                NEXT u

                FOR u = 35 TO 43
                LOCATE 12, u
                COLOR 0
                PRINT CHR$(219)
                FOR i = 1 TO time
                NEXT i
                NEXT u

END IF
IF y$ = "l" THEN
                FOR u = 35 TO 43
                LOCATE 16, u
                COLOR 9
                PRINT CHR$(219)
                FOR i = 1 TO time
                NEXT i
                NEXT u

                FOR u = 43 TO 35 STEP -1
                LOCATE 16, u
                COLOR 0
                PRINT CHR$(219)
                FOR i = 1 TO time
                NEXT i
                NEXT u
END IF
IF y$ = "o" THEN
                FOR u = 35 TO 43
                LOCATE 12, u
                COLOR 9
                PRINT CHR$(219)
                FOR i = 1 TO time
                NEXT i
                NEXT u

                FOR u = 43 TO 35 STEP -1
                LOCATE 12, u
                COLOR 0
                PRINT CHR$(219)
                FOR i = 1 TO time
                NEXT i
                NEXT u

 END IF



        IF y$ = "1" THEN

                COLOR 9
                LOCATE 14, 35
                PRINT CHR$(219)
                FOR i = 14 TO 18
                LOCATE i, 36
                PRINT CHR$(219)
                NEXT i

                SLEEP 1
                COLOR 0
                LOCATE 14, 35
                PRINT CHR$(219)
                FOR i = 14 TO 18
                LOCATE i, 36
                PRINT CHR$(219)
                NEXT i


        END IF

        IF y$ = "7" THEN
                COLOR 9
                LOCATE 14, 35
                PRINT CHR$(219)
                FOR i = 14 TO 10 STEP -1
                LOCATE i, 36
                PRINT CHR$(219)
                NEXT i
                SLEEP 1
                COLOR 0
                LOCATE 14, 35
                PRINT CHR$(219)
                FOR t = 10 TO 14
                LOCATE t, 36
                PRINT CHR$(219)
                NEXT t
        END IF

        IF y$ = "2" THEN
                COLOR 12
                FOR i = 18 TO 14 STEP -1
                LOCATE i, 42
                PRINT CHR$(219)
                NEXT i
                COLOR 12
                LOCATE 14, 43
                PRINT CHR$(219)
               
                SLEEP 1
               
                COLOR 0
                LOCATE 14, 43
                PRINT CHR$(219)
                FOR i = 14 TO 18
                LOCATE i, 42
                PRINT CHR$(219)
                NEXT i
                SLEEP 1
END IF


IF y$ = "8" THEN
LOCATE 14, 43
COLOR 12
PRINT CHR$(219)

FOR i = 14 TO 10 STEP -1
LOCATE i, 42
PRINT CHR$(219)
NEXT i
SLEEP 1
COLOR 0
LOCATE 14, 43
PRINT CHR$(219)
FOR i = 14 TO 10 STEP -1
LOCATE i, 42
PRINT CHR$(219)
NEXT i
END IF
LOOP

