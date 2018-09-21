GRAMMAR = SGFParser
NAME = SGFParser
CC = clang
SWIFTC = swiftc
BIN = ~/OpenSources/citron/bin
SRC = ~/OpenSources/citron/src
CITRON = ${BIN}/citron

build: ${NAME}

run: ${NAME}
	./${NAME} test.sgf

clean:
	rm -rf ./${NAME} ${GRAMMAR}.swift ${CITRON}

${CITRON}: ${SRC}/citron.c
	mkdir -p ${BIN} && ${CC} $^ -o $@

${GRAMMAR}.swift: ${CITRON} ${GRAMMAR}.cy
	${CITRON} ${GRAMMAR}.cy -o $@

${NAME}: ${SRC}/CitronParser.swift ${SRC}/CitronLexer.swift ${GRAMMAR}.swift SGFLexer.swift main.swift
	${SWIFTC} $^ -o $@
