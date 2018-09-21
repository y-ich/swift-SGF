// Tokenize and parse

if CommandLine.argc != 2 {
    print("filename.")
} else {
    let inputString = try String(contentsOfFile: CommandLine.arguments[1], encoding: String.Encoding.utf8)
    print(inputString)
    do {
        try lexer.tokenize(inputString) { t in
            try parser.consume(token: t.0, code: t.1)
        }
        let tree = try parser.endParsing()
        print(String(reflecting: tree))
    } catch (let error) {
        print("Error during parsing: \(error)")
    }
}
