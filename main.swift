// Tokenize and parse

if CommandLine.argc != 2 {
    print("filename.")
} else {
    let inputString = try String(contentsOfFile: CommandLine.arguments[1], encoding: String.Encoding.utf8)
    print(inputString)
    do {
        let tree = try parseSGF(inputString)
        print(String(reflecting: tree))
    } catch (let error) {
        print("Error during parsing: \(error)")
    }
}
