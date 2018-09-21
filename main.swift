// Tokenize and parse

if CommandLine.argc != 2 {
    print("Pass the expression to be parsed as a quoted argument.")
} else {
    let inputString = CommandLine.arguments[1]
    do {
        try lexer.tokenize(inputString) { t in
            try parser.consume(token: t.0, code: t.1)
        }
        let tree = try parser.endParsing()
        print("\(tree)")
    } catch (let error) {
        print("Error during parsing: \(error)")
    }
}
