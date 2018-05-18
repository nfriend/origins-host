'
' BaCon BASIC-to-C converter --= BACON =--
'
' Peter van Eerten - March 2009/January 2010. License: GPL version 3.
'
' Global variables should be preceded with a 'g_'.
'
'----------------------------------------------------------------------------------------------
' CREDITS:
'   - James C. Fuller for endless testing and patiently pointing to many issues
'   - John Spikowksi for providing the forum and giving some hints to improve the language
'
'----------------------------------------------------------------------------------------------
'
' Though BaCon is much more powerful than KSH or BASH, this program follows the same structure
' and approach as the existing shell script implementations where possible.
'
' The reason for this is maintainability and consistency: a bug should show up in all versions
' and should be solved in all versions.
'
'----------------------------------------------------------------------------------------------
' GLOBAL INITIALIZATIONS
'----------------------------------------------------------------------------------------------

TRAP LOCAL

' Make sure GCC uses English localization
SETENVIRON "LANG", "C"

' Version of BACON
g_VERSION$ = "1.0.2"

' Link flags
IF INSTR(OS$, "OSF1") OR INSTR(OS$, "BSD") THEN
    g_LDFLAGS$ = "-lm"
ELSE
    g_LDFLAGS$ = "-lm -ldl"
END IF

'----------------------------------------------------------------------------------------------

FUNCTION Check_Declared(STRING filename, STRING v$)

    LOCAL txt$, needle$
    LOCAL expr = 0
    LOCAL thefile TYPE FILE*

    needle$ = REPLACE$(v$, "*", "\\*")
    needle$ = REPLACE$(needle$, "$", "\\$")

    OPEN filename FOR READING AS thefile

    WHILE NOT(ENDFILE(thefile)) DO

        READLN txt$ FROM thefile
        IF NOT(ENDFILE(thefile)) AND LEN(txt$) > 0 THEN
            expr = REGEX(txt$, "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING")
	    IF ISTRUE(expr) THEN
		IF INSTR(needle$, "[") THEN
		    expr = REGEX(txt$, CONCAT$(" ", LEFT$(needle$, INSTR(needle$, "[")-1), "\\[|,", LEFT$(needle$, INSTR(needle$, "[")-1)))
		ELSE
		    expr = REGEX(txt$, CONCAT$(" ", needle$, ",| ", needle$, ";|,", needle$, ",|,", needle$, ";"))
		END IF
		IF ISTRUE(expr) THEN
		    expr = NOT(REGEX(txt$, "/\\*record\\*/"))
		    BREAK
		END IF

	    ENDIF
        ENDIF
    WEND

    CLOSE FILE thefile

    RETURN expr

END FUNCTION

'----------------------------------------------------------------------------------------------

FUNCTION Check_Type$(STRING filename, STRING v$)

    LOCAL txt$, needle$
    LOCAL expr = 0
    LOCAL thefile TYPE FILE*

    needle$ = CHOP$(REPLACE$(v$, "*", "\\*"))
    needle$ = CHOP$(REPLACE$(needle$, "$", "\\$"))

    OPEN filename FOR READING AS thefile

    WHILE NOT(ENDFILE(thefile)) DO

        READLN txt$ FROM thefile
        IF NOT(ENDFILE(thefile)) AND LEN(txt$) > 0 THEN
            expr = REGEX(txt$, "DIR|FILE|int|long|float|double|char|void|STRING|NUMBER|FLOATING")
	    IF ISTRUE(expr) THEN
		IF INSTR(needle$, "[") THEN
		    expr = REGEX(txt$, CONCAT$(LEFT$(needle$, INSTR(needle$, "[")-1), "\\["))
		ELSE
		    expr = REGEX(txt$, CONCAT$(" ", needle$, ",| ", needle$, ";|,", needle$, ",|,", needle$, ";"))
		END IF
		IF ISTRUE(expr) THEN
		    expr = NOT(REGEX(txt$, "/\\*record\\*/"))
		    BREAK
		END IF

	    ENDIF
        ENDIF
    WEND

    CLOSE FILE thefile

    IF ISTRUE(expr) THEN
	RETURN txt$
    END IF

    RETURN ""

END FUNCTION

'----------------------------------------------------------------------------------------------

SUB Print_Element (STRING arg$)

    LOCAL func$

    func$ = LEFT$(arg$, 3)

    ' Check type of var, func using string but returning a value?
    IF EQUAL(func$, "VAL") OR EQUAL(func$, "INS") OR EQUAL(func$, "LEN") OR EQUAL(func$, "LEN") OR EQUAL(func$, "SEA") OR EQUAL(func$, "REG") OR EQUAL(func$, "ASC") OR EQUAL(LEFT$(arg$, 4), "FILE") THEN
	WRITELN "fprintf(stdout, \"%.10g\", (double)(", arg$, "));" TO g_CFILE
    ' String function?
    ELIF ISTRUE(INSTR(arg$, "$")) AND ISTRUE(INSTR(arg$, "(")) AND ISTRUE(INSTR(arg$, ")")) THEN
	WRITELN "fprintf(stdout, \"%s\", ", arg$, ");" TO g_CFILE
    ' Is there a "$" symbol? Then it is always a string, or stringvariable
    ELIF ISTRUE(INSTR(arg$, "$")) THEN
	WRITELN "if(", arg$, " != NULL) fprintf(stdout, \"%s\", ", arg$, ");" TO g_CFILE
	WRITELN "else fprintf(stdout, \"\");" TO g_CFILE
    ' Check if it is a normal string
    ELIF ISTRUE(EQUAL(RIGHT$(arg$, 1), "\"")) THEN
	WRITELN "fprintf(stdout, \"%s\", ", arg$, ");" TO g_CFILE
    ' Other numeric variable
    ELSE
	WRITELN "fprintf(stdout, \"%.10g\", (double)(", arg$, "));" TO g_CFILE
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Print(STRING arg$)

    LOCAL exp$, form$
    LOCAL x, in_string, in_func, pos, escaped

    ' Check if argument
    IF ISTRUE(LEN(arg$)) THEN

	' Omit semicolon if there is one
	IF EQUAL(RIGHT$(arg$, 1), ";") THEN
	    exp$ = LEFT$(arg$, LEN(arg$) - 1)
	ELSE
	    exp$ = arg$
	END IF

	' If there is a FORMAT argument
	IF INSTR(exp$, " FORMAT ") THEN
	    form$ = MID$(exp$, INSTR(exp$, " FORMAT ") + 8)
	    WRITELN "fprintf(stdout, ", form$, ", ", LEFT$(exp$, INSTR(exp$, " FORMAT ")), ");" TO g_CFILE
	ELSE
	    ' Start miniparser
	    in_string = FALSE
	    in_func = 0
	    pos = 1
	    escaped = 0

	    FOR x = 1 TO LEN(exp$)
		IF EQUAL(MID$(exp$, x, 1), ",") THEN
		    IF ISFALSE(in_string) AND ISFALSE(in_func) THEN
			Print_Element(CHOP$(MID$(exp$, pos, x-pos)))
			pos = x + 1
			escaped = FALSE
		    END IF
		ELIF EQUAL(MID$(exp$, x, 1), "\\") THEN
		    escaped = TRUE
		ELIF EQUAL(MID$(exp$, x, 1), "\"") THEN
		    IF ISFALSE(escaped) THEN
			in_string = NOT(in_string)
		    END IF
		    escaped = FALSE
		ELIF EQUAL(MID$(exp$, x, 1), "(") THEN
		    IF ISFALSE(in_string) THEN
			in_func = in_func + 1
		    END IF
		    escaped = FALSE
		ELIF EQUAL(MID$(exp$, x, 1), ")") THEN
		    IF ISFALSE(in_string) THEN
			in_func = in_func - 1
		    END IF
		    escaped = FALSE
		ELSE
		    escaped = FALSE
		ENDIF
	    NEXT
	    Print_Element(CHOP$(MID$(exp$, pos)))

	    ' If line ends with ';' then skip newline
	    IF ISFALSE(EQUAL(RIGHT$(arg$, 1), ";")) THEN
		WRITELN "fprintf(stdout, \"\\n\");" TO g_CFILE
	    END IF
	END IF

    ELSE
	WRITELN "fprintf(stdout, \"\\n\");" TO g_CFILE
    END IF

    ' Flush print buffer
    WRITELN "fflush(stdout);" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Input(STRING arg$)

    LOCAL x, in_string, in_func, pos, check, escaped
    LOCAL type$
    LOCAL thefile TYPE FILE*

    ' Check if we have an argument at all
    IF ISFALSE(LEN(arg$)) THEN
	PRINT NL$, "ERROR: empty INPUT at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Start miniparser
    in_string = FALSE
    in_func = 0
    pos = 1
    escaped = 0

    FOR x = 1 TO LEN(arg$)
	IF ISTRUE(EQUAL(MID$(arg$, x, 1), ",")) THEN
	    IF ISFALSE(in_string) AND ISFALSE(in_func) THEN
		Print_Element(CHOP$(MID$(arg$, pos, x-pos)))
		pos = x+1
		escaped = FALSE
	    END IF
	ELIF EQUAL(MID$(arg$, x, 1), "\\") THEN
	    escaped = TRUE
	ELIF ISTRUE(EQUAL(MID$(arg$, x, 1), "\"")) THEN
	    IF ISFALSE(escaped) THEN
		in_string = NOT(in_string)
	    END IF
	    escaped = FALSE
	ELIF ISTRUE(EQUAL(MID$(arg$, x, 1), "(")) THEN
	    IF ISFALSE(in_string) THEN
		in_func = in_func + 1
	    END IF
	    escaped = FALSE
	ELIF ISTRUE(EQUAL(MID$(arg$, x, 1), ")")) THEN
	    IF ISFALSE(in_string) THEN
		in_func = in_func - 1
	    END IF
	    escaped = FALSE
	ELSE
	    escaped = FALSE
	ENDIF
    NEXT
    arg$ = CHOP$(MID$(arg$, pos))

    ' Check type of var, string?
    IF EQUAL(RIGHT$(arg$, 1), "$") THEN

	' Is variable declared already?
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", arg$, " = NULL;"))
	CLOSE FILE thefile
	IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	    OPEN g_CFILE$ FOR READING AS thefile
		check = SEARCH(thefile, CONCAT$("char *", arg$, " = NULL;"))
	    CLOSE FILE thefile
	ENDIF

	IF check < 0 THEN
	    WRITELN "char *", arg$, " = NULL;" TO g_HFILE
	END IF

	' Translate function to C function
	WRITELN "memset(__b2c__input__buffer, '\\0', ", STR$(g_BUFFER_SIZE), "); fgets(__b2c__input__buffer, ", STR$(g_BUFFER_SIZE), ", stdin);" TO g_CFILE
	' Always realloc VAR to correct size, maybe it was resized somewhere else
	WRITELN arg$, " = (char*)realloc(", arg$, ", ", STR$(g_BUFFER_SIZE), "*sizeof(char));" TO g_CFILE
	' Make sure internal var is copied to var of program
	WRITELN "strncpy(", arg$, ", __b2c__input__buffer, ", STR$(g_BUFFER_SIZE), ");" TO g_CFILE
	' Get rid of the terminating newline
	WRITELN "if(strlen(__b2c__input__buffer)>0) ", arg$, "[strlen(__b2c__input__buffer)-1] = '\\0';" TO g_CFILE
    ' Var is numeric or stringarray
    ELSE
	' Variable may not be array, these should be defined with DECLARE
	IF NOT(REGEX(arg$, "\\[.*\\]")) AND NOT(INSTR(arg$, ".")) THEN

	    ' Is variable declared already?
	    check = Check_Declared(g_HFILE$, arg$)
	    IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(check) THEN
		check = Check_Declared(g_CFILE$, arg$)
	    END IF

	    IF ISFALSE(check) THEN
		WRITELN "long ", arg$, ";" TO g_HFILE
	    END IF
	END IF

	' Get the type
	type$ = Check_Type$(g_HFILE$, arg$)
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(LEN(type$)) THEN
	    type$ = Check_Type$(g_CFILE$, arg$)
	END IF

	' Translate function to C function
	WRITELN "memset(__b2c__input__buffer, '\\0', ", STR$(g_BUFFER_SIZE), "); fgets(__b2c__input__buffer, ", STR$(g_BUFFER_SIZE), ", stdin);" TO g_CFILE

	' Make sure internal var is copied to var of program
	IF INSTR(type$, "double ") OR INSTR(type$, "float ") OR INSTR(type$, "FLOATING ") THEN
	    WRITELN arg$, " = atof(__b2c__input__buffer);" TO g_CFILE
	ELIF INSTR(type$, "long ") OR INSTR(type$, "NUMBER ") THEN
	    WRITELN arg$, " = atol(__b2c__input__buffer);" TO g_CFILE
	ELIF INSTR(type$, "int ") OR INSTR(type$, "NUMBER ") THEN
	    WRITELN arg$, " = atoi(__b2c__input__buffer);" TO g_CFILE
	ELSE
	    WRITELN arg$, " = (char*)realloc(", arg$, ", ", STR$(g_BUFFER_SIZE), "*sizeof(char));" TO g_CFILE
	    WRITELN "strncpy(", arg$, ", __b2c__input__buffer, ", STR$(g_BUFFER_SIZE), ");" TO g_CFILE
	    WRITELN "if(strlen(__b2c__input__buffer)>0) ", arg$, "[strlen(__b2c__input__buffer)-1] = '\\0';" TO g_CFILE
	END IF
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_For(STRING arg$)

    LOCAL var$, tmp$, from$, to$, step$
    LOCAL check

    ' Get the variablename without (surrounding) spaces
    var$ = CHOP$(LEFT$(arg$, INSTR(arg$, "=") - 1))
    tmp$ = CHOP$(MID$(arg$, INSTR(arg$, "=") + 1))

    ' Do we have a STRING var?
    IF INSTR(var$, "$") THEN
	PRINT NL$, "ERROR: variable in FOR statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "cannot be string!"
	END 1
    END IF

    ' Check if TO is available
    IF NOT(INSTR(tmp$, " TO ")) THEN
	PRINT NL$, "ERROR: missing TO in FOR statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the starting and ending value
    from$ = CHOP$(LEFT$(tmp$, INSTR(tmp$, " TO ") - 1))
    to$ = CHOP$(MID$(tmp$, INSTR(tmp$, " TO ") + 3))

    ' Check if there is a STEP
    IF ISTRUE(INSTR(to$, " STEP ")) THEN
	step$ = CHOP$(MID$(to$, INSTR(to$, " STEP ") + 5))
	to$ = CHOP$(LEFT$(to$, INSTR(to$, " STEP ") - 1))
    ELSE
	step$ = "1"
    END IF

    ' Variable may not be array, these should be defined with DECLARE
    IF NOT(REGEX(var$, "\\[.*\\]")) AND ISFALSE(INSTR(var$, ".")) THEN

	' Is variable declared already?
	check = Check_Declared(g_HFILE$, var$)
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(check) THEN
	    check = Check_Declared(g_CFILE$, var$)
	END IF

	IF ISFALSE(check) THEN
	    WRITELN "long ", var$, ";" TO g_HFILE
	END IF
    END IF

    ' Translate function to C function
    IF VAL(step$) < 0 THEN
	WRITELN "for(", var$," = ", from$, "; ", var$, " >= ", to$, ";", var$, " += ", step$, "){" TO g_CFILE
    ELSE
	WRITELN "for(", var$," = ", from$, "; ", var$, " <= ", to$, ";", var$, " += ", step$, "){" TO g_CFILE
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_If(STRING arg$)

    ' Check if THEN is available
    IF ISFALSE(INSTRREV(arg$, " THEN")) THEN
	PRINT NL$, "ERROR: missing THEN in IF statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Translate function to C function
    WRITELN "if(", LEFT$(arg$, INSTRREV(arg$, " THEN")), "){" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Elif (STRING arg$)

    ' Check if THEN is available
    IF ISFALSE(INSTRREV(arg$, " THEN")) THEN
	PRINT NL$, "ERROR: missing THEN in ELIF statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Translate function to C function
    WRITELN "} else if(", LEFT$(arg$, INSTRREV(arg$, " THEN")), "){" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_While (STRING arg$)

    ' Check if DO is available
    IF ISFALSE(INSTRREV(arg$, " DO")) THEN
	PRINT NL$, "ERROR: missing DO in WHILE statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    WRITELN "while(", LEFT$(arg$, INSTRREV(arg$, " DO")), "){" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Let(STRING arg$)

    LOCAL check
    LOCAL var$, tmp$
    LOCAL thefile TYPE FILE*

    ' Check if we have an argument at all
    IF NOT(INSTR(arg$, "=")) THEN
	PRINT NL$, "ERROR: could not parse line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the variablename without surrounding spaces
    var$ = CHOP$(LEFT$(arg$, INSTR(arg$, "=") - 1))
    tmp$ = CHOP$(MID$(arg$, INSTR(arg$, "=") + 1))

    ' Check if var is string var, exclude RECORD elements
    IF EQUAL(RIGHT$(var$, 1), "$") AND NOT(INSTR(var$, ".")) THEN
	' Is variable declared already?
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", var$, " = NULL;"))
	CLOSE FILE thefile
	IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	    OPEN g_CFILE$ FOR READING AS thefile
		check = SEARCH(thefile, CONCAT$("char *", var$, " = NULL;"))
	    CLOSE FILE thefile
	ENDIF

	IF check < 0 THEN
	    WRITELN "char *", var$, " = NULL;" TO g_HFILE
	END IF

    ' Assume number, exclude RECORD elements
    ELIF NOT(REGEX(var$, "\\[.*\\]")) AND NOT(INSTR(var$, ".")) AND NOT(EQUAL(var$, "ERROR")) THEN

	' Is variable declared already?
	check = Check_Declared(g_HFILE$, var$)
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(check) THEN
	    check = Check_Declared(g_CFILE$, var$)
	END IF

	IF ISFALSE(check) THEN
	    IF INSTR(tmp$, ".") THEN
		WRITELN "double ", var$, ";" TO g_HFILE
	    ELSE
		WRITELN "long ", var$, ";" TO g_HFILE
	    END IF
	END IF
    END IF

    ' Do we have a STRING variable?
    IF INSTR(var$, "$") THEN
	WRITELN "__b2c__assign = (char*) strdup (", tmp$, "); ", g_WITHVAR$, var$, " = (char*)realloc(", g_WITHVAR$, var$, ", (strlen(__b2c__assign)+1)*sizeof(char));" TO g_CFILE
	WRITELN "strcpy(", g_WITHVAR$, var$, ", __b2c__assign); free(__b2c__assign);" TO g_CFILE
    ELSE
	WRITELN g_WITHVAR$, arg$, ";" TO g_CFILE
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Open(STRING arg$)

    LOCAL check
    LOCAL file$, tmp$, mode$, handle$

    ' Check if FOR is available
    IF NOT(INSTR(arg$, " FOR ")) THEN
	PRINT NL$, "ERROR: missing FOR in OPEN statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Check if AS is available
    IF NOT(INSTR(arg$, " AS ")) THEN
	PRINT NL$, "ERROR: missing AS in OPEN statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the file, mode and handle
    file$ = CHOP$(LEFT$(arg$, INSTR(arg$, " FOR ") - 1))
    tmp$ = CHOP$(MID$(arg$, INSTR(arg$, " FOR ") + 5))

    mode$ = CHOP$(LEFT$(tmp$, INSTR(tmp$, " AS ") - 1))
    handle$ = CHOP$(MID$(tmp$, INSTR(tmp$, " AS ") + 4))

    ' Check if var is string var
    IF INSTR(handle$, "$") THEN
	PRINT NL$, "ERROR: variable for OPEN at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "cannot be string!"
	END 1
    END IF

    ' Check if variable was declared
    IF NOT(INSTR(handle$, ".")) THEN
	check = Check_Declared(g_HFILE$, handle$)
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(check) THEN
	    check = Check_Declared(g_CFILE$, handle$)
	END IF
    END IF

    ' File or dir?
    IF EQUAL(mode$, "DIRECTORY") THEN
	IF ISFALSE(check) THEN
	    WRITELN "DIR* ", handle$, ";" TO g_HFILE
	END IF
    ELIF EQUAL(mode$, "MEMORY") THEN
	IF ISFALSE(check) THEN
	    WRITELN "char* ", handle$, ";" TO g_HFILE
	END IF
    ELIF EQUAL(mode$, "NETWORK") OR EQUAL(mode$, "SERVER") THEN
	IF ISFALSE(check) THEN
	    WRITELN "int ", handle$, ";" TO g_HFILE
	END IF
    ELSE
	IF ISFALSE(check) THEN
	    WRITELN "FILE* ", handle$, ";" TO g_HFILE
	END IF
    END IF

    ' Convert to C syntax
    IF EQUAL(mode$, "READING") THEN
	WRITELN handle$, " = fopen(", file$, ", \"r\");" TO g_CFILE
	WRITELN "if(", handle$, " == NULL){if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set) {fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
    ELIF EQUAL(mode$, "WRITING") THEN
	WRITELN handle$, " = fopen(", file$, ", \"w\");" TO g_CFILE
	WRITELN "if(", handle$, " == NULL){if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set) {fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
    ELIF EQUAL(mode$, "APPENDING") THEN
	WRITELN handle$, " = fopen(", file$, ", \"a\");" TO g_CFILE
	WRITELN "if(", handle$, " == NULL){if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set) {fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
    ELIF EQUAL(mode$, "READWRITE") THEN
	WRITELN handle$, " = fopen(", file$, ", \"r+\");" TO g_CFILE
	WRITELN "if(", handle$, " == NULL){if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set) {fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
    ELIF EQUAL(mode$, "DIRECTORY") THEN
	WRITELN handle$, " = opendir(", file$, ");" TO g_CFILE
	WRITELN "if(", handle$, " == NULL){if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set) {fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
    ELIF EQUAL(mode$, "MEMORY") THEN
	WRITELN handle$, " = (char*)", file$, "; long __b2c_mem_", handle$, "; __b2c_mem_", handle$, " = ", file$, ";" TO g_CFILE
	WRITELN "if(!__b2c__trap){__b2c__memory__check(", handle$, "); if(ERROR) {if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
    ELIF EQUAL(mode$, "NETWORK") THEN
	' Network code
	WRITELN "if (strstr(", file$, ", \":\") == NULL){if(!__b2c__trap){ERROR = 10;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
	WRITELN "strncpy(__b2c__data, ", file$, ", ", STR$(g_BUFFER_SIZE), ");__b2c__host = strtok(__b2c__data, \":\"); __b2c__port = strtok(NULL, \":\");__b2c__he = gethostbyname(__b2c__host);" TO g_CFILE
	WRITELN "if (__b2c__he == NULL){if(!__b2c__trap){ERROR = 11;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
	WRITELN handle$, " = socket(PF_INET, SOCK_STREAM, 0);" TO g_CFILE
	WRITELN "if (", handle$, " == -1) {if(!__b2c__trap){ERROR = 12;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
	WRITELN "setsockopt(", handle$, ", SOL_SOCKET, SO_REUSEADDR, &__b2c__yes, sizeof(int)); __b2c__addr.sin_family = AF_INET; __b2c__addr.sin_port = htons((long)atol(__b2c__port));" TO g_CFILE
	WRITELN "__b2c__addr.sin_addr = *((struct in_addr *)__b2c__he->h_addr); memset(&(__b2c__addr.sin_zero), '\\0', sizeof(__b2c__addr.sin_zero));" TO g_CFILE
	WRITELN "__b2c__result = connect(", handle$, ", (struct sockaddr *)&__b2c__addr, sizeof(struct sockaddr));" TO g_CFILE
	WRITELN "if(__b2c__result == -1) {if(!__b2c__trap){ERROR = 13;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
    ELIF EQUAL(mode$, "SERVER") THEN
	' Network code
	WRITELN "if (strstr(", file$, ", \":\") == NULL){if(!__b2c__trap){ERROR = 10;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
	WRITELN "strncpy(__b2c__data, ", file$, ", ", STR$(g_BUFFER_SIZE), ");__b2c__host = strtok(__b2c__data, \":\"); __b2c__port = strtok(NULL, \":\");__b2c__he = gethostbyname(__b2c__host);" TO g_CFILE
	WRITELN "if (__b2c__he == NULL) {if(!__b2c__trap){ERROR = 11;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
	WRITELN handle$, " = socket(AF_INET, SOCK_STREAM, 0);" TO g_CFILE
	WRITELN "if (", handle$, " == -1) {if(!__b2c__trap){ERROR = 12;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
	WRITELN "setsockopt(", handle$, ", SOL_SOCKET, SO_REUSEADDR, &__b2c__yes, sizeof(int));__b2c__addr.sin_family = AF_INET; __b2c__addr.sin_port = htons((long)atol(__b2c__port));" TO g_CFILE
	WRITELN "__b2c__addr.sin_addr = *((struct in_addr *)__b2c__he->h_addr);memset(&(__b2c__addr.sin_zero), '\\0', sizeof(__b2c__addr.sin_zero));" TO g_CFILE
	WRITELN "__b2c__result = bind(", handle$, ", (struct sockaddr *)&__b2c__addr, sizeof(struct sockaddr));" TO g_CFILE
	WRITELN "if(__b2c__result == -1){if(!__b2c__trap){ERROR = 17;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
	WRITELN "__b2c__result = listen(", handle$, ", ", STR$(g_MAX_BACKLOG), ");" TO g_CFILE
	WRITELN "if(__b2c__result == -1){if(!__b2c__trap){ERROR = 18;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
	WRITELN "__b2c__result = accept(", handle$, ", NULL, 0);" TO g_CFILE
	WRITELN "if(__b2c__result == -1){if(!__b2c__trap){ERROR = 19;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
	WRITELN handle$, "= __b2c__result;" TO g_CFILE
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Seek(STRING arg$)

    LOCAL dim

    ' Check if we have an argument at all
    IF ISFALSE(LEN(arg$)) THEN
	PRINT NL$, "ERROR: empty SEEK at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Check if OFFSET is available
    IF NOT(INSTR(arg$, " OFFSET ")) THEN
	PRINT NL$, "ERROR: missing OFFSET in SEEK statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the variablename, filedescriptor
    SPLIT arg$ BY " " TO element$ SIZE dim

    ' Convert to C function
    IF dim EQ 3 THEN
	WRITELN "fseek(", element$[0], ", ", element$[2], ", SEEK_SET);" TO g_CFILE
    ELIF dim EQ 5 THEN
	IF EQUAL(element$[4], "START") THEN
	    WRITELN "fseek(", element$[0], ", ", element$[2], ", SEEK_SET);" TO g_CFILE
	ELIF EQUAL(element$[4], "CURRENT") THEN
	    WRITELN "fseek(", element$[0], ", ", element$[2], ", SEEK_CUR);" TO g_CFILE
	ELIF EQUAL(element$[4], "END") THEN
	    WRITELN "fseek(", element$[0], ", ", element$[2], ", SEEK_END);" TO g_CFILE
	END IF
    ELSE
	PRINT NL$, "ERROR: erroneous SEEK statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Copy(STRING arg$)

    LOCAL from$, to$

    ' Check if we have an argument at all
    IF ISFALSE(LEN(arg$)) THEN
	PRINT NL$, "ERROR: empty COPY at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Check if TO is available
    IF NOT(INSTR(arg$, " TO ")) THEN
	PRINT NL$, "ERROR: Missing TO in COPY statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the filename and copyname
    from$ = CHOP$(MID$(arg$, 1, INSTR(arg$, " TO ") - 1))
    to$ = CHOP$(MID$(arg$, INSTR(arg$, " TO ") + 4))

    ' Translate to C function
    WRITELN "__b2c__inFile = fopen(", from$, ", \"r\"); __b2c__outFile = fopen(", to$, ", \"w\"); __b2c__Byte = 0;" TO g_CFILE
    WRITELN "if (__b2c__inFile != NULL && __b2c__outFile != NULL){while(__b2c__Byte!=EOF){" TO g_CFILE
    WRITELN "__b2c__Byte=fgetc(__b2c__inFile); if(__b2c__Byte!=EOF){" TO g_CFILE
    WRITELN "fputc(__b2c__Byte,__b2c__outFile); }}" TO g_CFILE
    WRITELN "fclose(__b2c__inFile); fclose(__b2c__outFile);}" TO g_CFILE
    WRITELN "else { if(!__b2c__trap){ERROR = 2; if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Rename(STRING arg$)

    LOCAL from$, to$

    ' Check if we have an argument at all
    IF ISFALSE(LEN(arg$)) THEN
	PRINT NL$, "ERROR: empty RENAME at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF
    
    ' Check if TO is available
    IF NOT(INSTR(arg$, " TO ")) THEN
	PRINT NL$, "ERROR: Missing TO in RENAME statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the filename and copyname
    from$ = CHOP$(MID$(arg$, 1, INSTR(arg$, " TO ") - 1))
    to$ = CHOP$(MID$(arg$, INSTR(arg$, " TO ") + 4))

    ' Translate to C function
    WRITELN "if(rename(", from$, ", ", to$, ") < 0) {if(!__b2c__trap){ERROR = 9; if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Readln(STRING arg$)

    LOCAL dim, check
    LOCAL thefile TYPE FILE*

    ' Check if FROM is available
    IF NOT(INSTR(arg$, " FROM ")) THEN
	PRINT NL$, "ERROR: missing FROM in READLN statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the variablename, filedescriptor
    SPLIT arg$ BY " " TO element$ SIZE dim

    ' Check if var is string var
    IF NOT(INSTR(element$[0], "$")) THEN
	PRINT NL$, "ERROR: variable for READLN at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, " must be string!"
	END 1
    END IF

    ' Check if var is string var, exclude RECORD elements
    IF NOT(REGEX(element$[0], "\\[.*\\]")) THEN
	' Is variable declared already?
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", element$[0], " = NULL;"))
	CLOSE FILE thefile
	IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	    OPEN g_CFILE$ FOR READING AS thefile
		check = SEARCH(thefile, CONCAT$("char *", element$[0], " = NULL;"))
	    CLOSE FILE thefile
	ENDIF

	IF check < 0 THEN
	    WRITELN "char *", element$[0], " = NULL;" TO g_HFILE
	END IF
    END IF

    ' Translate function to C function
    WRITELN "memset(__b2c__input__buffer, '\\0', ", STR$(g_BUFFER_SIZE), "); fgets(__b2c__input__buffer, ", STR$(g_BUFFER_SIZE), ", ", element$[2], ");" TO g_CFILE

    ' Make sure internal var is copied to var of program
    WRITELN element$[0], " = (char*)realloc(", element$[0], ", ", STR$(g_BUFFER_SIZE), "*sizeof(char));" TO g_CFILE
    WRITELN "strncpy(", element$[0], ", __b2c__input__buffer, ", STR$(g_BUFFER_SIZE), ");" TO g_CFILE
    ' Make sure to end the string
    WRITELN "if(strlen(__b2c__input__buffer)>0) ", element$[0], "[strlen(__b2c__input__buffer)-1] = '\\0';" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Writeln(STRING arg$)

    LOCAL in_string, in_func, pos, escaped, x
    LOCAL var$, to$

    ' Check if FROM is available
    IF NOT(INSTR(arg$, " TO ")) THEN
	PRINT NL$, "ERROR: missing TO in WRITELN statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    var$ = LEFT$(arg$, INSTR(arg$, " TO "))
    to$ = CHOP$(MID$(arg$, INSTR(arg$, " TO ") + 4))

    ' Start miniparser
    in_string = FALSE
    in_func = 0
    pos = 1
    escaped = 0

    FOR x = 1 TO LEN(var$)
	IF ISTRUE(EQUAL(MID$(var$, x, 1), ",")) THEN
	    IF ISFALSE(in_string) AND ISFALSE(in_func) THEN
		IF INSTR(var$, "$") OR INSTR(var$, "\"") THEN
		    WRITELN "fprintf(", to$, ", \"%s\", ", CHOP$(MID$(var$, pos, x-pos)), ");" TO g_CFILE
		    pos = x+1
		    escaped = FALSE
		ELSE
		    PRINT NL$, "ERROR: argument for WRITELN at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "must be string!"
		    END 1
		END IF
	    END IF
	ELIF EQUAL(MID$(var$, x, 1), "\\") THEN
	    escaped = TRUE
	ELIF ISTRUE(EQUAL(MID$(var$, x, 1), "\"")) THEN
	    IF ISFALSE(escaped) THEN
		in_string = NOT(in_string)
	    END IF
	    escaped = FALSE
	ELIF ISTRUE(EQUAL(MID$(var$, x, 1), "(")) THEN
	    IF ISFALSE(in_string) THEN
		in_func = in_func + 1
	    END IF
	    escaped = FALSE
	ELIF ISTRUE(EQUAL(MID$(var$, x, 1), ")")) THEN
	    IF ISFALSE(in_string) THEN
		in_func = in_func - 1
	    END IF
	    escaped = FALSE
	ELSE
	    escaped = FALSE
	ENDIF
    NEXT
    var$ = MID$(var$, pos)

    IF INSTR(var$, "$") OR INSTR(var$, "\"") THEN
	WRITELN "fprintf(", to$, ", \"%s\\n\", ", var$, ");" TO g_CFILE
	WRITELN "fflush(", to$, ");" TO g_CFILE
    ELSE
	PRINT NL$, "ERROR: argument for WRITELN at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "must be string!"
	END 1
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Getbyte(STRING arg$)

    LOCAL dim, check
    LOCAL size$

    ' Check if FROM is available
    IF NOT(INSTR(arg$, " FROM ")) THEN
	PRINT NL$, "ERROR: missing FROM in GETBYTE statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the variablename, filedescriptor
    SPLIT arg$ BY " " TO element$ SIZE dim

    ' Check if SIZE is available
    IF dim > 4 THEN
	size$ = MID$(arg$, INSTR(arg$, "SIZE") + 4)
    ELSE
	size$ = "1"
    END IF

    ' Declare variable if not done yet, assuming long
    IF NOT(INSTR(element$[0], ".")) THEN
	check = Check_Declared(g_HFILE$, element$[0])
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(check) THEN
	    check = Check_Declared(g_CFILE$, element$[0])
	END IF

	IF ISFALSE(check) THEN
	    WRITELN "long ", element$[0], ";" TO g_HFILE
	END IF
    END IF

    ' Translate function to C function
    WRITELN "if(!__b2c__trap){__b2c__memory__check((char *)", element$[0], "); if(ERROR) {if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
    WRITELN "fread((void*)", element$[0], ", sizeof(char), ", size$, ", ", element$[2], ");" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Putbyte(STRING arg$)

    LOCAL dim
    LOCAL size$

    ' Check if FROM is available
    IF NOT(INSTR(arg$, " TO ")) THEN
	PRINT NL$, "ERROR: missing TO in PUTBYTE statement at line at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the variablename, filedescriptor
    SPLIT arg$ BY " " TO element$ SIZE dim

    ' Check if SIZE is available
    IF dim EQ 5 THEN
	size$ = MID$(arg$, INSTR(arg$, "SIZE") + 4)
    ELSE
	size$ = "1"
    END IF

    ' Translate function to C function
    WRITELN "if(!__b2c__trap){__b2c__memory__check((char *)", element$[0], "); if(ERROR){if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
    WRITELN "fwrite((void*)", element$[0], ", sizeof(char), ", size$, ", ", element$[2], ");" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Getfile(STRING arg$)

    LOCAL dim, check
    LOCAL thefile TYPE FILE*

    ' Check if FROM is available
    IF NOT(INSTR(arg$, " FROM ")) THEN
	PRINT NL$, "ERROR: missing FROM in GETFILE statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the variablename, filedescriptor
    SPLIT arg$ BY " " TO element$ SIZE dim

    ' Translate function to C function
    WRITELN "__b2c__dir = readdir(", element$[2], ");" TO g_CFILE

    ' Check if variable is declared
    IF NOT(INSTR(element$[0], "[")) AND NOT(INSTR(element$[0], "]")) THEN
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", element$[0], " = NULL;"))
	CLOSE FILE thefile
	IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	    OPEN g_CFILE$ FOR READING AS thefile
		check = SEARCH(thefile, CONCAT$("char *", element$[0], " = NULL;"))
	    CLOSE FILE thefile
	ENDIF
    END IF

    IF check < 0 THEN
	WRITELN "char *", element$[0], " = NULL;" TO g_HFILE
    END IF

    ' Always realloc VAR to correct size, maybe it was resized somewhere else
    WRITELN "if(__b2c__dir != NULL) {", element$[0], " = realloc(", element$[0], ", (strlen(__b2c__dir->d_name)+1)*sizeof(char));" TO g_CFILE
    ' Make sure internal var is copied to var of program
    WRITELN "strcpy(", element$[0], ", __b2c__dir->d_name); ", element$[0], "[strlen(__b2c__dir->d_name)] = '\\0';}" TO g_CFILE
    WRITELN "else {", element$[0], "[0] = '\\0';}" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Receive(STRING arg$)

    LOCAL dim, check
    LOCAL thefile TYPE FILE*

    ' Check if FROM is available
    IF NOT(INSTR(arg$, " FROM ")) THEN
	PRINT NL$, "ERROR: Missing FROM in RECEIVE statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get filedescriptor
    SPLIT arg$ BY " " TO element$ SIZE dim

    ' Check if var is string var
    IF NOT(INSTR(element$[0], "$")) THEN
	PRINT NL$, "ERROR: Variable for RECEIVE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, " must be string!"
	END 1
    END IF

    ' Check if variable is declared
    OPEN g_HFILE$ FOR READING AS thefile
	check = SEARCH(thefile, CONCAT$("char *", element$[0], " = NULL;"))
    CLOSE FILE thefile
    IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	OPEN g_CFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", element$[0], " = NULL;"))
	CLOSE FILE thefile
    ENDIF

    IF check < 0 THEN
	WRITELN "char *", element$[0], " = NULL;" TO g_HFILE
    END IF

    ' Translate function to C function
    WRITELN element$[0], " = (char*)realloc(", element$[0], ", (", STR$(g_BUFFER_SIZE), "+1)*sizeof(char));" TO g_CFILE
    WRITELN "memset(", element$[0], ", '\\0', ", STR$(g_BUFFER_SIZE), "+1);" TO g_CFILE
    WRITELN "if(recv(", element$[2], ", ", element$[0], ", ", STR$(g_BUFFER_SIZE),", 0) < 0) {if(!__b2c__trap){ERROR = 14;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Send(STRING arg$)

    LOCAL var$, to$

    ' Check if TO is available
    IF NOT(INSTR(arg$, " TO ")) THEN
	PRINT NL$, "ERROR: Missing TO in SEND statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the variablename without surrounding spaces
    var$ = LEFT$(arg$, INSTR(arg$, " TO "))

    ' Get filedescriptor
    to$ = CHOP$(MID$(arg$, INSTR(arg$, " TO ") + 4))

    ' Check if var is string var
    IF NOT(INSTR(var$, "\"")) AND NOT(INSTR(var$, "$")) THEN
	PRINT NL$, "ERROR: Variable for SEND at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, " must be string!"
	END 1
    END IF

    ' Translate function to C function
    WRITELN "if(send(", to$, ", ", var$, ", strlen(", var$, "), 0) < 0) {if(!__b2c__trap){ERROR = 15; if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Getline(STRING arg$)

    LOCAL dim, check
    LOCAL thefile TYPE FILE*

    ' Check if FROM is available
    IF NOT(INSTR(arg$, " FROM ")) THEN
	PRINT NL$, "ERROR: missing FROM in GETLINE statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the variablename, filedescriptor
    SPLIT arg$ BY " " TO element$ SIZE dim

    ' Check if var is string var
    IF NOT(INSTR(element$[0], "$")) THEN
	PRINT NL$, "ERROR: variable for GETLINE at line $g_COUNTER in file ", STR$(g_COUNTER), " in file ", g_CURFILE$, " must be string!"
	END 1
    END IF

    ' Check if variable is declared
    IF NOT(INSTR(element$[0], "[")) AND NOT(INSTR(element$[0], "]")) THEN
	' Is variable declared already?
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", element$[0], " = NULL;"))
	CLOSE FILE thefile
	IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	    OPEN g_CFILE$ FOR READING AS thefile
		check = SEARCH(thefile, CONCAT$("char *", element$[0], " = NULL;"))
	    CLOSE FILE thefile
	ENDIF

	IF check < 0 THEN
	    WRITELN "char *", element$[0], " = NULL;" TO g_HFILE
	END IF
    END IF

    ' Translate function to C function
    WRITELN "if (", element$[2], " == NULL ||", CONCAT$("*", element$[2]) , " == '\\0') {", element$[0], " = (char*)realloc(", element$[0], ", 2*sizeof(char)); strcpy(", element$[0], ", \"\");}" TO g_CFILE
    WRITELN "else { __b2c__assign = ", element$[2], "; while(*", element$[2], " != '\\0' && *", element$[2], " != '\\n') ", element$[2], "++;" TO g_CFILE

    ' Make sure internal var is copied to var of program
    WRITELN element$[0], " = (char*)realloc(", element$[0], ", (", element$[2], "-__b2c__assign+1)*sizeof(char));" TO g_CFILE
    WRITELN "strncpy(", element$[0], ", __b2c__assign, ", element$[2], "-__b2c__assign);" TO g_CFILE

    ' Make sure to end the string
    WRITELN element$[0], "[(", element$[2], "-__b2c__assign)] = '\\0'; ", element$[2], "++;}" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Putline(STRING arg$)

    LOCAL dim
    LOCAL var$, to$

    ' Check if TO is available
    IF NOT(INSTR(arg$, " TO ")) THEN
	PRINT NL$, "ERROR: missing TO in PUTLINE statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the variablename, filedescriptor
    var$ = CHOP$(LEFT$(arg$, INSTR(arg$, " TO ")))
    to$ = CHOP$(MID$(arg$, INSTR(arg$, " TO ") + 4))

    ' Check if var is string var
    IF NOT(INSTR(var$, "$")) AND NOT(EQUAL(RIGHT$(var$, 1), "\"")) THEN
	PRINT NL$, "ERROR: variable for PUTLINE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, " must be string!"
	END 1
    END IF

    ' Translate function to C function
    WRITELN "strcat(", to$, ", ", var$, "); strcat(", to$, ", \"\\n\"); ", to$, "+=strlen(", var$, ")+1;" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_SubFunc(STRING arg$)

    LOCAL x, dim
    LOCAL arg_s$

    ' Check argument
    IF ISFALSE(LEN(CHOP$(arg$))) THEN
	PRINT NL$, "ERROR: empty SUB/FUNCTION at at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Check if we are in a sub already
    IF LEN(g_FUNCNAME$) > 0 THEN
	PRINT NL$, "ERROR: cannot define a SUB/FUNCTION within a SUB/FUNCTION at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the funcname
    g_ORIGFUNCNAME$ = CHOP$(LEFT$(arg$, INSTR(arg$, "(")))

    ' Start miniparser to duplicate string arguments
    arg_s$ = CHOP$(MID$(arg$, INSTR(arg$, "(") + 1))

    SPLIT arg_s$ BY "," TO element$ SIZE dim

    x = 0
    WHILE dim > 1 DO
	IF INSTR(element$[x], "STRING ") OR INSTR(element$[x], "char* ") THEN
	    element$[x] = CHOP$(element$[x])
	    g_ORIGFUNCNAME$ = CONCAT$(g_ORIGFUNCNAME$, "STRING __b2c_", CHOP$(MID$(element$[x], INSTR(element$[x], " "))), ",")
	    g_STRINGARGS$ = CONCAT$(g_STRINGARGS$, "char *", CHOP$(MID$(element$[x], INSTR(element$[x], " "))), " = strdup(__b2c_", CHOP$(MID$(element$[x], INSTR(element$[x], " "))), ");")
	    g_LOCALSTRINGS$ = CONCAT$(g_LOCALSTRINGS$, " ", MID$(element$[x], INSTR(element$[x], " ")))
	ELSE
	    g_ORIGFUNCNAME$ = CONCAT$(g_ORIGFUNCNAME$, " ", element$[x], ",")
	END IF
	x = x + 1
	dim = dim - 1
    WEND

    IF ISTRUE(dim) THEN
	IF INSTR(element$[x], "STRING ") OR INSTR(element$[x], "char* ") THEN
	    element$[x] = CHOP$(LEFT$(element$[x], INSTR(element$[x], ")") - 1))
	    g_ORIGFUNCNAME$ = CONCAT$(g_ORIGFUNCNAME$, "STRING __b2c_", CHOP$(MID$(element$[x], INSTR(element$[x], " "))), ")")
	    g_STRINGARGS$ = CONCAT$(g_STRINGARGS$, "char *", CHOP$(MID$(element$[x], INSTR(element$[x], " "))), " = strdup(__b2c_", CHOP$(MID$(element$[x], INSTR(element$[x], " "))), ");")
	    g_LOCALSTRINGS$ = CONCAT$(g_LOCALSTRINGS$, " ", MID$(element$[x], INSTR(element$[x], " ")))
	ELSE
	    g_ORIGFUNCNAME$ = CHOP$(CONCAT$(g_ORIGFUNCNAME$, " ", element$[x]))
	END IF
    END IF

    ' Get original function name
    IF INSTR(g_ORIGFUNCNAME$, " (") THEN
	g_FUNCNAME$ = LEFT$(g_ORIGFUNCNAME$, INSTR(g_ORIGFUNCNAME$, " (") - 1)
    ELIF INSTR(g_ORIGFUNCNAME$, "(") THEN
	g_FUNCNAME$ = LEFT$(g_ORIGFUNCNAME$, INSTR(g_ORIGFUNCNAME$, "(") - 1)
    ELSE
	g_FUNCNAME$ = g_ORIGFUNCNAME$
    END IF

    ' Close the current C file
    CLOSE FILE g_CFILE

    ' Make symbol known to parser
    g_IMPORTED$ = CONCAT$(g_FUNCNAME$, " ", g_IMPORTED$)

    ' Switch to header file
    g_COPY_CFILE$ = g_CFILE$
    g_CFILE$ = CONCAT$(LEFT$(g_CFILE$, INSTR(g_CFILE$, ".c")), g_FUNCNAME$, ".tmp")

    ' Save CATCH routine
    g_ORIGCATCHGOTO$ = g_CATCHGOTO$
    g_CATCHGOTO$ = "__B2C__PROGRAM__EXIT"

    ' Open temp C file
    OPEN g_CFILE$ FOR WRITING AS g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Endsub()

    LOCAL tmp_HFILE TYPE FILE*
    LOCAL line$
    LOCAL dim, x

    ' Close the current C file
    CLOSE FILE g_CFILE

    ' Open temporary header file
    OPEN CONCAT$(g_TEMPDIR$, "/", LEFT$(g_CURFILE$, INSTR(g_CURFILE$, ".bac")), g_FUNCNAME$, ".h") FOR WRITING AS tmp_HFILE

    ' Get original function name
    IF INSTR(g_ORIGFUNCNAME$, " (") THEN
	WRITELN "void ", g_ORIGFUNCNAME$, " {" TO tmp_HFILE
    ELIF INSTR(g_ORIGFUNCNAME$, "(") THEN
	WRITELN "void ", g_ORIGFUNCNAME$, " {" TO tmp_HFILE
    ELSE
	WRITELN "void ", g_FUNCNAME$, "(void) {" TO tmp_HFILE
    END IF

    ' Finalize sub
    WRITELN g_STRINGARGS$ TO tmp_HFILE
    OPEN g_CFILE$ FOR READING AS g_CFILE
    WHILE NOT(ENDFILE(g_CFILE)) DO
        READLN line$ FROM g_CFILE
        IF NOT(ENDFILE(g_CFILE)) THEN
            WRITELN line$ TO tmp_HFILE
        ENDIF
    WEND
    CLOSE FILE g_CFILE

    ' Free strings variables if there are any
    SPLIT g_LOCALSTRINGS$ BY " " TO element$ SIZE dim
    FOR x = 0 TO dim - 1
	WRITELN "if(", element$[x], " != NULL) free(", element$[x], ");" TO tmp_HFILE
    NEXT
    WRITELN g_STRINGARRAYS$ TO tmp_HFILE
    WRITELN "__B2C__PROGRAM__EXIT: ;" TO tmp_HFILE
    WRITELN "}" TO tmp_HFILE

    ' Include header file
    IF NOT(INSTR(g_INCLUDE_FILES$, CONCAT$(LEFT$(g_CURFILE$, INSTR(g_CURFILE$, ".bac")), g_FUNCNAME$, ".h"))) THEN
	g_INCLUDE_FILES$ = CONCAT$(g_INCLUDE_FILES$, " ", LEFT$(g_CURFILE$, INSTR(g_CURFILE$, ".bac")), g_FUNCNAME$, ".h")
    END IF

    ' Add to total filelist
    g_TMP_FILES$ = CONCAT$(g_TMP_FILES$, " ", g_TEMPDIR$, "/", LEFT$(g_CURFILE$, INSTR(g_CURFILE$, ".bac")), g_FUNCNAME$, ".h")

    ' Delete temp funcfile
    DELETE FILE g_CFILE$

    ' Restore mainfile
    g_CFILE$ = g_COPY_CFILE$
    OPEN g_CFILE$ FOR APPENDING AS g_CFILE

    ' Restore CATCH routine
    g_CATCHGOTO$ = g_ORIGCATCHGOTO$

    ' Reset variables
    g_ORIGFUNCNAME$ = ""
    g_FUNCNAME$ = ""
    g_LOCALSTRINGS$ = ""
    g_STRINGARRAYS$ = ""
    g_STRINGARGS$ = ""

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Endfunction()

    IF ISFALSE(LEN(g_FUNCTYPE$)) THEN
	PRINT NL$, "ERROR: function '", g_FUNCNAME$, "' was defined without returning a value or string!"
	END 1
    END IF

    ' Close the current C file
    CLOSE FILE g_CFILE

    ' Open temporary header file
    OPEN CONCAT$(g_TEMPDIR$, "/", LEFT$(g_CURFILE$, INSTR(g_CURFILE$, ".bac")), g_FUNCNAME$, ".h") FOR WRITING AS tmp_HFILE

    ' Get original function name
    IF NOT(INSTR(g_ORIGFUNCNAME$, "(")) THEN
	WRITELN g_FUNCTYPE$, " ", g_FUNCNAME$, "(void) {" TO tmp_HFILE
    ELSE
	WRITELN g_FUNCTYPE$, " ", g_ORIGFUNCNAME$, " {" TO tmp_HFILE
    END IF

    ' Add function body
    WRITELN g_STRINGARGS$ TO tmp_HFILE
    OPEN g_CFILE$ FOR READING AS g_CFILE
    WHILE NOT(ENDFILE(g_CFILE)) DO
        READLN line$ FROM g_CFILE
        IF NOT(ENDFILE(g_CFILE)) THEN
            WRITELN line$ TO tmp_HFILE
        ENDIF
    WEND
    CLOSE FILE g_CFILE

    WRITELN "__B2C__PROGRAM__EXIT: ;" TO tmp_HFILE
    WRITELN "}" TO tmp_HFILE

    ' Include header file
    IF NOT(INSTR(g_INCLUDE_FILES$, CONCAT$(LEFT$(g_CURFILE$, INSTR(g_CURFILE$, ".bac")), g_FUNCNAME$, ".h"))) THEN
	g_INCLUDE_FILES$ = CONCAT$(g_INCLUDE_FILES$, " ", LEFT$(g_CURFILE$, INSTR(g_CURFILE$, ".bac")), g_FUNCNAME$, ".h")
    END IF

    ' Add to total filelist
    g_TMP_FILES$ = CONCAT$(g_TMP_FILES$, " ", g_TEMPDIR$, "/", LEFT$(g_CURFILE$, INSTR(g_CURFILE$, ".bac")), g_FUNCNAME$, ".h")

    ' Delete temp funcfile
    DELETE FILE g_CFILE$

    ' Restore mainfile
    g_CFILE$ = g_COPY_CFILE$
    OPEN g_CFILE$ FOR APPENDING AS g_CFILE

    ' Restore CATCH routine
    g_CATCHGOTO$ = g_ORIGCATCHGOTO$

    ' Clear function variables
    g_ORIGFUNCNAME$ = ""
    g_FUNCNAME$ = ""
    g_FUNCTYPE$ = ""
    g_LOCALSTRINGS$ = ""
    g_STRINGARRAYS$ = ""
    g_STRINGARGS$ = ""

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Return(STRING arg$)

    LOCAL type$, thearg$
    LOCAL dim, x

    ' Check if we have an argument at all
    IF ISFALSE(LEN(CHOP$(arg$))) THEN
	PRINT NL$, "ERROR: empty RETURN at at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    type$ = Check_Type$(g_CFILE$, arg$)

   ' Check type of var, func using string but returning a value? See also PRINT miniparser
    IF REGEX(arg$, "^VAL *\\(|^INSTR *\\(|^LEN *\\(|^SEARCH *\\(|^ASC *\\(|^FILE *\\(|^REGEX *\\(|^INSTRREV *\\(") THEN
	g_FUNCTYPE$ = "double "
	thearg$ = arg$

    ' Check type of var, string or normal string?
    ELIF INSTR(arg$, "$") OR INSTR(arg$, "\"") THEN
	g_FUNCTYPE$ = "char* "
	WRITELN "__b2c__rbuffer_ptr++; if(__b2c__rbuffer_ptr >= ", STR$(g_MAX_RBUFFERS), ") __b2c__rbuffer_ptr=0; if(", arg$, " != NULL)" TO g_CFILE
	WRITELN " {__b2c__rbuffer[__b2c__rbuffer_ptr] = (char*)realloc(__b2c__rbuffer[__b2c__rbuffer_ptr], (strlen(", arg$, ")+1)*sizeof(char));" TO g_CFILE
	WRITELN "strcpy(__b2c__rbuffer[__b2c__rbuffer_ptr], ", arg$, ");}" TO g_CFILE
	WRITELN "else {__b2c__rbuffer[__b2c__rbuffer_ptr] = (char*)realloc(__b2c__rbuffer[__b2c__rbuffer_ptr], 2*sizeof(char));" TO g_CFILE
	WRITELN "strcpy(__b2c__rbuffer[__b2c__rbuffer_ptr], \"\");}" TO g_CFILE
	thearg$ = "__b2c__rbuffer[__b2c__rbuffer_ptr]"

    ' Check if float
    ELIF INSTR(arg$, ".") THEN
	g_FUNCTYPE$ = "double "
	thearg$ = arg$

    ' Check if no alpha chars (then integer value)
    ELIF REGEX(arg$, "[0-9]") THEN
	g_FUNCTYPE$ = "long "
	thearg$ = arg$

    ' Assume variable, check if declared before
    ELIF ISTRUE(LEN(type$)) THEN
	IF INSTR(type$, "DIR* ") THEN
		g_FUNCTYPE$ = "DIR* "
	ELIF INSTR(type$, "FILE ") THEN
		g_FUNCTYPE$ = "FILE* "
	ELIF INSTR(type$, "int* ") THEN
		g_FUNCTYPE$ = "int* "
	ELIF INSTR(type$, "float* ") THEN
		g_FUNCTYPE$ = "float* "
	ELIF INSTR(type$, "double* ") THEN
		g_FUNCTYPE$ = "double* "
	ELIF INSTR(type$, "char* ") THEN
		g_FUNCTYPE$ = "char* "
	ELIF INSTR(type$, "long* ") THEN
		g_FUNCTYPE$ = "long* "
	ELIF INSTR(type$, "void* ") THEN
		g_FUNCTYPE$ = "void* "
	ELIF INSTR(type$, "int ") THEN
		g_FUNCTYPE$ = "int "
	ELIF INSTR(type$, "float ") THEN
		g_FUNCTYPE$ = "float "
	ELIF INSTR(type$, "double ") THEN
		g_FUNCTYPE$ = "double "
	ELIF INSTR(type$, "char ") THEN
		g_FUNCTYPE$ = "char "
	ELIF INSTR(type$, "long ") THEN
		g_FUNCTYPE$ = "long "
	ELIF INSTR(type$, "void ") THEN
		g_FUNCTYPE$ = "void "
	END IF
	thearg$ = arg$

    ' Not declared, assume integer variable
    ELSE
	g_FUNCTYPE$ = "long "
	thearg$ = arg$
    END IF

    ' Free strings variables if there are any
    SPLIT g_LOCALSTRINGS$ BY " " TO element$ SIZE dim
    FOR x = 0 TO dim - 1
	WRITELN "if(", element$[x], " != NULL) free(", element$[x], ");" TO g_CFILE
    NEXT
    WRITELN g_STRINGARRAYS$ TO g_CFILE

    ' The actual return value
    WRITELN "return (", thearg$, ");" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Deffn(STRING arg$)

    LOCAL sym$

    ' Check if we have an argument at all
    IF ISFALSE(LEN(arg$)) THEN
	PRINT NL$, "ERROR: empty DEF FN at at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Translate to C macro
    sym$ = CHOP$(MID$(arg$, INSTR(arg$, " ")))

    WRITELN "#define ", LEFT$(sym$, INSTR(sym$, "=") -1), " ", MID$(sym$, INSTR(sym$, "=") + 1) TO g_HFILE

    ' Make symbol known to parser
    g_IMPORTED$ = CONCAT$(LEFT$(sym$, INSTR(sym$, "(") - 1), " ", g_IMPORTED$)

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Const(STRING arg$)

    ' Check if we have an argument at all
    IF ISFALSE(LEN(arg$)) THEN
	PRINT NL$, "ERROR: empty CONST at at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    WRITELN "#define ", LEFT$(arg$, INSTR(arg$, "=") - 1), " (", MID$(arg$, INSTR(arg$, "=") + 1), ")" TO g_HFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Push(STRING arg$)

    LOCAL type$

    ' Check if we have an argument at all
    IF ISFALSE(LEN(CHOP$(arg$))) THEN
	PRINT NL$, "ERROR: empty PUSH at at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    IF NOT(INSTR(arg$, ".")) THEN
	type$ = Check_Type$(g_HFILE$, arg$)
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(LEN(type$)) THEN
	    type$ = Check_Type$(g_CFILE$, arg$)
	END IF
    END IF

    ' Check type of var, string?
    IF INSTR(arg$, "$") THEN
	WRITELN "if(__b2c__stringstack[__b2c__stackptr] == NULL){__b2c__stringstack[__b2c__stackptr] = (char*)realloc(__b2c__stringstack[__b2c__stackptr], (strlen(", arg$, ")+1)*sizeof(char));}" TO g_CFILE
	WRITELN "strcpy(__b2c__stringstack[__b2c__stackptr], ", arg$, ");" TO g_CFILE
	WRITELN "__b2c__typestack[__b2c__stackptr] = 1;" TO g_CFILE
    ' Check if it is a normal string
    ELIF INSTR(arg$, "\"") THEN
	WRITELN "if(__b2c__stringstack[__b2c__stackptr] == NULL){__b2c__stringstack[__b2c__stackptr] = (char*)realloc(__b2c__stringstack[__b2c__stackptr], (strlen(", arg$, ")+1)*sizeof(char));}" TO g_CFILE
	WRITELN "strcpy(__b2c__stringstack[__b2c__stackptr], ", arg$, ");" TO g_CFILE
	WRITELN "__b2c__typestack[__b2c__stackptr] = 1;" TO g_CFILE
    ' Check if float
    ELIF INSTR(arg$, ".") THEN
	WRITELN "__b2c__doublestack[__b2c__stackptr] = ", arg$, ";" TO g_CFILE
	WRITELN "__b2c__typestack[__b2c__stackptr] = 2;" TO g_CFILE
    ' Check if no alpha chars (then integer value)
    ELIF NOT(REGEX(arg$, "[a-zA-Z]")) THEN
	WRITELN "__b2c__longstack[__b2c__stackptr] = ", arg$, ";" TO g_CFILE
	WRITELN "__b2c__typestack[__b2c__stackptr] = 3;" TO g_CFILE
    ' Assume variable, check if declared before
    ELIF ISTRUE(LEN(type$)) THEN
	IF REGEX(type$, "double .*") THEN
	    WRITELN "__b2c__doublestack[__b2c__stackptr] = ", arg$, ";" TO g_CFILE
	    WRITELN "__b2c__typestack[__b2c__stackptr] = 2;" TO g_CFILE
	ELSE
	    WRITELN "__b2c__longstack[__b2c__stackptr] = ", arg$, ";" TO g_CFILE
	    WRITELN "__b2c__typestack[__b2c__stackptr] = 3;" TO g_CFILE
	END IF
    ' Not declared, assume integer variable
    ELSE
	WRITELN "__b2c__longstack[__b2c__stackptr] = ", arg$, ";" TO g_CFILE
	WRITELN "__b2c__typestack[__b2c__stackptr] = 3;" TO g_CFILE
    END IF

    ' Increase stackpointer
    WRITELN "__b2c__stackptr++;" TO g_CFILE
    WRITELN "if(__b2c__stackptr == ", STR$(g_STACK_DEPTH), ") __b2c__stackptr=", STR$(g_STACK_DEPTH), "-1;" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Pull(STRING arg$)

    LOCAL check
    LOCAL thefile TYPE FILE*
    LOCAL type$

    ' Check if we have an argument at all
    IF ISFALSE(LEN(CHOP$(arg$))) THEN
	PRINT NL$, "ERROR: empty PULL at at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Argument must be a variable
    IF NOT(REGEX(arg$, "[a-zA-Z]+.*")) THEN
	PRINT NL$, "ERROR: argument in PULL statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, " is not a variable!"
	END 1
    END IF

    ' Decrease stackpointer again
    WRITELN "__b2c__stackptr--;" TO g_CFILE
    WRITELN "if(__b2c__stackptr < 0) __b2c__stackptr=0;" TO g_CFILE

    ' Get the last value from stack
    IF INSTR(arg$, "$") THEN
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", arg$, " = NULL;"))
	CLOSE FILE thefile
	IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	    OPEN g_CFILE$ FOR READING AS thefile
		check = SEARCH(thefile, CONCAT$("char *", arg$, " = NULL;"))
	    CLOSE FILE thefile
	ENDIF

	IF check < 0 THEN
	    WRITELN "char *", arg$, " = NULL;" TO g_HFILE
	END IF

	WRITELN "if(__b2c__typestack[__b2c__stackptr] == 1) {" TO g_CFILE
	WRITELN arg$, " = (char*)realloc(", arg$, ", (strlen(__b2c__stringstack[__b2c__stackptr])+1)*sizeof(char));" TO g_CFILE
	WRITELN "strcpy(", arg$, ", __b2c__stringstack[__b2c__stackptr]);}" TO g_CFILE
    ELSE
	' Variable may not be array, these should be defined with DECLARE
	IF NOT(REGEX(arg$, "\\[.*\\]")) AND NOT(INSTR(arg$, ".")) THEN
	    ' Not declared? Assume long
	    check = Check_Declared(g_HFILE$, arg$)
	    IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(check) THEN
		check = Check_Declared(g_CFILE$, arg$)
	    END IF

	    IF ISFALSE(check) THEN
		WRITELN "long ", arg$, "; /* pull */" TO g_HFILE
	    END IF
	END IF

	' See how var was declared
	type$ = Check_Type$(g_HFILE$, arg$)
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(LEN(type$)) THEN
	    type$ = Check_Type$(g_CFILE$, arg$)
	END IF

	' Make sure internal var is copied to var of program
	IF INSTR(type$, "double ") OR INSTR(type$, "float ") OR INSTR(type$, "FLOATING ") THEN
	    WRITELN "if(__b2c__typestack[__b2c__stackptr] == 2) ", arg$, "=__b2c__doublestack[__b2c__stackptr];" TO g_CFILE
	ELIF INSTR(type$, "long ") OR INSTR(type$, "int ") OR INSTR(type$, "NUMBER ") THEN
	    WRITELN "if(__b2c__typestack[__b2c__stackptr] == 3) ", arg$, "=__b2c__longstack[__b2c__stackptr];" TO g_CFILE
	ELSE
	    WRITELN "if(__b2c__typestack[__b2c__stackptr] == 1) {" TO g_CFILE
	    WRITELN arg$, " = (char*)realloc(", arg$, ", (strlen(__b2c__stringstack[__b2c__stackptr])+1)*sizeof(char));" TO g_CFILE
	    WRITELN "strcpy(", arg$, ", __b2c__stringstack[__b2c__stackptr]);}" TO g_CFILE
	END IF
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Import(STRING arg$)

    LOCAL lib$, type$, sym$, tmp$, token$
    LOCAL thefile TYPE FILE*
    LOCAL check

    ' Check if FROM is available
    IF NOT(INSTR(arg$, " FROM ")) THEN
	PRINT NL$, "ERROR: missing FROM in IMPORT statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the symbolname without surrounding spaces and doublequotes
    IF INSTR(arg$, "(") THEN
	sym$ = REPLACE$((CHOP$(LEFT$(arg$, INSTR(arg$, "(") - 1))), "\"", "")
	tmp$ = CHOP$(MID$(arg$, INSTR(arg$, " FROM ") + 6))
	token$ = CHOP$(MID$(arg$, 1, INSTR(arg$, ")") - 1))
    ELSE
	sym$ = REPLACE$((CHOP$(MID$(arg$, 1, INSTR(arg$, " FROM ") - 1))), "\"", "")
	tmp$ = CHOP$(MID$(arg$, INSTR(arg$, " FROM ") + 6))
	token$ = ""
    END IF

    ' Check if TYPE is available
    IF NOT(INSTR(arg$, " TYPE ")) THEN
	PRINT NL$, "ERROR: missing TYPE in IMPORT statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get library and type
    lib$ = CHOP$(MID$(tmp$, 1, INSTR(tmp$, " TYPE ")))
    type$ = CHOP$(MID$(tmp$, INSTR(tmp$, " TYPE ") + 6))

    ptr$ = REPLACE$(REPLACE$(lib$, "\"", ""), "-", "")
    ptr$ = REPLACE$(ptr$, ".", "")

    ' If library is libm or libc, skip dlopen as we're linking with those anyway
    IF NOT(INSTR(lib$, "libc.so") ) AND NOT(INSTR(lib$, "libm.so")) THEN

	' Check if variable was declared
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("void* __b2c__dlopen__pointer_", ptr$, ";"))
	CLOSE FILE thefile
	IF check < 0 THEN
	    WRITELN "void* __b2c__dlopen__pointer_", ptr$, ";" TO g_HFILE
	    WRITELN "__b2c__dlopen__pointer_", ptr$, " = dlopen(", lib$, ", RTLD_GLOBAL|RTLD_LAZY);" TO g_CFILE
	    WRITELN "if(__b2c__dlopen__pointer_", ptr$, " == NULL){if(!__b2c__trap){ERROR = 3;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
	END IF

	' Check if token was declared
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$(type$, "(\\*", sym$, ")"))
	CLOSE FILE thefile
	IF check < 0 THEN
	    WRITELN type$, "(*", sym$, ")(", MID$(token$, INSTR(token$, "(") + 1), ");" TO g_HFILE
	END IF

	' Translate to C function
	WRITELN "*(", type$, "**) (&", sym$, ") = dlsym(__b2c__dlopen__pointer_", ptr$, ", \"", sym$, "\");" TO g_CFILE
	WRITELN "if(", sym$, " == NULL) {if(!__b2c__trap){ERROR = 4;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
    END IF

    ' Make symbol known to parser
    g_IMPORTED$ = CONCAT$(sym$, " ", g_IMPORTED$)

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Declare(STRING arg$)

    LOCAL var$, type$
    LOCAL i, dim, check
    LOCAL thefile TYPE FILE*

    ' Get the variablename and type
    IF INSTR(arg$, " TYPE ") THEN
	var$ = CHOP$(MID$(arg$, 1, INSTR(arg$, " TYPE ")))
	type$ = CHOP$(MID$(arg$, INSTR(arg$, " TYPE ") + 6))
    ELSE
	var$ = CHOP$(arg$)
	type$ = "long"
    END IF

    ' Check if variable was already declared
    IF NOT(INSTR(var$, ".")) THEN
	check = Check_Declared(g_HFILE$, var$)
    END IF

    IF ISTRUE(check) THEN
	PRINT NL$, "ERROR: variable in DECLARE or GLOBAL statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, " was defined previously!"
	END 1
    END IF

    ' Check if var is string var
    IF INSTR(var$, "$") THEN
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", var$, " = NULL;"))
	CLOSE FILE thefile
	IF check < 0 THEN
	    SPLIT var$ BY "," TO str$ SIZE dim
	    FOR i = 0 TO dim - 1
		IF INSTR(str$[i], "[") THEN
		    WRITELN "char *", str$[i], " = { NULL };" TO g_HFILE
		ELSE
		    WRITELN "char *", str$[i], " = NULL;" TO g_HFILE
		END IF
	    NEXT
	END IF

    ' Assume number
    ELSE
	WRITELN type$, " ", var$, ";" TO g_HFILE
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Local(STRING arg$)

    LOCAL var$, type$
    LOCAL check, i, dim
    LOCAL thefile TYPE FILE*

    ' Get the variablename and type
    IF INSTR(arg$, " TYPE ") THEN
	var$ = CHOP$(MID$(arg$, 1, INSTR(arg$, " TYPE ")))
	type$ = CHOP$(MID$(arg$, INSTR(arg$, " TYPE ") + 6))
    ELSE
	var$ = CHOP$(arg$)
	type$ = "long"
    END IF

    check = 0

    ' Check if variable was already declared
    IF NOT(INSTR(var$, ".")) THEN
	IF LEN(g_FUNCNAME$) > 0 THEN
	    check = Check_Declared(g_CFILE$, var$)
	ELSE
	    check = Check_Declared(g_HFILE$, var$)
	END IF
    END IF

    IF ISTRUE(check) THEN
	PRINT NL$, "ERROR: variable in LOCAL statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, " was defined previously!"
	END 1
    END IF

    ' Check if var is string var
    IF INSTR(var$, "$") THEN
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", var$, " = NULL;"))
	CLOSE FILE thefile
	IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	    OPEN g_CFILE$ FOR READING AS thefile
		check = SEARCH(thefile, CONCAT$("char *", var$, " = NULL;"))
	    CLOSE FILE thefile
	ENDIF

	IF check < 0 THEN
	    SPLIT var$ BY "," TO str$ SIZE dim
	    FOR i = 0 TO dim - 1
		' Check on multidimensional stringarrays
		IF REGEX(str$[i], "\\[.*\\]\\[") THEN
		    PRINT NL$, "ERROR: multidimensional stringarrays at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, " are not supported!"
		    END 1
		END IF

		' Are we in a function?
		IF ISTRUE(LEN(g_FUNCNAME$)) THEN
		    IF ISTRUE(LEN(g_RECORDNAME$)) THEN
			IF REGEX(str$[i], "\\[.*\\]") THEN
			    WRITELN "char *", CHOP$(str$[i]), ";" TO g_CFILE
			    dim$ = MID$(str$[i], INSTR(str$[i], "[") + 1)
			    g_STRINGARRAYS$ = CONCAT$(g_STRINGARRAYS$, " for(__b2c__ctr=0; __b2c__ctr<", LEFT$(dim$, INSTR(dim$, "]") - 1), "; __b2c__ctr++)if(", g_RECORDVAR$, ".", LEFT$(str$[i], INSTR(str$[i], "[")-1), "[__b2c__ctr]!=NULL){free(", g_RECORDVAR$, ".", LEFT$(str$[i], INSTR(str$[i], "[")-1), "[__b2c__ctr]);}")
			ELSE
			    WRITELN "char *", CHOP$(str$[i]), "; /*record*/" TO g_CFILE
			END IF
		    ELSE
			IF REGEX(str$[i], "\\[.*\\]") THEN
			    WRITELN "char *", CHOP$(str$[i]), " = { NULL};" TO g_CFILE
			    dim$ = MID$(str$[i], INSTR(str$[i], "[") + 1)
			    g_STRINGARRAYS$ = CONCAT$(g_STRINGARRAYS$, " for(__b2c__ctr=0; __b2c__ctr<", LEFT$(dim$, INSTR(dim$, "]") - 1), "; __b2c__ctr++)if(", g_WITHVAR$, LEFT$(str$[i], INSTR(str$[i], "[")-1), "[__b2c__ctr]!=NULL){free(", g_WITHVAR$, LEFT$(str$[i], INSTR(str$[i], "[")-1), "[__b2c__ctr]);}")
			ELSE
			    WRITELN "char *", CHOP$(str$[i]), " = NULL;" TO g_CFILE
			    g_LOCALSTRINGS$ = CONCAT$(g_LOCALSTRINGS$, " ", str$[i])
			END IF
		    END IF
		' We are in the mainprogram
		ELSE
		    IF ISTRUE(LEN(g_RECORDNAME$)) THEN
			WRITELN "char *", CHOP$(str$[i]), "; /*record*/" TO g_HFILE
		    ELSE
			IF REGEX(str$[i], "\\[.*\\]") THEN
			    WRITELN "char *", CHOP$(str$[i]), " = { NULL };" TO g_CFILE
			ELSE
			    WRITELN "char *", CHOP$(str$[i]), " = NULL;" TO g_HFILE
			END IF
		    END IF
		END IF
	    NEXT
	END IF
    ' Assume number
    ELSE
	IF ISTRUE(LEN(g_FUNCNAME$)) THEN
	    IF ISTRUE(LEN(g_RECORDNAME$)) THEN
		WRITELN type$, " ", var$, "; /*record*/" TO g_CFILE
	    ELSE
		WRITELN type$, " ", var$, ";" TO g_CFILE
	    END IF
	ELSE
	    IF ISTRUE(LEN(g_RECORDNAME$)) THEN
		WRITELN type$, " ", var$, "; /*record*/" TO g_HFILE
	    ELSE
		WRITELN type$, " ", var$, ";" TO g_HFILE
	    END IF
	END IF
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Read(STRING arg$)

    LOCAL thefile TYPE FILE*
    LOCAL check
    LOCAL type$

    ' Check if we have an argument at all
    IF ISFALSE(LEN(CHOP$(arg$))) THEN
	PRINT NL$, "ERROR: empty READ at at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Check type of var, string?
    IF EQUAL(RIGHT$(arg$, 1), "$") THEN
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", arg$, " = NULL;"))
	CLOSE FILE thefile
	IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	    OPEN g_CFILE$ FOR READING AS thefile
		check = SEARCH(thefile, CONCAT$("char *", arg$, " = NULL;"))
	    CLOSE FILE thefile
	ENDIF

	IF check < 0 THEN
	    WRITELN "char *", arg$, " = NULL;" TO g_HFILE
	END IF

	' Convert to C
	WRITELN arg$, " = (char*)realloc(", arg$, ", (strlen(__b2c__stringarray[__b2c__stringarray_ptr])+1)*sizeof(char));" TO g_CFILE
	WRITELN "strcpy(", arg$, ", __b2c__stringarray[__b2c__stringarray_ptr]);" TO g_CFILE
	WRITELN "__b2c__stringarray_ptr++;" TO g_CFILE
    ELSE
	' Variable may not be array, these should be defined with DECLARE
	IF NOT(REGEX(arg$, "\\[.*\\]")) AND NOT(INSTR(arg$, ".")) THEN
	    ' Not declared? Assume long
	    check = Check_Declared(g_HFILE$, arg$)
	    IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(check) THEN
		check = Check_Declared(g_CFILE$, arg$)
	    END IF

	    IF ISFALSE(check) THEN
		WRITELN "long ", arg$, ";" TO g_HFILE
	    END IF
	END IF

	' See how var was declared
	type$ = Check_Type$(g_HFILE$, arg$)
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(LEN(type$)) THEN
	    type$ = Check_Type$(g_CFILE$, arg$)
	END IF

	' Convert to C
	IF INSTR(type$, "double ") OR INSTR(type$, "float ") OR INSTR(type$, "FLOATING ") THEN
	    WRITELN arg$, " = __b2c__floatarray[__b2c__floatarray_ptr];" TO g_CFILE
	    WRITELN "__b2c__floatarray_ptr++;" TO g_CFILE
	ELIF INSTR(type$, "long ") OR INSTR(type$, "int ") OR INSTR(type$, "NUMBER ") THEN
	    WRITELN arg$, " = __b2c__intarray[__b2c__intarray_ptr];" TO g_CFILE
	    WRITELN "__b2c__intarray_ptr++;" TO g_CFILE
	ELSE
	    WRITELN arg$, " = (char*)realloc(", arg$, ", (strlen(__b2c__stringarray[__b2c__stringarray_ptr])+1)*sizeof(char));" TO g_CFILE
	    WRITELN "strcpy(", arg$, ", __b2c__stringarray[__b2c__stringarray_ptr]);" TO g_CFILE
	    WRITELN "__b2c__stringarray_ptr++;" TO g_CFILE
	END IF
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Color(STRING arg$)

    LOCAL dim

    ' Check if we have an argument at all
    IF ISFALSE(LEN(CHOP$(arg$))) THEN
	PRINT NL$, "ERROR: empty COLOR at at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    SPLIT arg$ BY " " TO element$ SIZE dim

    ' Check if we need to reset
    IF EQUAL(element$[0], "RESET") THEN
	WRITELN "printf(\"\\033[0m\");" TO g_CFILE
    ELIF EQUAL(element$[0], "INTENSE") THEN
	WRITELN "printf(\"\\033[1m\");" TO g_CFILE
    ELIF EQUAL(element$[0], "INVERSE") THEN
	WRITELN "printf(\"\\033[7m\");" TO g_CFILE
    ELIF EQUAL(element$[0], "NORMAL") THEN
	WRITELN "printf(\"\\033[22m\");" TO g_CFILE
    ' Check if TO is available
    ELIF NOT(INSTR(arg$, " TO ")) THEN
	PRINT NL$, "ERROR: Missing TO in COLOR statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    ELSE
	' Now select color
	IF EQUAL(element$[0], "FG") THEN
	    IF EQUAL(element$[2], "BLACK") THEN
		WRITELN "printf(\"\\033[30m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "RED") THEN
		WRITELN "printf(\"\\033[31m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "GREEN") THEN
		WRITELN "printf(\"\\033[32m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "YELLOW") THEN
		WRITELN "printf(\"\\033[33m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "BLUE") THEN
		WRITELN "printf(\"\\033[34m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "MAGENTA") THEN
		WRITELN "printf(\"\\033[35m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "CYAN") THEN
		WRITELN "printf(\"\\033[36m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "WHITE") THEN
		WRITELN "printf(\"\\033[37m\");" TO g_CFILE
	    END IF
	ELIF EQUAL(element$[0], "BG") THEN
	    IF EQUAL(element$[2], "BLACK") THEN
		WRITELN "printf(\"\\033[40m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "RED") THEN
		WRITELN "printf(\"\\033[41m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "GREEN") THEN
		WRITELN "printf(\"\\033[42m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "YELLOW") THEN
		WRITELN "printf(\"\\033[43m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "BLUE") THEN
		WRITELN "printf(\"\\033[44m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "MAGENTA") THEN
		WRITELN "printf(\"\\033[45m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "CYAN") THEN
		WRITELN "printf(\"\\033[46m\");" TO g_CFILE
	    ELIF EQUAL(element$[2], "WHITE") THEN
		WRITELN "printf(\"\\033[47m\");" TO g_CFILE
	    END IF
	END IF
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Gotoxy(STRING arg$)

    LOCAL dim

    ' Check if we have an argument at all
    IF ISFALSE(LEN(CHOP$(arg$))) THEN
	PRINT NL$, "ERROR: empty GOTOXY at at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the target and colorname
    SPLIT arg$ BY "," TO element$ SIZE dim

    IF dim EQ 1 THEN
	PRINT NL$, "ERROR: missing coordinate in GOTOXY at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Translate to C
    WRITELN "printf(\"\033[", CHOP$(element$[0]), ";", CHOP$(element$[1]), "H\");" TO g_CFILE

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Split(STRING arg$)

    LOCAL source$, rest$, by$, to$, size$
    LOCAL check
    LOCAL thefile TYPE FILE*

    ' Check if we have an argument at all
    IF ISFALSE(LEN(CHOP$(arg$))) THEN
	PRINT NL$, "ERROR: empty SPLIT at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF
    
    ' Check if BY is available
    IF NOT(INSTR(arg$, " BY ")) THEN
	PRINT NL$, "ERROR: Missing BY in SPLIT statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Check if TO is available
    IF NOT(INSTR(arg$, " TO ")) THEN
	PRINT NL$, "ERROR: Missing TO in SPLIT statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Check if SIZE is available
    IF NOT(INSTR(arg$, " SIZE ")) THEN
	PRINT NL$, "ERROR: Missing SIZE in SPLIT statement at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    ' Get the source string
    source$ = CHOP$(LEFT$(arg$, INSTR(arg$, " BY ") - 1))
    rest$ = MID$(arg$, INSTR(arg$, " BY ") + 4)

    by$ = CHOP$(LEFT$(rest$, INSTR(rest$, " TO ") - 1))
    rest$ = MID$(rest$, INSTR(rest$, " TO ") + 4)

    to$ = CHOP$(LEFT$(rest$, INSTR(rest$, " SIZE ") - 1))
    size$ = CHOP$(MID$(rest$, INSTR(rest$, " SIZE ") + 6))

    ' Variable may not be array, these should be defined with DECLARE
    IF NOT(REGEX(size$, "\\[.*\\]")) AND NOT(INSTR(size$, ".")) THEN
	check = Check_Declared(g_HFILE$, size$)
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(check) THEN
	    check = Check_Declared(g_CFILE$, size$)
	END IF

	IF ISFALSE(check) THEN
	    WRITELN "long ", size$, ";" TO g_HFILE
	END IF
    END IF

    ' Translate to C code
    IF ISTRUE(LEN(g_FUNCNAME$)) THEN
	IF NOT(INSTR(g_STRINGARGS$, CONCAT$("**", to$))) THEN
	    g_STRINGARGS$ = CONCAT$(g_STRINGARGS$, " char **", to$, " = NULL; int __b2c__split__", to$, " = 0;")
	END IF
    ELSE
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$(to$, " = NULL;"))
	CLOSE FILE thefile

	IF check < 0 THEN
	    WRITELN "char **", to$, " = NULL; int __b2c__split__", to$, " = 0;" TO g_HFILE
	END IF
    END IF

    ' If the split array was used before in a loop, clear it
    WRITELN "if(", to$, " != NULL) {for(__b2c__ctr=0; __b2c__ctr<=__b2c__split__", to$, "; __b2c__ctr++) if(", to$, "[__b2c__ctr]!=NULL)" TO g_CFILE
    WRITELN "{free(", to$, "[__b2c__ctr]);} free(", to$, "); ", to$, " = NULL; __b2c__split__", to$, " = 0;}" TO g_CFILE

    ' Run the SPLIT code
    WRITELN "if (", source$, " != NULL && ", by$, " != NULL && strlen(", by$, ") > 0) {__b2c__split_tmp = strdup(", source$, "); __b2c__split = strtok(__b2c__split_tmp, ", by$, ");" TO g_CFILE
    WRITELN "if (__b2c__split != NULL) {", to$, " = (char **)realloc(", to$, ", (__b2c__split__", to$, " + 1) * sizeof(char*)); ", to$, "[__b2c__split__", to$, "++] = strdup(__b2c__split);" TO g_CFILE
    WRITELN "while((__b2c__split = strtok(NULL, ", by$, ")) != NULL) {", to$, " = (char **)realloc(", to$, ", (__b2c__split__", to$, " + 1) * sizeof(char*));" TO g_CFILE
    WRITELN to$, "[__b2c__split__", to$, "++] = strdup(__b2c__split);} } free(__b2c__split_tmp);} ", size$, " = __b2c__split__", to$, "--;" TO g_CFILE

    ' Add declared array to array list if we are in a function
    IF ISTRUE(LEN(g_FUNCNAME$)) AND NOT(INSTR(g_STRINGARRAYS$, CONCAT$(to$, "["))) THEN
	g_STRINGARRAYS$ = CONCAT$(g_STRINGARRAYS$, " if(", to$, "!= NULL){for(__b2c__ctr=0;__b2c__ctr<=__b2c__split__", to$, ";__b2c__ctr++) if(", to$, "[__b2c__ctr]!=NULL){free(", to$, "[__b2c__ctr]);}free(", to$, ");}")
    END IF

END SUB

'----------------------------------------------------------------------------------------------

SUB Handle_Sort(STRING arg$)

    LOCAL dim$, type$
    LOCAL check

    ' Check if we have an argument at all
    IF ISFALSE(LEN(CHOP$(arg$))) THEN
	PRINT NL$, "ERROR: empty SORT at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	END 1
    END IF

    IF INSTR(arg$, "$") THEN
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("char *", arg$, "["))
	CLOSE FILE thefile
	IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	    OPEN g_CFILE$ FOR READING AS thefile
		check = SEARCH(thefile, CONCAT$("char *", arg$, "["))
	    CLOSE FILE thefile
	ENDIF
    ELSE
	check = Check_Declared(g_HFILE$, arg$)
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(check) THEN
	    check = Check_Declared(g_CFILE$, arg$)
	END IF
    END IF

    ' Verify if the array was declared at SPLIT
    IF check < 0 THEN
	OPEN g_HFILE$ FOR READING AS thefile
	    check = SEARCH(thefile, CONCAT$("__b2c__split__", arg$))
	CLOSE FILE thefile
	IF LEN(g_FUNCNAME$) > 0 AND check < 0 THEN
	    OPEN g_CFILE$ FOR READING AS thefile
		check = SEARCH(thefile, CONCAT$("__b2c__split__", arg$))
	    CLOSE FILE thefile
	ENDIF
	IF ISFALSE(check) THEN
	    PRINT NL$, "ERROR: argument to SORT not an array at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
	    END 1
	ELSE
	    dim$ = CONCAT$("__b2c__split__", arg$, "+1")
	END IF
    ELSE
	' See how var was declared
	type$ = Check_Type$(g_HFILE$, CONCAT$(arg$, "["))
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(LEN(type$)) THEN
	    type$ = Check_Type$(g_CFILE$, CONCAT$(arg$, "["))
	END IF
	dim$ = MID$(type$, INSTR(type$, "[") + 1, INSTR(type$, "]") - INSTR(type$, "[") - 1)
    END IF

    ' Check if we have a string
    IF INSTR(arg$, "$") THEN
	WRITELN "qsort((char*)", arg$, ", ", dim$, ", sizeof(char*), __b2c__sortstr);" TO g_CFILE
    ' It is a value
    ELSE
	' See how var was declared
	type$ = Check_Type$(g_HFILE$, CONCAT$(arg$, "["))
	IF LEN(g_FUNCNAME$) > 0 AND ISFALSE(LEN(type$)) THEN
	    type$ = Check_Type$(g_CFILE$, CONCAT$(arg$, "["))
	END IF
	IF INSTR(type$, "double ") OR INSTR(type$, "FLOATING ") THEN
	    WRITELN "qsort(&", arg$, ", ", dim$, ", sizeof(double), __b2c__sortnrd);" TO g_CFILE
	ELIF INSTR(type$, "float ") THEN
	    WRITELN "qsort(&", arg$, ", ", dim$, ", sizeof(float), __b2c__sortnrf);" TO g_CFILE
	ELIF INSTR(type$, "long ") OR INSTR(type$, "NUMBER ") THEN
	    WRITELN "qsort(&", arg$, ", ", dim$, ", sizeof(long), __b2c__sortnrl);" TO g_CFILE
	ELSE
	    WRITELN "qsort(&", arg$, ", ", dim$, ", sizeof(int), __b2c__sortnri);" TO g_CFILE
	END IF
    END IF

END SUB

'----------------------------------------------------------------------------------------------
'
' Simple parser to tokenize line.
'
' Each line should begin with a statement.
' The rest of the line may contain functions, these are
'   converted using C macros.
'
'----------------------------------------------------------------------------------------------

SUB Parse_Line(STRING line$)

    LOCAL statement$, inc$, copy_curfile$, total$, txt$, exp$
    LOCAL dim, i, found, copy_counter
    LOCAL newfile TYPE FILE*

    statement$ = CHOP$(line$)

    SPLIT statement$ BY " " TO element$ SIZE dim

    IF dim > 0 THEN

	IF ISTRUE(g_USE_C) THEN
	    IF EQUAL(LEFT$(statement$, 8), "END USEC") OR EQUAL(element$[0], "ENDUSEC") THEN
		g_USE_C = 0
	    ELSE
		WRITELN line$ TO g_CFILE
	    END IF

	ELIF EQUAL(LEFT$(element$[0], 1), "'") THEN
	    'Do nothing

	ELIF EQUAL(LEFT$(element$[0], 2), "#!") THEN
	    'Do nothing

	ELIF EQUAL(LEFT$(element$[0], 3), "REM") THEN
	    'Do nothing

	ELSE
	    SELECT element$[0]
		CASE "USEC"
		    g_USE_C = 1

		CASE "PRINT"
		    Handle_Print(MID$(line$, INSTR(line$, "PRINT") + 5))

		CASE "INPUT"
		    Handle_Input(MID$(line$, INSTR(line$, "INPUT") + 5))

		CASE "FOR"
		    Handle_For(MID$(line$, INSTR(line$, "FOR") + 3))

		CASE "NEXT"
		    WRITELN "}" TO g_CFILE

		CASE "IF"
		    Handle_If(MID$(line$, INSTR(line$, "IF") + 2))

		CASE "ELIF"
		    Handle_Elif(MID$(line$, INSTR(line$, "ELIF") + 4))

		CASE "ELSE"
		    WRITELN "} else {" TO g_CFILE

		CASE "ENDIF"
		    WRITELN "}" TO g_CFILE

		CASE "WHILE"
		    Handle_While(MID$(line$, INSTR(line$, "WHILE") + 5))

		CASE "WEND"
		    WRITELN "}" TO g_CFILE

		CASE "BREAK"
		    WRITELN "break;" TO g_CFILE

		CASE "REPEAT"
		    WRITELN "do{" TO g_CFILE

		CASE  "UNTIL"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty UNTIL at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Convert to legal C code
			WRITELN "} while(!(", MID$(line$, INSTR(line$, "UNTIL") + 5), "));" TO g_CFILE
		    END IF

		CASE "LET"
		    Handle_Let(MID$(line$, INSTR(line$, "LET") + 3))

		CASE "SYSTEM"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty SYSTEM at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			WRITELN "SYSTEM (", MID$(line$, INSTR(line$, "SYSTEM") + 6), ");" TO g_CFILE
		    END IF

		CASE "SLEEP"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty SLEEP at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			WRITELN "usleep(", MID$(line$, INSTR(line$, "SLEEP") + 5), "*1000);" TO g_CFILE
		    END IF

		CASE "OPEN"
		    Handle_Open(MID$(line$, INSTR(line$, "OPEN") + 4))

		CASE "CLOSE"
		    ' Check argument
		    IF dim NE 3 THEN
			PRINT NL$, "ERROR: erroneous CLOSE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			IF EQUAL(element$[1], "FILE") THEN
			    WRITELN "fclose(", element$[2], ");" TO g_CFILE
			ELIF EQUAL(element$[1], "DIRECTORY") THEN
			    WRITELN "closedir(", element$[2], ");" TO g_CFILE
			ELIF EQUAL(element$[1], "MEMORY") THEN
			    WRITELN element$[2], " = NULL;" TO g_CFILE
			ELIF EQUAL(element$[1], "NETWORK") OR EQUAL(element$[1], "SERVER") THEN
			    WRITELN "close(", element$[2], ");" TO g_CFILE
			END IF
		    END IF

		CASE "REWIND"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty REWIND at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			WRITELN "rewind(", element$[1], ");" TO g_CFILE
		    END IF

		CASE "MEMREWIND"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty MEMREWIND at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			WRITELN element$[1], " = (char*)__b2c_mem_", element$[1], ";" TO g_CFILE
		    END IF

		CASE "SEEK"
		    Handle_Seek(MID$(line$, INSTR(line$, "SEEK") + 4))

		CASE "READLN"
		    Handle_Readln(MID$(line$, INSTR(line$, "READLN") + 6))

		CASE "WRITELN"
		    Handle_Writeln(MID$(line$, INSTR(line$, "WRITELN") + 7))

		CASE "GETBYTE"
		    Handle_Getbyte(MID$(line$, INSTR(line$, "GETBYTE") + 7))

		CASE "PUTBYTE"
		    Handle_Putbyte(MID$(line$, INSTR(line$, "PUTBYTE") + 7))

		CASE "GETFILE"
		    Handle_Getfile(MID$(line$, INSTR(line$, "GETFILE") + 7))

		CASE "GETLINE"
		    Handle_Getline(MID$(line$, INSTR(line$, "GETLINE") + 7))

		CASE "PUTLINE"
		    Handle_Putline(MID$(line$, INSTR(line$, "PUTLINE") + 7))

		CASE "END"
		    IF dim > 1 THEN
			IF EQUAL(element$[1], "IF") THEN
			    WRITELN "}" TO g_CFILE
			ELIF EQUAL(element$[1], "RECORD") THEN
			    IF LEN(g_FUNCNAME$) > 0 THEN
				WRITELN "};" TO g_CFILE
				WRITELN "struct ", g_RECORDNAME$, " ", g_RECORDVAR$, " = { } ;" TO g_CFILE
			    ELSE
				WRITELN "};" TO g_HFILE
				WRITELN "struct ", g_RECORDNAME$, " ", g_RECORDVAR$, " = { } ;" TO g_HFILE
			    END IF
			    g_RECORDNAME$ = ""
			    g_RECORDVAR$ = ""
			ELIF EQUAL(element$[1], "FUNCTION") THEN
			    Handle_Endfunction
			ELIF EQUAL(element$[1], "SUB") THEN
			    Handle_Endsub
			ELIF EQUAL(element$[1], "WITH") THEN
			    g_WITHVAR$ = ""
			ELIF EQUAL(element$[1], "SELECT") THEN
			    WRITELN "}" TO g_CFILE
			    g_SELECTVAR$ = ""
			    g_IN_CASE = 0
			ELSE
			    WRITELN "exit(", element$[1], ");" TO g_CFILE
			END IF
		    ELSE
			WRITELN "exit(EXIT_SUCCESS);" TO g_CFILE
		    END IF

		CASE "SUB"
		    Handle_SubFunc(MID$(line$, INSTR(line$, "SUB") + 3))

		CASE "ENDSUB"
		    Handle_Endsub

		CASE "ENDWITH"
		    g_WITHVAR$ = ""

		CASE "ENDSELECT"
		    WRITELN "}" TO g_CFILE
		    g_SELECTVAR$ = ""
		    g_IN_CASE = 0

		CASE "CALL"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty CALL at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			IF dim >= 4 THEN
			    WRITELN MID$(line$, INSTR(line$, " TO") + 3), "=" TO g_CFILE
			    IF INSTR(line$, "(") THEN
				WRITELN MID$(line$, INSTR(line$, "CALL ") + 5, INSTR(line$, " TO") - 6), ";" TO g_CFILE
				exp$ = MID$(line$, INSTR(line$, "CALL ") + 5, INSTR(line$, "(") - 6)
			    ELSE
				WRITELN MID$(line$, INSTR(line$, "CALL ") + 5, INSTR(line$, " TO") - 6), "();" TO g_CFILE
				exp$ = MID$(line$, INSTR(line$, "CALL ") + 5, INSTR(line$, " TO") - 6)
			    END IF
			    IF NOT(INSTR(g_INCLUDE_FILES$, exp$)) THEN
				g_INCLUDE_FILES$ = CONCAT$(LEFT$(g_CURFILE$, INSTR(g_CURFILE$, ".bac")), exp$, ".h ", g_INCLUDE_FILES$)
			    END IF
			ELSE
			    IF INSTR(line$, "(") THEN
				WRITELN MID$(line$, INSTR(line$, "CALL ") + 5), ";" TO g_CFILE
				exp$ = MID$(line$, INSTR(line$, "CALL ") + 5, INSTR(line$, "(") - 6)
			    ELSE
				WRITELN MID$(line$, INSTR(line$, "CALL ") + 5), "();" TO g_CFILE
				exp$ = MID$(line$, INSTR(line$, "CALL ") + 5)
			    END IF
			    IF NOT(INSTR(g_INCLUDE_FILES$, exp$)) THEN
				g_INCLUDE_FILES$ = CONCAT$(LEFT$(g_CURFILE$, INSTR(g_CURFILE$, ".bac")), exp$, ".h ", g_INCLUDE_FILES$)
			    END IF
			END IF
		    END IF

		CASE "FUNCTION"
		    Handle_SubFunc(MID$(line$, INSTR(line$, "FUNCTION") + 8))

		CASE "ENDFUNCTION"
		    Handle_Endfunction

		CASE "RETURN"
		    Handle_Return(MID$(line$, INSTR(line$, "RETURN") + 6))

		CASE "IMPORT"
		    Handle_Import(MID$(line$, INSTR(line$, "IMPORT") + 6))

		CASE "DECLARE"
		    Handle_Declare(MID$(line$, INSTR(line$, "DECLARE") + 7))

		CASE "GLOBAL"
		    Handle_Declare(MID$(line$, INSTR(line$, "GLOBAL") + 6))

		CASE "LOCAL"
		    Handle_Local(MID$(line$, INSTR(line$, "LOCAL") + 5))

		CASE "DATA"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty DATA at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			IF INSTR(MID$(line$, INSTR(line$, "DATA") + 4), "\"") THEN
			    WRITELN MID$(line$, INSTR(line$, "DATA") + 4), ", " TO STRINGARRAYFILE
			ELSE
			    ' Check if float
			    IF INSTR(MID$(line$, INSTR(line$, "DATA") + 4), ".") THEN
				WRITELN MID$(line$, INSTR(line$, "DATA") + 4), ", " TO FLOATARRAYFILE
			    ELSE
				WRITELN MID$(line$, INSTR(line$, "DATA") + 4), ", " TO INTARRAYFILE
			    END IF
			END IF
		    END IF

		CASE "RESTORE"
		    WRITELN "if(__b2c__intarray_ptr > 0) __b2c__intarray_ptr = 0;" TO g_CFILE
		    WRITELN "if(__b2c__floatarray_ptr > 0) __b2c__floatarray_ptr = 0;" TO g_CFILE
		    WRITELN "if(__b2c__stringarray_ptr > 0) __b2c__stringarray_ptr = 0;" TO g_CFILE

		CASE "READ"
		    Handle_Read(CHOP$(MID$(line$, INSTR(line$, "READ") + 4)))

		CASE "PUSH"
		    Handle_Push(CHOP$(MID$(line$, INSTR(line$, "PUSH") + 4)))

		CASE "PULL"
		    Handle_Pull(CHOP$(MID$(line$, INSTR(line$, "PULL") + 4)))

		CASE "SEED"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty DATA at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			WRITELN "srandom((unsigned int)", element$[1], ");" TO g_CFILE
		    END IF

		CASE "DEF"
		    Handle_Deffn(CHOP$(MID$(line$, INSTR(line$, "DEF") + 3)))

		CASE "CONST"
		    Handle_Const(CHOP$(MID$(line$, INSTR(line$, "CONST") + 5)))

		CASE "INCLUDE"
		    ' Get rid of doublequotes if they are there
		    inc$ = REPLACE$((CHOP$(MID$(line$, INSTR(line$, " ") + 1))), "\"", "")

		    ' Check argument
		    IF ISFALSE(FILETYPE(inc$)) OR dim EQ 1 THEN
			PRINT NL$, "ERROR: missing file for INCLUDE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Start walking through program
			copy_counter = g_COUNTER
			g_COUNTER = 1
			' Assign new file
			copy_curfile$ = g_CURFILE$
			' Get rid of absolute path
			g_CURFILE$ = MID$(inc$, INSTRREV(inc$, "/") + 1)

			OPEN inc$ FOR READING AS newfile
			WHILE NOT(ENDFILE(newfile)) DO
			    PRINT "\rStarting conversion... ", g_COUNTER, " ";
			    READLN txt$ FROM newfile
			    ' Line is not empty?
			    IF NOT(ENDFILE(newfile)) AND LEN(txt$) > 0 THEN
				IF EQUAL(RIGHT$(txt$, 2), CONCAT$(" ", CHR$(92))) AND NOT(EQUAL(LEFT$(txt$, 3), "REM")) AND NOT(EQUAL(LEFT$(txt$, 1), "'")) THEN
				    total$ = CONCAT$(total$, LEFT$(txt$, LEN(txt$)-2))
				ELSE
				    Parse_Line(CHOP$(CONCAT$(total$, txt$)))
				    LET total$ = ""
				END IF
			    ENDIF
			    g_COUNTER = g_COUNTER + 1
			WEND
			CLOSE FILE newfile

			' Restore original counter
			g_COUNTER = copy_counter
			' Restore original file
			g_CURFILE$ = copy_curfile$
		    END IF

		CASE "POKE"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty POKE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Resolve this with C macro because of casting to (char)
			WRITELN "POKE(", MID$(line$, INSTR(line$, "POKE") + 4), ");" TO g_CFILE
		    END IF

		CASE "RESIZE"
		   ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty RESIZE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Resolve this with C macro because of casting to (char)
			WRITELN "RESIZE(", element$[1], ");" TO g_CFILE
		    END IF

		CASE "COPY"
		    Handle_Copy(MID$(line$, INSTR(line$, "COPY") + 4))

		CASE "DELETE"
		   ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty DELETE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Translate to C function
			IF EQUAL(element$[1], "FILE") THEN
			    WRITELN "if (unlink(", MID$(line$, INSTR(line$, " FILE ") + 6), ")==-1){if(!__b2c__trap){ERROR = 7;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
			ELIF EQUAL(element$[1], "DIRECTORY") THEN
			    WRITELN "if (rmdir(", MID$(line$, INSTR(line$, " DIRECTORY ") + 11), ") == -1){if(!__b2c__trap){ERROR = 20;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
			ELSE
			    PRINT NL$, "ERROR: erronuous argument for DELETE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			    END 1
			END IF
		    END IF

		CASE "RENAME"
		    Handle_Rename(MID$(line$, INSTR(line$, "RENAME") + 6))

		CASE "MAKEDIR"
		   ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty MAKEDIR at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Translate to C function
			WRITELN "if(mkdir(", MID$(line$, INSTR(line$, "MAKEDIR") + 7), ", S_IRWXU|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH) == -1){if(!__b2c__trap){ERROR = 21;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
		    END IF

		CASE "CHANGEDIR"
		   ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty CHANGEDIR at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Translate to C function
			WRITELN "if(chdir(", MID$(line$, INSTR(line$, "CHANGEDIR") + 9), ") == -1){if(!__b2c__trap) {ERROR = 22;if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} }" TO g_CFILE
		    END IF

		CASE "FREE"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty FREE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Translate to C function
			WRITELN "if(!__b2c__trap){__b2c__memory__check((char *)", element$[1], ");" TO g_CFILE
			WRITELN "if(ERROR) {if(!__b2c__catch_set){fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} if(!setjmp(__b2c__jump)) goto ", g_CATCHGOTO$, ";} } free((void*)", element$[1], ");" TO g_CFILE
		    END IF

		CASE "GOTO"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty GOTO at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Translate to C label
			WRITELN "goto ", element$[1], ";" TO g_CFILE
		    END IF

		CASE "LABEL"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty LABEL at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Translate to C label
			WRITELN element$[1], ":" TO g_CFILE
			WRITELN ";" TO g_CFILE
		    END IF

		CASE "TRAP"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty TRAP at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			IF EQUAL(element$[1], "SYSTEM") THEN
			    WRITELN "/* Error catching is enabled */" TO g_CFILE
			    WRITELN "__b2c__trap = 1;" TO g_CFILE
			    WRITELN "signal(SIGILL, __b2c__catch_signal);" TO g_CFILE
			    WRITELN "signal(SIGABRT, __b2c__catch_signal);" TO g_CFILE
			    WRITELN "signal(SIGFPE, __b2c__catch_signal);" TO g_CFILE
			    WRITELN "signal(SIGSEGV, __b2c__catch_signal);" TO g_CFILE
			ELIF EQUAL(element$[1], "LOCAL") THEN
			    WRITELN "/* Error catching is disabled */" TO g_CFILE
			    WRITELN "__b2c__trap = 0;" TO g_CFILE
			    WRITELN "signal(SIGILL, SIG_DFL);" TO g_CFILE
			    WRITELN "signal(SIGABRT, SIG_DFL);" TO g_CFILE
			    WRITELN "signal(SIGFPE, SIG_DFL);" TO g_CFILE
			    WRITELN "signal(SIGSEGV, SIG_DFL);" TO g_CFILE
			ELSE
			    PRINT NL$, "ERROR: invalid argument for TRAP at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			    END 1
			END IF
		    END IF

		CASE "CATCH"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty CATCH at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELIF EQUAL(element$[1], "GOTO") THEN
			WRITELN "__b2c__catch_set = 1;" TO g_CFILE
			g_CATCHGOTO$ = element$[2]
		    ELIF EQUAL(element$[1], "RESET") THEN
			WRITELN "__b2c__catch_set = 0;" TO g_CFILE
		    ELSE
			PRINT NL$, "ERROR: CATCH without GOTO or RESET at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    END IF

		CASE "RESUME"
		    WRITELN "longjmp(__b2c__jump, 1);" TO g_CFILE

		CASE "CLEAR"
		    WRITELN "printf(\"\033[2J\"); printf(\"\033[0;0f\");" TO g_CFILE

		CASE "COLOR"
		    Handle_Color(MID$(line$, INSTR(line$, "COLOR") + 5))

		CASE "GOTOXY"
		    Handle_Gotoxy(MID$(line$, INSTR(line$, "GOTOXY") + 6))

		CASE "RECEIVE"
		    Handle_Receive(MID$(line$, INSTR(line$, "RECEIVE") + 7))

		CASE "SEND"
		    Handle_Send(MID$(line$, INSTR(line$, "SEND") + 4))

		CASE "RECORD"
		   ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty RECORD at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELIF ISTRUE(LEN(g_RECORDNAME$)) THEN
			PRINT NL$, "ERROR: cannot define a record within a record!"
			END 1
		    ELSE
			' Translate to C typedef struct
			IF ISTRUE(LEN(g_FUNCNAME$)) THEN
			    g_RECORDNAME$ = CONCAT$("RECORD_", g_FUNCNAME$, "_", STR$(g_COUNTER))
			    WRITELN "struct ", g_RECORDNAME$, "{" TO g_CFILE
			ELSE
			    g_RECORDNAME$ = CONCAT$("RECORD_", STR$(g_COUNTER))
			    WRITELN "struct ", g_RECORDNAME$, "{" TO g_HFILE
			END IF
			g_RECORDVAR$ = element$[1]
		    END IF

		CASE "WITH"
		   ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty WITH at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELIF ISTRUE(LEN(g_RECORDNAME$)) THEN
			PRINT NL$, "ERROR: cannot define a WITH within a WITH!"
			END 1
		    ELSE
			g_WITHVAR$ = element$[1]
		    END IF

		CASE "SPLIT"
		    Handle_Split(MID$(line$, INSTR(line$, "SPLIT") + 5))

		CASE "SELECT"
		   ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty SELECT at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELIF ISTRUE(LEN(g_SELECTVAR$)) THEN
			PRINT NL$, "ERROR: cannot define a SELECT within a SELECT!"
			END 1
		    ELSE
			g_SELECTVAR$ = MID$(line$, INSTR(line$, "SELECT") + 6)
			g_IN_CASE = 0
			g_CASE_FALL$ = ""
		    END IF

		CASE "CASE"
		   ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty CASE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			IF ISTRUE(g_IN_CASE) THEN
			    IF INSTR(g_SELECTVAR$, "$") THEN
				IF EQUAL(RIGHT$(line$, 1), ";") THEN
				    exp$ = MID$(line$, INSTR(line$, "CASE") + 4)
				    g_CASE_FALL$ = CONCAT$("|| !strcmp(", g_SELECTVAR$, ", ", LEFT$(exp$, LEN(exp$)-1), ") ", g_CASE_FALL$)
				ELSE
				    WRITELN "} else if (!strcmp(", g_SELECTVAR$, ", ", MID$(line$, INSTR(line$, "CASE") + 4), ") ", g_CASE_FALL$, "){" TO g_CFILE
				END IF
			    ELSE
				IF EQUAL(RIGHT$(line$, 1), ";") THEN
				    exp$ = MID$(line$, INSTR(line$, "CASE") + 4)
				    g_CASE_FALL$ = CONCAT$("|| ", g_SELECTVAR$, " == (", LEFT$(exp$, LEN(exp$)-1), ")", g_CASE_FALL$)
				ELSE
				    WRITELN "} else if (", g_SELECTVAR$, " == (", MID$(line$, INSTR(line$, "CASE") + 4), ") ", g_CASE_FALL$, "){" TO g_CFILE
				END IF
			    END IF
			ELSE
			    IF INSTR(g_SELECTVAR$, "$") THEN
				IF EQUAL(RIGHT$(line$, 1), ";") THEN
				    exp$ = MID$(line$, INSTR(line$, "CASE") + 4)
				    g_CASE_FALL$ = CONCAT$("|| !strcmp(", g_SELECTVAR$, ", ", LEFT$(exp$, LEN(exp$)-1), ") ", g_CASE_FALL$)
				ELSE
				    WRITELN "if (!strcmp(", g_SELECTVAR$, ", ", MID$(line$, INSTR(line$, "CASE") + 4),") ", g_CASE_FALL$, "){" TO g_CFILE
				    g_IN_CASE = 1
				END IF
			    ELSE
				IF EQUAL(RIGHT$(line$, 1), ";") THEN
				    exp$ = MID$(line$, INSTR(line$, "CASE") + 4)
				    g_CASE_FALL$ = CONCAT$("|| ", g_SELECTVAR$, " == (", LEFT$(exp$, LEN(exp$)-1), ")", g_CASE_FALL$)
				ELSE
				    WRITELN "if (", g_SELECTVAR$, " == (", MID$(line$, INSTR(line$, "CASE") + 4), ") ", g_CASE_FALL$, "){" TO g_CFILE
				    g_IN_CASE = 1
				END IF
			    END IF
			END IF
		    END IF

		CASE "DEFAULT"
		    IF ISTRUE(g_IN_CASE) THEN
			WRITELN "} else {" TO g_CFILE
		    ELSE
			PRINT NL$, "ERROR: cannot use DEFAULT without previous CASE at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    END IF
		    g_IN_CASE = 0
		    g_CASE_FALL$ = ""

		CASE "SETENVIRON"
		    ' Check argument
		    IF dim EQ 1 THEN
			PRINT NL$, "ERROR: empty SETENVIRON at line ", STR$(g_COUNTER), " in file ", g_CURFILE$, "!"
			END 1
		    ELSE
			' Resolve this with C macro
			WRITELN "SETENVIRON(", MID$(line$, INSTR(line$, "SETENVIRON") + 10), ");" TO g_CFILE
		    END IF

		CASE "SORT"
		    Handle_Sort(CHOP$(MID$(line$, INSTR(line$, "SORT") + 4)))

		DEFAULT
		    ' Check on imported symbols first
		    IF INSTR(element$[0], "(") THEN
			element$[0] = LEFT$(element$[0], INSTR(element$[0], "(") - 1)
		    END IF

		    SPLIT g_IMPORTED$ BY " " TO sym$ SIZE dim
		    found = FALSE

		    FOR i = 0 TO dim - 1

			IF EQUAL(sym$[i], element$[0]) THEN
			    IF REGEX(statement$, "\\(.*\\)") THEN
				WRITELN statement$, ";" TO g_CFILE
			    ELSE
				WRITELN statement$, "();" TO g_CFILE
			    END IF
			    found = TRUE
			    BREAK
			END IF
		    NEXT
		    ' Not an imported symbol? Check if assignment
		    IF NOT(found) THEN
			Handle_Let(statement$)
		    END IF
	    END SELECT
	END IF
    END IF

END SUB

'----------------------------------------------------------------------------------------------
'
' Main program
'
'----------------------------------------------------------------------------------------------

' Default BACON settings
LET g_MAX_DIGITS = 32

' Maximum of internal buffers needed for string processing
LET g_MAX_BUFFERS = 32

' This is the size for static buffers like fgets, read etc.
LET g_BUFFER_SIZE = 512

' Maximum RETURN buffers
LET g_MAX_RBUFFERS = 8

LET g_NO_COMPILE = 0
LET g_STACK_DEPTH = 8
LET g_TMP_PRESERVE = 0
LET g_USE_C = 0
LET g_MAX_BACKLOG = 4
LET g_CPP = 0
LET g_SHEBANG = FALSE

g_TEMPDIR$ = "."
g_CCNAME$ = "cc"
g_CCFLAGS$ = ""
g_INCFILES$ = ""
g_INCLUDE_FILES$ = ""

' Some global declarations
g_CURFILE$ = ""
g_FUNCNAME$ = ""
g_FUNCTYPE$ = ""
g_TMP_FILES$ = ""
g_LOCALSTRINGS$ = ""
g_STRINGARRAYS$ = ""
g_STRINGARGS$ = ""

' Always create a final label
g_CATCHGOTO$ = "__B2C__PROGRAM__EXIT"

' Records
g_RECORDNAME$ = ""
g_RECORDVAR$ = ""
g_WITHVAR$ = ""

SPLIT ARGUMENT$ BY " " TO args$ SIZE amount

IF amount < 2 THEN
    PRINT "ERROR: no filename? Run with '-h' to see usage."
    END
ENDIF

i = 1

WHILE i < amount DO

    SELECT args$[i]

	' Compiler option
	CASE "-c"
	    i = i + 1
	    IF LEN(args$[i]) > 0 THEN
		g_CCNAME$ = args$[i]
	    END IF

	' Include option
	CASE "-i"
	    i = i + 1
	    IF LEN(args$[i]) > 0 THEN
		IF INSTR(args$[i], "<") THEN
		    g_INCFILES$ = CONCAT$("#include ", args$[i], "\n", g_INCFILES$)
		ELSE
		    g_INCFILES$ = CONCAT$("#include \"", args$[i], "\"\n", g_INCFILES$)
		END IF
	    END IF

	' Library option
	CASE "-l"
	    i = i + 1
	    IF LEN(args$[i]) > 0 THEN
		g_LDFLAGS$ = CONCAT$(args$[i], " ", g_LDFLAGS$)
	    END IF

	' Buffer size
	CASE "-m"
	    i = i + 1
	    IF LEN(args$[i]) > 0 THEN
		g_BUFFER_SIZE = VAL(args$[i])
	    END IF

	' Stack depth
	CASE "-s"
	    i = i + 1
	    IF LEN(args$[i]) > 0 THEN
		g_STACK_DEPTH = VAL(args$[i])
	    END IF

	' Temporary directory
	CASE "-d"
	    i = i + 1
	    IF LEN(args$[i]) > 0 THEN
		g_TEMPDIR$ = args$[i]
	    END IF

	' Help option
	CASE "-h";
	CASE "-?"
	    PRINT NL$, "USAGE: bacon [options] program[.bac]"
	    PRINT NL$, "OPTIONS:"
	    PRINT NL$, " -c <compiler>", TAB$(1), "Compiler to use (default: ", g_CCNAME$, ")"
	    PRINT " -i <include>", TAB$(1), "Add include file to C code"
	    PRINT " -l <library>", TAB$(1), "Pass library to linker"
	    PRINT " -m <value>", TAB$(1), "Max temporary buffers (default: ", STR$(g_MAX_BUFFERS), ")"
	    PRINT " -s <value>", TAB$(1), "Depth of stack (default: ", STR$(g_STACK_DEPTH), ")"
	    PRINT " -d <tmpdir>", TAB$(1), "Temporary directory (default: ", g_TEMPDIR$, ")"
	    PRINT " -n ", TAB$(2), "Do not compile automatically"
	    PRINT " -j ", TAB$(2), "Invoke C Preprocessor"
	    PRINT " -p ", TAB$(2), "Preserve temporary files"
	    PRINT " -o ", TAB$(2), "Optimize binary for current platform"
	    PRINT " -a ", TAB$(2), "Force 32bit compilation"
	    PRINT " -g ", TAB$(2), "Compile with debug info"
	    PRINT " -w ", TAB$(2), "Show all warnings during compilation"
	    PRINT " -b ", TAB$(2), "Execute from shebang"
	    PRINT " -v ", TAB$(2), "Show version"
	    PRINT " -h ", TAB$(2), "Show help"
	    PRINT
	    END

	' Version option
	CASE "-v"
	    PRINT
	    PRINT "BaCon version ", g_VERSION$, " - (c) Peter van Eerten - GPL v3."
	    PRINT
	    END

	' Preserve option
	CASE "-p"
	    g_TMP_PRESERVE = 1

	' No compile option
	CASE "-n"
	    g_NO_COMPILE = 1

	' Invoke C Preprocessor
	CASE "-j"
	    g_CPP = 1

	' Debug option
	CASE "-g"
	    g_CCFLAGS$ = CONCAT$(g_CCFLAGS$, " -g") 

	' Warn option
	CASE "-w"
	    g_CCFLAGS$ = CONCAT$(g_CCFLAGS$, " -Wall") 

	' Optimize option
	CASE "-o"
	    g_CCFLAGS$ = CONCAT$(g_CCFLAGS$, " -mtune=native") 

	' 32bit mode
	CASE "-a"
	    g_CCFLAGS$ = CONCAT$(g_CCFLAGS$, " -m32") 

	' use shebang
	CASE "-b"
	    g_SHEBANG = TRUE
	    g_TEMPDIR$ = "/tmp"

	' This is the sourcefile
	DEFAULT
	    g_SOURCEFILE$ = args$[i]

    END SELECT

    i = i + 1

WEND

IF NOT(EQUAL(RIGHT$(g_SOURCEFILE$, 4), ".bac")) THEN
    g_SOURCEFILE$ = CONCAT$(g_SOURCEFILE$, ".bac")
END IF

IF FILELEN(g_SOURCEFILE$) < 0 THEN
    PRINT "ERROR: file not found!"
    END ERROR
END IF

IF NOT(g_SHEBANG) THEN
    PRINT "Starting conversion...";
END IF

' Now create the global filenames where to write to
g_CFILE$ = CONCAT$(g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".c")
g_HFILE$ = CONCAT$(g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".h")
STRINGARRAYFILE$ = CONCAT$(g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".string.h")
INTARRAYFILE$ = CONCAT$(g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".int.h")
FLOATARRAYFILE$ = CONCAT$(g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".float.h")

' Add to total file list
g_TMP_FILES$ = CONCAT$(g_TMP_FILES$, " ", g_CFILE$)
g_TMP_FILES$ = CONCAT$(g_TMP_FILES$, " ", g_HFILE$)
g_TMP_FILES$ = CONCAT$(g_TMP_FILES$, " ", STRINGARRAYFILE$)
g_TMP_FILES$ = CONCAT$(g_TMP_FILES$, " ", INTARRAYFILE$)
g_TMP_FILES$ = CONCAT$(g_TMP_FILES$, " ", FLOATARRAYFILE$)

' Create new sourcefile
OPEN g_CFILE$ FOR WRITING AS g_CFILE

' Create basic C file
WRITELN "/* Created with BaCon ", g_VERSION$, " - Peter van Eerten 2009 */" TO g_CFILE
WRITELN "#include \"", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".h\"" TO g_CFILE
WRITELN "int main(int argc, const char **argv)" TO g_CFILE
WRITELN "{" TO g_CFILE
WRITELN "/* Default is: system traps signals */" TO g_CFILE
WRITELN "signal(SIGILL, __b2c__catch_signal);" TO g_CFILE
WRITELN "signal(SIGABRT, __b2c__catch_signal);" TO g_CFILE
WRITELN "signal(SIGFPE, __b2c__catch_signal);" TO g_CFILE
WRITELN "signal(SIGSEGV, __b2c__catch_signal);" TO g_CFILE
WRITELN "/* Make sure internal string buffers are empty */" TO g_CFILE
WRITELN "for(__b2c__sbuffer_ptr=0; __b2c__sbuffer_ptr < ", STR$(g_MAX_BUFFERS), "; __b2c__sbuffer_ptr++) __b2c__sbuffer[__b2c__sbuffer_ptr] = NULL;" TO g_CFILE
WRITELN "__b2c__sbuffer_ptr=0;" TO g_CFILE
WRITELN "for(__b2c__stackptr=0; __b2c__stackptr < ", STR$(g_STACK_DEPTH), "; __b2c__stackptr++) __b2c__stringstack[__b2c__stackptr] = NULL;" TO g_CFILE
WRITELN "__b2c__stackptr=0;" TO g_CFILE
WRITELN "for(__b2c__rbuffer_ptr=0; __b2c__rbuffer_ptr < ", STR$(g_MAX_RBUFFERS), "; __b2c__rbuffer_ptr++) __b2c__rbuffer[__b2c__rbuffer_ptr] = NULL;" TO g_CFILE
WRITELN "__b2c__rbuffer_ptr=0;" TO g_CFILE

' Put arguments into reserved variable ARGUMENT
WRITELN "/* Setup the reserved variable 'ARGUMENT' */" TO g_CFILE
WRITELN "for(__b2c__counter=0; __b2c__counter < argc; __b2c__counter++)" TO g_CFILE
WRITELN "{__b2c__arglen += strlen(argv[__b2c__counter]) + 1;} __b2c__arglen++;" TO g_CFILE
WRITELN "ARGUMENT$ = (char*)malloc(__b2c__arglen*sizeof(char)); strcpy(ARGUMENT$, \"\");" TO g_CFILE
WRITELN "for(__b2c__counter=0; __b2c__counter < argc; __b2c__counter++)" TO g_CFILE
WRITELN "{strcat(ARGUMENT$, argv[__b2c__counter]); if(__b2c__counter != argc - 1) strcat(ARGUMENT$, \" \");}" TO g_CFILE
WRITELN "/* Rest of the program */" TO g_CFILE

' Create new headerfile
OPEN g_HFILE$ FOR WRITING AS g_HFILE

' Create basic H file, functions are converted using macros
WRITELN "/* Created with BaCon ", g_VERSION$, " - Peter van Eerten 2009 */" TO g_HFILE
WRITELN "#include <stdio.h>" TO g_HFILE
WRITELN "#include <stdlib.h>" TO g_HFILE
WRITELN "#include <stdarg.h>" TO g_HFILE
WRITELN "#include <sys/time.h>" TO g_HFILE
WRITELN "#include <sys/stat.h>" TO g_HFILE
WRITELN "#include <sys/types.h>" TO g_HFILE
WRITELN "#include <sys/socket.h>" TO g_HFILE
WRITELN "#include <sys/utsname.h>" TO g_HFILE
WRITELN "#include <dirent.h>" TO g_HFILE
WRITELN "#include <setjmp.h>" TO g_HFILE
WRITELN "#include <netdb.h>" TO g_HFILE
IF INSTR(OS$, "BSD") THEN
    WRITELN "#include <netinet/in.h>" TO g_HFILE
END IF
WRITELN "#include <signal.h>" TO g_HFILE
WRITELN "static jmp_buf __b2c__jump;" TO g_HFILE
WRITELN "static int __b2c__trap = 1;" TO g_HFILE
WRITELN "static int __b2c__catch_set = 0;" TO g_HFILE
WRITELN "static int ERROR = 0;" TO g_HFILE
WRITELN "const char VERSION$[] = \"", g_VERSION$, "\";" TO g_HFILE

' Add user include files
WRITELN "/* User include files */" TO g_HFILE
WRITELN g_INCFILES$ TO g_HFILE

WRITELN "/* READ/DATA include files */" TO g_HFILE
WRITELN "int __b2c__stringarray_ptr = 0;" TO g_HFILE
WRITELN "#include \"", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".string.h\"" TO g_HFILE
WRITELN "int __b2c__intarray_ptr = 0;" TO g_HFILE
WRITELN "#include \"", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".int.h\"" TO g_HFILE
WRITELN "int __b2c__floatarray_ptr = 0;" TO g_HFILE
WRITELN "#include \"", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".float.h\"" TO g_HFILE
WRITELN "int __b2c__ctr;" TO g_HFILE

WRITELN "/* Math functions */" TO g_HFILE
WRITELN "extern double round(double __b2c__x);" TO g_HFILE
WRITELN "extern long int lrint(double __b2c__x);" TO g_HFILE
WRITELN "#include <math.h>" TO g_HFILE
WRITELN "#define SQR(__b2c__x) sqrt(__b2c__x)" TO g_HFILE
WRITELN "#define POW(__b2c__x, __b2c__y) pow(__b2c__x, __b2c__y)" TO g_HFILE
WRITELN "#define SIN(__b2c__x) sin(__b2c__x)" TO g_HFILE
WRITELN "#define COS(__b2c__x) cos(__b2c__x)" TO g_HFILE
WRITELN "#define TAN(__b2c__x) tan(__b2c__x)" TO g_HFILE
WRITELN "#define ROUND(__b2c__x) lrint(__b2c__x)" TO g_HFILE
WRITELN "#define INT(__b2c__x) lrint(__b2c__x)" TO g_HFILE
WRITELN "#define MOD(__b2c__x, __b2c__y) (__b2c__x % __b2c__y)" TO g_HFILE
WRITELN "#define EVEN(__b2c__x) ((__b2c__x % 2 == 0) ? 1 : 0)" TO g_HFILE
WRITELN "#define ODD(__b2c__x) ((__b2c__x % 2 != 0) ? 1 : 0)" TO g_HFILE
WRITELN "#define FLOOR(__b2c__x) (long)floor(__b2c__x)" TO g_HFILE
WRITELN "#define ABS(__b2c__x) abs(__b2c__x)" TO g_HFILE
WRITELN "#define RND random()" TO g_HFILE
WRITELN "#define MAXRANDOM RAND_MAX" TO g_HFILE
WRITELN "/* Other functions */" TO g_HFILE
WRITELN "#define VAL(__b2c__x) ((__b2c__x != NULL) ? atof(__b2c__x) : 0)" TO g_HFILE
WRITELN "/* Unix functions */" TO g_HFILE
WRITELN "#include <unistd.h>" TO g_HFILE
WRITELN "#define SYSTEM(__b2c__x) ((__b2c__x != NULL) ? system(__b2c__x) : 0)" TO g_HFILE
WRITELN "/* String functions */" TO g_HFILE
WRITELN "#include <string.h>" TO g_HFILE
WRITELN "char __b2c__input__buffer[", STR$(g_BUFFER_SIZE), "];" TO g_HFILE
WRITELN "char* __b2c__sbuffer[", STR$(g_MAX_BUFFERS), "];" TO g_HFILE
WRITELN "int __b2c__sbuffer_ptr;" TO g_HFILE
WRITELN "char* __b2c__rbuffer[", STR$(g_MAX_RBUFFERS), "];" TO g_HFILE
WRITELN "int __b2c__rbuffer_ptr;" TO g_HFILE
WRITELN "/* Temporary pointer to perform assignments */" TO g_HFILE
WRITELN "char *__b2c__assign = NULL;" TO g_HFILE
WRITELN "char *__b2c__split = NULL; char *__b2c__split_tmp = NULL;" TO g_HFILE
WRITELN "char *ERR$(int);" TO g_HFILE
WRITELN "/* Functions for sort */" TO g_HFILE
WRITELN "int __b2c__sortnrd(const void *__b2c__a, const void *__b2c__b)" TO g_HFILE
WRITELN "{if (*(double*)__b2c__a==*(double*)__b2c__b) return 0; else if (*(double*)__b2c__a < *(double*)__b2c__b) return -1; else return 1;}" TO g_HFILE
WRITELN "int __b2c__sortnrf(const void *__b2c__a, const void *__b2c__b)" TO g_HFILE
WRITELN "{if (*(float*)__b2c__a==*(float*)__b2c__b) return 0; else if (*(float*)__b2c__a < *(float*)__b2c__b) return -1; else return 1;}" TO g_HFILE
WRITELN "int __b2c__sortnrl(const void *__b2c__a, const void *__b2c__b)" TO g_HFILE
WRITELN "{if (*(long*)__b2c__a==*(long*)__b2c__b) return 0; else if (*(long*)__b2c__a < *(long*)__b2c__b) return -1; else return 1;}" TO g_HFILE
WRITELN "int __b2c__sortnri(const void *__b2c__a, const void *__b2c__b)" TO g_HFILE
WRITELN "{if (*(int*)__b2c__a==*(int*)__b2c__b) return 0; else if (*(int*)__b2c__a < *(int*)__b2c__b) return -1; else return 1;}" TO g_HFILE
WRITELN "int __b2c__sortstr(const void *__b2c__a, const void *__b2c__b)" TO g_HFILE
WRITELN "{return strcmp(*(char **) __b2c__a, *(char **) __b2c__b);}" TO g_HFILE
WRITELN "/* Actual functions */" TO g_HFILE
WRITELN "char* __b2c__curdir(void){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_BUFFER_SIZE), "*sizeof(char));" TO g_HFILE
WRITELN "return (getcwd(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_BUFFER_SIZE), "));}" TO g_HFILE
WRITELN "#define CURDIR$ __b2c__curdir()" TO g_HFILE
WRITELN "char* __b2c__reverse(char *__b2c__s){int __b2c__i; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__s)+2)*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, strlen(__b2c__s)+1);" TO g_HFILE
WRITELN "for(__b2c__i=0;__b2c__i<strlen(__b2c__s);__b2c__i++){__b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__i]=__b2c__s[strlen(__b2c__s)-1-__b2c__i];}" TO g_HFILE
WRITELN "return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define REVERSE$(x) ((x != NULL) ? __b2c__reverse(x) : \"null\")" TO g_HFILE
WRITELN "char* __b2c__str(double d){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), "*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, ", STR$(g_MAX_DIGITS), ");" TO g_HFILE
WRITELN "if(floor(d) == d) snprintf(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%ld\", (long)d); else snprintf(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%g\", d);" TO g_HFILE
WRITELN "return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define STR$(x) __b2c__str(x)" TO g_HFILE
WRITELN "char* __b2c__concat(char *__b2c__first, ...){char *__b2c__tmp; va_list __b2c__ap; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "if(__b2c__first != NULL) { __b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__first)+1)*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, (strlen(__b2c__first)+1)*sizeof(char)); strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__first);}" TO g_HFILE
WRITELN "else {__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], 2*sizeof(char)); strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], \"\");} va_start(__b2c__ap, __b2c__first);" TO g_HFILE
WRITELN "while((__b2c__tmp = va_arg(__b2c__ap, char *)) != NULL) {__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__tmp)+strlen(__b2c__sbuffer[__b2c__sbuffer_ptr])+1)*sizeof(char));" TO g_HFILE
WRITELN "strcat(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__tmp);} va_end(__b2c__ap); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define CONCAT$(...) __b2c__concat(__VA_ARGS__, (char*)NULL)" TO g_HFILE
WRITELN "char* __b2c__left(char *__b2c__src, long __b2c__n){if(__b2c__src == NULL || __b2c__n > strlen(__b2c__src) || __b2c__n < 0) return(__b2c__src);" TO g_HFILE
WRITELN "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__src)+1)*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, (strlen(__b2c__src)+1)*sizeof(char)); strncpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__src, (__b2c__n));" TO g_HFILE
WRITELN "return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define LEFT$(__b2c__x, __b2c__y) __b2c__left(__b2c__x, __b2c__y)" TO g_HFILE
WRITELN "char* __b2c__right(char *__b2c__src, long __b2c__n){if(__b2c__src == NULL || __b2c__n > strlen(__b2c__src) || __b2c__n < 0) return(__b2c__src);" TO g_HFILE
WRITELN "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__src)+1)*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, (strlen(__b2c__src)+1)*sizeof(char)); strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__src+ strlen(__b2c__src)- __b2c__n);" TO g_HFILE
WRITELN "return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define RIGHT$(__b2c__x, __b2c__y) __b2c__right(__b2c__x, __b2c__y)" TO g_HFILE
WRITELN "char* __b2c__mid(char *__b2c__src, ...){ va_list __b2c__ap; int __b2c__start, __b2c__end; if(__b2c__src == NULL) return(\"\");" TO g_HFILE
WRITELN "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__src)+1)*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, (strlen(__b2c__src)+1)*sizeof(char)); va_start(__b2c__ap, __b2c__src);" TO g_HFILE
WRITELN "__b2c__start = va_arg(__b2c__ap, long); if(__b2c__start < 1) return(__b2c__src); __b2c__end = va_arg(__b2c__ap, long); if((__b2c__end) == -1) __b2c__end = strlen(__b2c__src);" TO g_HFILE
WRITELN "strncpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__src+(long)(__b2c__start)-1, (__b2c__end)); va_end(__b2c__ap); return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define MID$(__b2c__string, ...) __b2c__mid(__b2c__string, __VA_ARGS__, -1)" TO g_HFILE
WRITELN "long __b2c__instr(char *__b2c__first, ...){char *__b2c__tmp; char *__b2c__res; int __b2c__pos; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "va_list __b2c__ap; if(__b2c__first == NULL) return (0); __b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__first)+1)*sizeof(char));" TO g_HFILE
WRITELN "strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__first); va_start(__b2c__ap, __b2c__first);" TO g_HFILE
WRITELN "__b2c__tmp = va_arg(__b2c__ap, char *); if(__b2c__tmp == NULL || strlen(__b2c__tmp) == 0) return (0);__b2c__pos = va_arg(__b2c__ap, int);" TO g_HFILE
WRITELN "if(__b2c__pos <= 0) __b2c__pos = 1; va_end(__b2c__ap); __b2c__res = strstr(__b2c__sbuffer[__b2c__sbuffer_ptr] + __b2c__pos - 1, __b2c__tmp);" TO g_HFILE
WRITELN "if(__b2c__res == NULL) return (0); return (__b2c__res - __b2c__sbuffer[__b2c__sbuffer_ptr] + 1);}" TO g_HFILE
WRITELN "#define INSTR(...) __b2c__instr(__VA_ARGS__, -1)" TO g_HFILE
WRITELN "long __b2c__instrrev(char *__b2c__first, ...){char *__b2c__tmp; char *__b2c__res = NULL; int __b2c__pos; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "va_list __b2c__ap; if(__b2c__first == NULL) return (0); __b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__first)+1)*sizeof(char));" TO g_HFILE
WRITELN "strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__first); va_start(__b2c__ap, __b2c__first);" TO g_HFILE
WRITELN "__b2c__tmp = va_arg(__b2c__ap, char *); if(__b2c__tmp == NULL || strlen(__b2c__tmp) == 0) return (0);__b2c__pos = va_arg(__b2c__ap, int);" TO g_HFILE
WRITELN "if(__b2c__pos <= 0) __b2c__pos = 1; va_end(__b2c__ap); while(__b2c__res == NULL && __b2c__pos < strlen(__b2c__sbuffer[__b2c__sbuffer_ptr])) {" TO g_HFILE
WRITELN "__b2c__res = strstr(__b2c__sbuffer[__b2c__sbuffer_ptr] + strlen(__b2c__sbuffer[__b2c__sbuffer_ptr]) - __b2c__pos - 1, __b2c__tmp); __b2c__pos+=1;}" TO g_HFILE
WRITELN "if(__b2c__res == NULL) return (0); return (__b2c__res - __b2c__sbuffer[__b2c__sbuffer_ptr] + 1);}" TO g_HFILE
WRITELN "#define INSTRREV(...) __b2c__instrrev(__VA_ARGS__, -1)" TO g_HFILE
WRITELN "char* __b2c__spc(int __b2c__x){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__x*sizeof(char)+1*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, __b2c__x*sizeof(char)+1*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 32, __b2c__x); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define SPC$(x) ((x > -1) ? __b2c__spc(x) : \"\")" TO g_HFILE
WRITELN "char* __b2c__tab(int __b2c__x){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__x*sizeof(char)+1*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, __b2c__x*sizeof(char)+1*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 9, __b2c__x); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define TAB$(x) ((x > -1) ? __b2c__tab(x) : \"\")" TO g_HFILE
WRITELN "char* __b2c__fill(unsigned long __b2c__x, unsigned char __b2c__y){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__x*sizeof(char)+1*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, __b2c__x*sizeof(char)+1*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__y, __b2c__x); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define FILL$(x, y) ((y > -1 && y < 256) ? __b2c__fill(x, y) : \"\")" TO g_HFILE
WRITELN "char* __b2c__chop(char *__b2c__src){char *__b2c__tmp; int __b2c__i; if(strlen(__b2c__src) == 0) return(__b2c__src);" TO g_HFILE
WRITELN "while ((*__b2c__src == 10 || *__b2c__src == 13 || *__b2c__src == 9 || *__b2c__src == 32) && *__b2c__src != '\\0') __b2c__src++;" TO g_HFILE
WRITELN "if (*__b2c__src == '\\0') return(\"\"); __b2c__tmp = __b2c__src + strlen(__b2c__src) - 1;" TO g_HFILE
WRITELN "while ((*__b2c__tmp == 10 || *__b2c__tmp == 13 || *__b2c__tmp == 9 || *__b2c__tmp == 32) && *__b2c__src != '\\0') __b2c__tmp--;" TO g_HFILE
WRITELN "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__src)+1)*sizeof(char));" TO g_HFILE
WRITELN "for(__b2c__i = 0; __b2c__i <= __b2c__tmp - __b2c__src; __b2c__i++) __b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__i]=__b2c__src[__b2c__i];" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__i] = '\\0'; return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define CHOP$(x) ((x != NULL) ? __b2c__chop(x) : 0)" TO g_HFILE
WRITELN "char* __b2c__replace(char* __b2c__x, char* __b2c__y, char* __b2c__z){" TO g_HFILE
WRITELN "char *__b2c__tmp, *__b2c__buf, *__b2c__haystack, *__b2c__dup = NULL; __b2c__sbuffer_ptr++;" TO g_HFILE
WRITELN "if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0; __b2c__haystack = strdup(__b2c__x); __b2c__dup = __b2c__haystack;" TO g_HFILE
WRITELN "__b2c__buf = strdup(\"\"); while((__b2c__tmp = strstr(__b2c__haystack, __b2c__y)) != NULL) {*__b2c__tmp = '\\0';" TO g_HFILE
WRITELN "__b2c__buf = realloc(__b2c__buf, (strlen(__b2c__buf) + strlen(__b2c__haystack) + strlen(__b2c__z) + 1)*sizeof(char));" TO g_HFILE
WRITELN "strcat(__b2c__buf, __b2c__haystack);strcat(__b2c__buf, __b2c__z);__b2c__haystack = __b2c__tmp+strlen(__b2c__y);}" TO g_HFILE
WRITELN "__b2c__buf = realloc(__b2c__buf, (strlen(__b2c__buf) + strlen(__b2c__haystack) + 1)*sizeof(char));strcat(__b2c__buf, __b2c__haystack);" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], (strlen(__b2c__buf)+1)*sizeof(char));" TO g_HFILE
WRITELN "strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__buf);free(__b2c__buf);free(__b2c__dup);return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define REPLACE$(x, y, z)((x!=NULL && y!=NULL && z!= NULL) ? __b2c__replace(x, y, z) : 0)" TO g_HFILE
WRITELN "#define LEN(x) ((x != NULL) ? strlen(x) : 0)" TO g_HFILE
WRITELN "#define EQUAL(__b2c__x, __b2c__y) ((__b2c__x != NULL && __b2c__y != NULL) ? !strcmp(__b2c__x, __b2c__y) : 0)" TO g_HFILE
WRITELN "char* __b2c__getenv(char *__b2c__env){static char* __b2c__tmp; __b2c__tmp = getenv(__b2c__env); if (__b2c__tmp == NULL)" TO g_HFILE
WRITELN "{return \"\";} return __b2c__tmp;}" TO g_HFILE
WRITELN "#define GETENVIRON$(x) ((x != NULL) ? __b2c__getenv(x) : \"null\")" TO g_HFILE
WRITELN "#define SETENVIRON(x, y) if(x != NULL && y != NULL) setenv(x, y, 1)" TO g_HFILE
WRITELN "/* CHAR functions */" TO g_HFILE
WRITELN "#include <ctype.h>" TO g_HFILE
WRITELN "char* __b2c__ucase(char *__b2c__s){int __b2c__i; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], strlen(__b2c__s)*sizeof(char)+1*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, strlen(__b2c__s)*sizeof(char)+1*sizeof(char));" TO g_HFILE
WRITELN "for(__b2c__i=0; __b2c__i < strlen(__b2c__s); __b2c__i++){__b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__i]=toupper(__b2c__s[__b2c__i]);}" TO g_HFILE
WRITELN "return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define UCASE$(x) ((x != NULL) ? __b2c__ucase(x) : \"null\")" TO g_HFILE
WRITELN "char* __b2c__lcase(char *__b2c__s){int __b2c__i; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], strlen(__b2c__s)*sizeof(char)+1*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, strlen(__b2c__s)*sizeof(char)+1*sizeof(char));" TO g_HFILE
WRITELN "for(__b2c__i=0; __b2c__i < strlen(__b2c__s); __b2c__i++){__b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__i]=tolower(__b2c__s[__b2c__i]);}" TO g_HFILE
WRITELN "return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define LCASE$(x) ((x != NULL) ? __b2c__lcase(x) : \"null\")" TO g_HFILE
WRITELN "/* I/O functions */" TO g_HFILE
WRITELN "FILE *__b2c__inFile; FILE *__b2c__outFile; int __b2c__Byte; struct dirent *__b2c__dir;" TO g_HFILE
WRITELN "char* __b2c__dec2hex(int __b2c__i){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ");" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, ", STR$(g_MAX_DIGITS), ");" TO g_HFILE
WRITELN "snprintf(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%X\", __b2c__i); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "unsigned int __b2c__hex2dec(char *__b2c__h){unsigned int __b2c__i; if(sscanf(__b2c__h, \"%X\", &__b2c__i) == EOF && !__b2c__trap){ERROR = 5;" TO g_HFILE
WRITELN "fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} return(int)(__b2c__i);}" TO g_HFILE
WRITELN "unsigned char __b2c__char2asc(char *__b2c__c){return (unsigned char)*__b2c__c;}" TO g_HFILE
WRITELN "char* __b2c__asc2char(int __b2c__i){__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], 2*sizeof(char));" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, 2*sizeof(char)); snprintf(__b2c__sbuffer[__b2c__sbuffer_ptr], 2, \"%c\", __b2c__i);" TO g_HFILE
WRITELN "return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "long __b2c__filelen(const char *__b2c__x) {struct stat __b2c__buf; if(__b2c__x == NULL || stat(__b2c__x, &__b2c__buf) < 0) return -1;" TO g_HFILE
WRITELN "if(stat(__b2c__x, &__b2c__buf) < 0 && !__b2c__trap){ERROR = 24; fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} return(long)(__b2c__buf.st_size);}" TO g_HFILE
WRITELN "#define FILELEN(x) __b2c__filelen(x)" TO g_HFILE
WRITELN "long __b2c__filetype(const char *__b2c__x) {struct stat __b2c__buf; if(__b2c__x == NULL) return 0; if(stat(__b2c__x, &__b2c__buf) < 0 && !__b2c__trap)" TO g_HFILE
WRITELN "{ERROR = 24; fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);}" TO g_HFILE
WRITELN "if (S_ISREG(__b2c__buf.st_mode)) return 1; if (S_ISDIR(__b2c__buf.st_mode)) return 2;" TO g_HFILE
WRITELN "if (S_ISCHR(__b2c__buf.st_mode)) return 3; if (S_ISBLK(__b2c__buf.st_mode)) return 4; if (S_ISFIFO(__b2c__buf.st_mode)) return 5;" TO g_HFILE
WRITELN "if (S_ISLNK(__b2c__buf.st_mode)) return 6; if (S_ISSOCK(__b2c__buf.st_mode)) return 7; return 0;}" TO g_HFILE
WRITELN "#define FILETYPE(x) __b2c__filetype(x)" TO g_HFILE
WRITELN "long __b2c__search(FILE* __b2c__x, char* __b2c__y){long __b2c__off; long __b2c__pos; char* __b2c__ptr;" TO g_HFILE
WRITELN "if(__b2c__x == NULL && !__b2c__trap){ERROR = 2; fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);}" TO g_HFILE
WRITELN "if(__b2c__y == NULL && !__b2c__trap){ERROR = 25; fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);}" TO g_HFILE
WRITELN "__b2c__pos = ftell(__b2c__x); __b2c__ptr = (char*)malloc((strlen(__b2c__y)+1)*sizeof(char)); __b2c__off = 0; do {" TO g_HFILE
WRITELN "fseek(__b2c__x, __b2c__off, SEEK_SET);memset(__b2c__ptr, 0, sizeof(char)*(strlen(__b2c__y)+1));" TO g_HFILE
WRITELN "fread(__b2c__ptr, sizeof(char), strlen(__b2c__y), __b2c__x);__b2c__off+=1;" TO g_HFILE
WRITELN "} while(!feof(__b2c__x) && strncmp(__b2c__ptr, __b2c__y, strlen(__b2c__y)));" TO g_HFILE
WRITELN "if(strncmp(__b2c__ptr, __b2c__y, strlen(__b2c__y))) __b2c__off = 0; fseek(__b2c__x, __b2c__pos, SEEK_SET); free(__b2c__ptr); return (--__b2c__off);}" TO g_HFILE
WRITELN "#define SEARCH(x, y) __b2c__search(x, y)" TO g_HFILE
WRITELN "char *__b2c__exec(char *__b2c__x){int __b2c__r, __b2c__len, __b2c__i, __b2c__page;int __b2c__wpipe[2], __b2c__rpipe[2];char *__b2c__ans = NULL;" TO g_HFILE
WRITELN "if (pipe (__b2c__rpipe) < 0 || pipe (__b2c__wpipe) < 0){if(!__b2c__trap) {ERROR=29;fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);}}" TO g_HFILE
WRITELN "if ((__b2c__r = fork ()) < 0){if(!__b2c__trap) {ERROR=29;fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);}} else if (__b2c__r == 0){" TO g_HFILE
WRITELN "close(__b2c__wpipe[1]);close (__b2c__rpipe[0]);dup2 (__b2c__wpipe[0], 0);close (__b2c__wpipe[0]);dup2 (__b2c__rpipe[1], 1);close (__b2c__rpipe[1]);system (__b2c__x);exit(EXIT_SUCCESS);}" TO g_HFILE
WRITELN "else{close (__b2c__wpipe[0]);close (__b2c__rpipe[1]);__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_BUFFER_SIZE), "*sizeof(char) + 1);__b2c__ans = (char*)malloc(", STR$(g_BUFFER_SIZE), " *sizeof(char));" TO g_HFILE
WRITELN "__b2c__len = 0;__b2c__page = 0;do{__b2c__i = read (__b2c__rpipe[0], __b2c__ans, ", STR$(g_BUFFER_SIZE), ");if (__b2c__i == -1 && !__b2c__trap){ERROR=30;fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);}" TO g_HFILE
WRITELN "if (__b2c__i == 0)break;if (__b2c__len + __b2c__i > ", STR$(g_BUFFER_SIZE), " *__b2c__page + 1){__b2c__page++;__b2c__sbuffer[__b2c__sbuffer_ptr] = realloc (__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_BUFFER_SIZE), "*__b2c__page + 1);" TO g_HFILE
WRITELN "if (__b2c__sbuffer[__b2c__sbuffer_ptr] == NULL && !__b2c__trap){ERROR=6; fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} } memcpy (__b2c__sbuffer[__b2c__sbuffer_ptr] + __b2c__len, __b2c__ans, __b2c__i);" TO g_HFILE
WRITELN " __b2c__len += __b2c__i;}while (__b2c__i == ", STR$(g_BUFFER_SIZE), " || __b2c__i == 1); __b2c__sbuffer[__b2c__sbuffer_ptr][__b2c__len] = '\\0';close (__b2c__wpipe[1]);" TO g_HFILE
WRITELN "close (__b2c__rpipe[0]);free (__b2c__ans);} return (__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define EXEC$(x) __b2c__exec(x)" TO g_HFILE
WRITELN "#define ENDFILE(x) feof(x)" TO g_HFILE
WRITELN "#define TELL(x) ftell(x)" TO g_HFILE
WRITELN "#define HEX$(x) __b2c__dec2hex(x)" TO g_HFILE
WRITELN "#define DEC(x) __b2c__hex2dec(x)" TO g_HFILE
WRITELN "#define ASC(x) __b2c__char2asc(x)" TO g_HFILE
WRITELN "#define CHR$(__b2c__x) __b2c__asc2char(__b2c__x)" TO g_HFILE
WRITELN "/* Dynamic loading, errors */" TO g_HFILE
WRITELN "#include <dlfcn.h>" TO g_HFILE
WRITELN "#include <errno.h>" TO g_HFILE
WRITELN "/* GETKEY */" TO g_HFILE
WRITELN "#include <termios.h>" TO g_HFILE
WRITELN "long __b2c__getch(){long __b2c__ch; struct termios __b2c__oldt, __b2c__newt; tcgetattr(0, &__b2c__oldt);" TO g_HFILE
WRITELN "__b2c__newt = __b2c__oldt; __b2c__newt.c_lflag &= ~(ICANON | ECHO); tcsetattr(0, TCSANOW, &__b2c__newt);" TO g_HFILE
WRITELN "__b2c__ch = getchar(); tcsetattr(0, TCSANOW, &__b2c__oldt); return __b2c__ch;} " TO g_HFILE
WRITELN "#define GETKEY __b2c__getch()" TO g_HFILE
WRITELN "/* Constants, logical stuff */" TO g_HFILE
WRITELN "#define PI 3.14159265" TO g_HFILE
WRITELN "#define NOT(x) (!(x))" TO g_HFILE
WRITELN "#define AND &&" TO g_HFILE
WRITELN "#define OR ||" TO g_HFILE
WRITELN "#define EQ ==" TO g_HFILE
WRITELN "#define IS ==" TO g_HFILE
WRITELN "#define NE !=" TO g_HFILE
WRITELN "#define ISNOT !=" TO g_HFILE
WRITELN "#define TRUE 1" TO g_HFILE
WRITELN "#define FALSE 0" TO g_HFILE
WRITELN "#define NL$ \"\\n\"" TO g_HFILE
WRITELN "#define STRING char*" TO g_HFILE
WRITELN "#define NUMBER long" TO g_HFILE
WRITELN "#define FLOATING double" TO g_HFILE
WRITELN "#define ISTRUE(x) (x!=0)" TO g_HFILE
WRITELN "#define ISFALSE(x) (x==0)" TO g_HFILE
WRITELN "/* Date and time */" TO g_HFILE
WRITELN "#include <time.h>" TO g_HFILE
WRITELN "#define NOW (long)time(NULL)" TO g_HFILE
WRITELN "long __b2c__time(time_t __b2c__now, int __b2c__which){struct tm *ts; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr],", STR$(g_MAX_DIGITS), ");" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, ", STR$(g_MAX_DIGITS), "); ts = localtime(&__b2c__now); switch(__b2c__which) { case 1: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%d\", ts); break;" TO g_HFILE
WRITELN "case 2: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%m\", ts); break; case 3: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%Y\", ts); break;" TO g_HFILE
WRITELN "case 4: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%H\", ts); break; case 5: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%M\", ts); break;" TO g_HFILE
WRITELN "case 6: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%S\", ts); break; case 7: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%W\", ts); break;}" TO g_HFILE
WRITELN "return(atol(__b2c__sbuffer[__b2c__sbuffer_ptr]));}" TO g_HFILE
WRITELN "#define DAY(x) __b2c__time(x, 1)" TO g_HFILE
WRITELN "#define MONTH(x) __b2c__time(x, 2)" TO g_HFILE
WRITELN "#define YEAR(x) __b2c__time(x, 3)" TO g_HFILE
WRITELN "#define HOUR(x) __b2c__time(x, 4)" TO g_HFILE
WRITELN "#define MINUTE(x) __b2c__time(x, 5)" TO g_HFILE
WRITELN "#define SECOND(x) __b2c__time(x, 6)" TO g_HFILE
WRITELN "#define WEEK(x) __b2c__time(x, 7)" TO g_HFILE
WRITELN "char* __b2c__datename(time_t __b2c__now, int __b2c__which){struct tm *ts; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ");" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, ", STR$(g_MAX_DIGITS), "); ts = localtime(&__b2c__now); switch(__b2c__which){case 1: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%A\", ts); break;" TO g_HFILE
WRITELN "case 2: strftime(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_MAX_DIGITS), ", \"%B\", ts); break;} return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define WEEKDAY$(x) __b2c__datename(x, 1)" TO g_HFILE
WRITELN "#define MONTH$(x) __b2c__datename(x, 2)" TO g_HFILE
WRITELN "unsigned long __b2c__epoch(int __b2c__year, int __b2c__month, int __b2c__day, int __b2c__hour, int __b2c__minute, int __b2c__second){" TO g_HFILE
WRITELN "struct tm tm; time_t __b2c__t; tm.tm_year = __b2c__year - 1900; tm.tm_mon = __b2c__month - 1; tm.tm_mday = __b2c__day;" TO g_HFILE
WRITELN "tm.tm_hour = __b2c__hour; tm.tm_min = __b2c__minute; tm.tm_sec = __b2c__second;" TO g_HFILE
WRITELN "tm.tm_isdst = -1; __b2c__t = mktime(&tm); if (__b2c__t == -1) return (0); return(long) __b2c__t; }" TO g_HFILE
WRITELN "#define TIMEVALUE(x,y,z,a,b,c) __b2c__epoch(x,y,z,a,b,c)" TO g_HFILE
WRITELN "char* __b2c__os(void){struct utsname __b2c__buf; __b2c__sbuffer_ptr++; if(__b2c__sbuffer_ptr >= ", STR$(g_MAX_BUFFERS), ") __b2c__sbuffer_ptr=0;" TO g_HFILE
WRITELN "__b2c__sbuffer[__b2c__sbuffer_ptr] = (char*)realloc(__b2c__sbuffer[__b2c__sbuffer_ptr], ", STR$(g_BUFFER_SIZE), ");" TO g_HFILE
WRITELN "memset(__b2c__sbuffer[__b2c__sbuffer_ptr], 0, ", STR$(g_BUFFER_SIZE), "); if(uname(&__b2c__buf) < 0 && !__b2c__trap) {ERROR = 26; fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);}" TO g_HFILE
WRITELN "strcpy(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__buf.sysname); strcat(__b2c__sbuffer[__b2c__sbuffer_ptr], \" \");" TO g_HFILE
WRITELN "strcat(__b2c__sbuffer[__b2c__sbuffer_ptr], __b2c__buf.machine); return(__b2c__sbuffer[__b2c__sbuffer_ptr]);}" TO g_HFILE
WRITELN "#define OS$ __b2c__os()" TO g_HFILE
WRITELN "/* Peek and Poke */" TO g_HFILE
WRITELN "struct stat __b2c__sb;" TO  g_HFILE
WRITELN "void __b2c__memory__check(char* __b2c__x) {if (stat(__b2c__x, &__b2c__sb) == -1 && errno == EFAULT) {ERROR = 1;} }" TO g_HFILE
WRITELN "long __b2c__malloc(long __b2c__x) {void *__b2c__mem; if(__b2c__x==0) return(0); __b2c__mem = malloc(sizeof(char)*(__b2c__x));" TO g_HFILE
WRITELN "if(__b2c__mem == NULL && !__b2c__trap) {ERROR = 6; fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} memset(__b2c__mem, 0, sizeof(char)*(__b2c__x));return(long)__b2c__mem;}" TO g_HFILE
WRITELN "#define MEMORY(__b2c__x) __b2c__malloc(__b2c__x)" TO g_HFILE
WRITELN "void __b2c__realloc(void* __b2c__x, long __b2c__y) {if(__b2c__x == NULL) return; if(!__b2c__trap) {__b2c__memory__check((char*)__b2c__x);" TO g_HFILE
WRITELN "if(ERROR) {fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} } else {__b2c__x = realloc((void*)__b2c__x, sizeof(char)*(__b2c__y));" TO g_HFILE
WRITELN "if(__b2c__x == NULL && !__b2c__trap) {ERROR = 6; fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} return;} }" TO g_HFILE
WRITELN "#define RESIZE(__b2c__x, __b2c__y) __b2c__realloc((void*)__b2c__x, __b2c__y)" TO g_HFILE
WRITELN "void __b2c__poke(char* __b2c__x, unsigned char __b2c__y) {if (!__b2c__trap){__b2c__memory__check((char*)__b2c__x); if(ERROR) {" TO g_HFILE
WRITELN "fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} } *__b2c__x = (unsigned char)__b2c__y;}" TO g_HFILE
WRITELN "#define POKE(__b2c__x, __b2c__y) __b2c__poke((char*)(__b2c__x), (unsigned char)(__b2c__y))" TO g_HFILE
WRITELN "unsigned char __b2c__peek(char* __b2c__x) {if(!__b2c__trap) {__b2c__memory__check((char*) __b2c__x); if(ERROR) {" TO g_HFILE
WRITELN "fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} } return((unsigned char)*__b2c__x);}" TO g_HFILE
WRITELN "#define PEEK(__b2c__x) __b2c__peek((char*)(__b2c__x))" TO g_HFILE
WRITELN "#define ADDRESS(__b2c__x) (long)(&__b2c__x)" TO g_HFILE
WRITELN "/* Network variables and functions */" TO g_HFILE
WRITELN "struct hostent *__b2c__he; char __b2c__data[", STR$(g_BUFFER_SIZE), "]; char *__b2c__host; char *__b2c__port; int __b2c__yes = 1; struct sockaddr_in __b2c__addr; int __b2c__result; /* Declarations for OPEN */" TO g_HFILE
WRITELN "long __b2c__netpeek(int __b2c__fd, int __b2c__usec){fd_set __b2c__rfds;struct timeval __b2c__tv;long __b2c__retval;" TO g_HFILE
WRITELN "FD_ZERO(&__b2c__rfds); FD_SET(__b2c__fd, &__b2c__rfds);__b2c__tv.tv_usec = __b2c__usec*1000;__b2c__tv.tv_sec = 0;" TO g_HFILE
WRITELN "__b2c__retval = select(__b2c__fd + 1, &__b2c__rfds, NULL, NULL, &__b2c__tv);" TO g_HFILE
WRITELN "if (__b2c__retval == -1 && !__b2c__trap) {ERROR = 16; fprintf(stderr, \"%s\\n\", ERR$(ERROR)); exit(ERROR);} return(__b2c__retval);}" TO g_HFILE
WRITELN "#define WAIT(x, y) __b2c__netpeek(x, y)" TO g_HFILE
WRITELN "/* Regex */" TO g_HFILE
WRITELN "#include <regex.h>" TO g_HFILE
WRITELN "long __b2c__regex(char* __b2c__x, char* __b2c__y){regex_t __b2c__reg; int __b2c__reti; char __b2c__buf[100]; __b2c__reti = regcomp(&__b2c__reg, __b2c__y, REG_EXTENDED|REG_NOSUB);" TO g_HFILE
WRITELN "if(!__b2c__trap && __b2c__reti){ERROR=27; fprintf(stderr, \"%s: \", ERR$(ERROR)); regerror(__b2c__reti, &__b2c__reg, __b2c__buf, sizeof(__b2c__buf)); fprintf(stderr, \"%s\\n\", __b2c__buf);" TO g_HFILE
WRITELN "exit(ERROR);} __b2c__reti = regexec(&__b2c__reg, __b2c__x, 0, NULL, 0);" TO g_HFILE
WRITELN "regfree(&__b2c__reg); if( !__b2c__reti ) return (1); else return (0);}" TO g_HFILE
WRITELN "#define REGEX(x, y) __b2c__regex(x, y)" TO g_HFILE
WRITELN "/* Declare reserved variable 'ARGUMENT$' */" TO g_HFILE
WRITELN "int __b2c__counter;" TO g_HFILE
WRITELN "int __b2c__arglen = 0;" TO g_HFILE
WRITELN "char *ARGUMENT$;" TO g_HFILE
WRITELN "/* Initialize stack arrays and pointer */" TO g_HFILE
WRITELN "char *__b2c__stringstack[", STR$(g_STACK_DEPTH), "];" TO g_HFILE
WRITELN "double __b2c__doublestack[", STR$(g_STACK_DEPTH), "];" TO g_HFILE
WRITELN "long __b2c__longstack[", STR$(g_STACK_DEPTH), "];" TO g_HFILE
WRITELN "int __b2c__typestack[", STR$(g_STACK_DEPTH), "];" TO g_HFILE
WRITELN "int __b2c__stackptr;" TO g_HFILE
' Signal function
WRITELN "/* Signal trapping activated with TRAP */" TO g_HFILE
WRITELN "void __b2c__catch_signal(int sig){" TO g_HFILE
WRITELN "switch (sig) {case SIGABRT: fprintf(stderr, \"ERROR: signal ABORT received - internal error. Try to compile the program with TRAP LOCAL to find the cause.\\n\"); break;" TO g_HFILE
WRITELN "case SIGFPE: fprintf(stderr, \"ERROR: signal for FPE received - division by zero? Examine the calculations in the program.\\n\"); break;" TO g_HFILE
WRITELN "case SIGSEGV: fprintf(stderr, \"ERROR: signal for SEGMENTATION FAULT received - memory invalid or array out of bounds? Try to compile the program with TRAP LOCAL to find the cause.\\n\"); break;" TO g_HFILE
WRITELN "case SIGILL: fprintf(stderr, \"ERROR: signal for ILLEGAL INSTRUCTION received - executing the program on other hardware? Try to recompile the program from scratch.\\n\"); break;} exit(sig);}" TO g_HFILE
' Add error function
WRITELN "/* Initialize error function */" TO g_HFILE
WRITELN "char *ERR$(int __b2c__nr){static char __b2c__warn[", STR$(g_BUFFER_SIZE), "];" TO g_HFILE
WRITELN "switch(__b2c__nr){" TO g_HFILE
WRITELN "case 0: strcpy(__b2c__warn,\"Success\"); break;" TO g_HFILE
WRITELN "case 1: strcpy(__b2c__warn,\"Trying to access illegal memory: \"); strncat(__b2c__warn,strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 2: strcpy(__b2c__warn,\"Error opening file: \"); strncat(__b2c__warn,strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 3: strcpy(__b2c__warn, \"Could not open library \"); strncat(__b2c__warn, dlerror(), ", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 4: strcpy(__b2c__warn, \"Symbol not found in library \"); strncat(__b2c__warn, dlerror(), ", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 5: strcpy(__b2c__warn, \"Wrong hexvalue: \"); strncat(__b2c__warn, strerror(errno), ", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 6: strcpy(__b2c__warn, \"Unable to claim memory.\"); break;" TO g_HFILE
WRITELN "case 7: strcpy(__b2c__warn, \"Unable to delete file: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 8: strcpy(__b2c__warn, \"Could not open directory: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 9: strcpy(__b2c__warn, \"Unable to rename file: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 10: strcpy(__b2c__warn, \"NETWORK argument should contain colon with port number\"); break;" TO g_HFILE
WRITELN "case 11: strcpy(__b2c__warn, \"Could not resolve hostname: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 12: strcpy(__b2c__warn, \"Socket error: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 13: strcpy(__b2c__warn, \"Unable to open address: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 14: strcpy(__b2c__warn, \"Error reading from socket: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 15: strcpy(__b2c__warn, \"Error sending to socket: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 16: strcpy(__b2c__warn, \"Error checking socket: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 17: strcpy(__b2c__warn, \"Unable to bind the specified socket address: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 18: strcpy(__b2c__warn, \"Unable to listen to socket address: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 19: strcpy(__b2c__warn, \"Cannot accept incoming connection: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 20: strcpy(__b2c__warn, \"Unable to remove directory: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 21: strcpy(__b2c__warn, \"Unable to create directory: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 22: strcpy(__b2c__warn, \"Unable to change to directory: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 23: strcpy(__b2c__warn, \"GETENVIRON argument does not exist as environment variable\"); break;" TO g_HFILE
WRITELN "case 24: strcpy(__b2c__warn, \"Unable to stat file: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 25: strcpy(__b2c__warn, \"Search contains illegal string\"); break;" TO g_HFILE
WRITELN "case 26: strcpy(__b2c__warn, \"Cannot return OS name: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 27: strcpy(__b2c__warn, \"Illegal regex expression\"); break;" TO g_HFILE
WRITELN "case 28: strcpy(__b2c__warn, \"Unable to create bidirectional pipes: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 29: strcpy(__b2c__warn, \"Unable to fork process: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "case 30: strcpy(__b2c__warn, \"Cannot read from pipe: \"); strncat(__b2c__warn, strerror(errno),", STR$(g_BUFFER_SIZE-48), "); break;" TO g_HFILE
WRITELN "}; ERROR = 0; return(__b2c__warn);}" TO g_HFILE
WRITELN "/* User program definitions */" TO g_HFILE

' Initialize the arrayfiles for DATA statement
OPEN STRINGARRAYFILE$ FOR WRITING AS STRINGARRAYFILE
WRITELN "char* __b2c__stringarray[] = {" TO STRINGARRAYFILE
OPEN INTARRAYFILE$ FOR WRITING AS INTARRAYFILE
WRITELN "int __b2c__intarray[] = {" TO INTARRAYFILE
OPEN FLOATARRAYFILE$ FOR WRITING AS FLOATARRAYFILE
WRITELN "double __b2c__floatarray[] = {" TO FLOATARRAYFILE

' There are no imported symbols yet
LET g_IMPORTED$ = ""

' Check if the C Preprocessor needs to run
IF ISTRUE(g_CPP) THEN
    IF ISTRUE(LEN(EXEC$("which cpp 2>/dev/null"))) THEN
	SYSTEM CONCAT$("cpp -P -w ", g_SOURCEFILE$, " ", g_SOURCEFILE$, ".cpp")
	FEED$ = CONCAT$(g_SOURCEFILE$, ".cpp")
	g_TMP_FILES$ = CONCAT$(g_TMP_FILES$, " ", g_SOURCEFILE$, ".cpp")
    ELSE
	PRINT "ERROR: the C Preprocessor 'cpp' not found on this system! Exiting..."
	END 1
    END IF
ELSE
    FEED$ = g_SOURCEFILE$
END IF
LET g_CURFILE$ = MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1)

' Initialize
LET total$ = ""
LET g_COUNTER = 1

' Read source program
OPEN FEED$ FOR READING AS g_SOURCEFILE

WHILE NOT(ENDFILE(g_SOURCEFILE)) DO

    IF NOT(g_SHEBANG) THEN
	PRINT "\rStarting conversion... ", g_COUNTER, "   ";
    END IF

    READLN line$ FROM g_SOURCEFILE

    ' Line is not empty?
    IF NOT(ENDFILE(g_SOURCEFILE)) AND LEN(line$) > 0 THEN

	IF EQUAL(RIGHT$(line$, 2), CONCAT$(" ", CHR$(92))) AND NOT(EQUAL(LEFT$(line$, 3), "REM")) AND NOT(EQUAL(LEFT$(line$, 1), "'")) THEN
	    total$ = CONCAT$(total$, LEFT$(line$, LEN(line$) - 2))
	ELSE
	    Parse_Line(CHOP$(CONCAT$(total$, " ", line$)))
	    LET total$ = ""
	END IF
    ENDIF

    g_COUNTER = g_COUNTER + 1

WEND

CLOSE FILE g_SOURCEFILE

' Finalize main C-file
WRITELN "__B2C__PROGRAM__EXIT:" TO g_CFILE
WRITELN "return 0;" TO g_CFILE
WRITELN "}" TO g_CFILE

' Finalize INT ARRAY file for DATA
WRITELN " \"\" };" TO STRINGARRAYFILE

' Finalize STRING ARRAY file for DATA
WRITELN " 0};" TO INTARRAYFILE

' Finalize FLOAT ARRAY file for DATA
WRITELN " 0.0};" TO FLOATARRAYFILE

' Include functions and subs
SPLIT g_INCLUDE_FILES$ BY " " TO incfiles$ SIZE dim
FOR i = 0 TO dim - 1
    WRITELN "#include \"", incfiles$[i], "\"" TO g_HFILE
NEXT

' Close all filehandles
CLOSE FILE FLOATARRAYFILE
CLOSE FILE INTARRAYFILE
CLOSE FILE STRINGARRAYFILE
CLOSE FILE g_HFILE
CLOSE FILE g_CFILE

IF NOT(g_SHEBANG) THEN
    PRINT "\rStarting conversion... done.   "
END IF

' Start indentation
IF ISTRUE(g_TMP_PRESERVE) THEN
    IF ISTRUE(LEN(EXEC$("which indent 2>/dev/null"))) THEN
	PRINT "Applying indentation... ";
	SPLIT g_TMP_FILES$ BY " " TO tmpfiles$ SIZE dim
	FOR i = 0 TO dim - 1
	    IF NOT(REGEX(tmpfiles$[i], ".*\\.cpp")) THEN
		IF ISTRUE(INSTR(OS$, "Darwin")) OR ISTRUE(INSTR(OS$, "BSD")) THEN
		    RENAME tmpfiles$[i] TO CONCAT$(tmpfiles$[i], ".BAK")
		    SYSTEM CONCAT$("indent ", tmpfiles$[i], ".BAK ", tmpfiles$[i])
		    DELETE FILE CONCAT$(tmpfiles$[i], ".BAK")
		ELSE
		    SYSTEM CONCAT$("indent ", tmpfiles$[i])
		    DELETE FILE CONCAT$(tmpfiles$[i], "~")
		END IF
	    END IF
	NEXT i
	PRINT "done."
    ELSE
	PRINT "WARNING: 'indent' not found on this system!"
	PRINT "Generated source code cannot be beautified."
    END IF
END IF

' Start compilation
IF ISFALSE(g_NO_COMPILE) THEN

    IF NOT(g_SHEBANG) THEN
	PRINT "Starting compilation... ";
	SYSTEM CONCAT$(g_CCNAME$, " ", g_CCFLAGS$, " -o ", LEFT$(g_SOURCEFILE$, LEN(g_SOURCEFILE$) - 4), " ", g_CFILE$, " ", g_LDFLAGS$, " > ", g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".log 2>&1")
    ELSE
	SYSTEM CONCAT$(g_CCNAME$, " ", g_CCFLAGS$, " -o ", CONCAT$(g_TEMPDIR$, "/", LEFT$(g_SOURCEFILE$, LEN(g_SOURCEFILE$) - 4)), " ", g_CFILE$, " ", g_LDFLAGS$, " > ", g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".log 2>&1")
    END IF

    ' Add temp file
    g_TMP_FILES$ = CONCAT$(g_TMP_FILES$, " ", g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".log")

    IF ISFALSE(FILELEN(CONCAT$(g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".log"))) THEN
	IF g_SHEBANG THEN
	    SYSTEM CONCAT$(g_TEMPDIR$, "/", LEFT$(g_SOURCEFILE$, LEN(g_SOURCEFILE$) - 4))
	ELSE
	    PRINT "done."
	    PRINT CONCAT$("Program '", LEFT$(g_SOURCEFILE$, LEN(g_SOURCEFILE$) - 4), "' ready.") FORMAT "%s\n"
	END IF
    ELSE
	' Only print first error
	PRINT "Compiler emits messages!"
	OPEN CONCAT$(g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".log") FOR READING AS errlog
	WHILE NOT(ENDFILE(errlog)) DO
	    READLN g_ERROR$ FROM errlog
	    IF NOT(EQUAL(LEFT$(g_ERROR$, 3), "-")) AND ISTRUE(REGEX(g_ERROR$, "\\:[0-9]+\\: error\\:")) THEN
		PRINT NL$, g_ERROR$
		BREAK
	    END IF
	WEND
	CLOSE FILE errlog

	' Non-gcc
	IF ISFALSE(LEN(g_ERROR$)) OR ISTRUE(INSTR(g_CCFLAGS$, "Wall")) OR ISFALSE(REGEX(g_ERROR$, "\\:[0-9]+\\: error\\:")) THEN
	    PRINT
	    SYSTEM CONCAT$("cat ", g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".log")
	    PRINT
	ELSE
	    ' Get the error string from the logfile
	    g_FILE_LINE = VAL(MID$(g_ERROR$, INSTR(g_ERROR$, ":") + 1, INSTR(g_ERROR$, ":", INSTR(g_ERROR$, ":") + 1) - INSTR(g_ERROR$, ":") - 1))
	    g_COUNTER = 1
	    OPEN MID$(g_ERROR$, 1, INSTR(g_ERROR$, ":") - 1) FOR READING AS errlog
	    WHILE NOT(ENDFILE(errlog)) DO
		READLN line$ FROM errlog
		IF g_COUNTER EQ g_FILE_LINE THEN
		    PRINT CONCAT$(" ---> ", line$, " <---", NL$)
		    BREAK
		END IF
		g_COUNTER = g_COUNTER + 1
	    WEND
	    CLOSE FILE errlog
	END IF
    END IF
END IF

' Cleanup
IF ISFALSE(g_TMP_PRESERVE) THEN
    SPLIT g_TMP_FILES$ BY " " TO tmpfiles$ SIZE dim
    FOR i = 0 TO dim - 1
	SYSTEM CONCAT$("rm ", tmpfiles$[i])
    NEXT i
ELIF g_CPP IS 1 THEN
    RENAME CONCAT$(g_SOURCEFILE$, ".cpp") TO CONCAT$(g_TEMPDIR$, "/", MID$(g_SOURCEFILE$, INSTRREV(g_SOURCEFILE$, "/") + 1), ".cpp")
END IF