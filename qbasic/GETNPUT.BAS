CLS
    DIM remember(1 TO 5000)
    SCREEN 12
    CIRCLE (100, 100), 10, 12
    SLEEP 3
    FOR i = 50 TO 200
    ERASE remember
    GET (i, 50)-(i + 100, 150), remember
    PUT (i + 1, 50), remember(1), PSET
    NEXT i

