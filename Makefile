GRAMMAR = SGFParser
CC = clang
SWIFTC = swiftc
TARGET_DIR = Sources/SGF
TARGET = ${TARGET_DIR}/${GRAMMAR}.swift
SRCS = ${TARGET_DIR}/SGFEncoder.swift ${TARGET_DIR}/SGFParserUtils.swift ${TARGET_DIR}/NSTextCheckingResultExtension.swift
CITRON = ~/OpenSources/citron/bin/citron

build: ${TARGET}

clean:
	rm -rf ${TARGET}

${TARGET}: ${CITRON} ${GRAMMAR}.cy
	${CITRON} ${GRAMMAR}.cy -o $@

test: ${TARGET} ${SRCS} ${TARGET_DIR}/CitronLexer.swift ${TARGET_DIR}/CitronParser.swift
	swift test