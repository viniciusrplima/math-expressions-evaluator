.DEFAULT: run

EXEC_FILE=math
LEX_FILE=lex
SYNTAX_FILE=syntax


run: build
	./${EXEC_FILE}

build: syntax
	gcc ${SYNTAX_FILE}.c -o ${EXEC_FILE} -lm

syntax: lex
	bison -v -d ${SYNTAX_FILE}.y -o ${SYNTAX_FILE}.c

lex: 
	flex -t ${LEX_FILE}.l > ${LEX_FILE}.c

clean:
	rm ${EXEC_FILE} ${SYNTAX_FILE}.h ${SYNTAX_FILE}.c ${LEX_FILE}.c *.output
