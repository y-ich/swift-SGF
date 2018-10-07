GRAMMAR = SGFParser
CC = clang
SWIFTC = swiftc
TARGET_DIR = Sources/SGF
TARGET = ${TARGET_DIR}/${GRAMMAR}.swift
BIN = ~/OpenSources/citron/bin
SRC = ~/OpenSources/citron/src
CITRON = ${BIN}/citron

build: ${TARGET}

clean:
	rm -rf ${TARGET}

${TARGET}: ${CITRON} ${GRAMMAR}.cy
	${CITRON} ${GRAMMAR}.cy -o $@
