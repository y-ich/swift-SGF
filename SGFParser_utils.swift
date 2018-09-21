enum SGFToken {
    case punctuation // for (, ), ->, etc.
    case identifier(String) // for identifiers
    case value(String)
    func toIdentifierString() -> String? {
        if case .identifier(let id) = self {
            return id
        }
        return nil
    }
    func toValueString() -> String? {
        if case .value(let id) = self {
            return id
        }
        return nil
    }
}

enum SGFCValueType {
    case single(String)
    case compose(String, String)
}

class SGFNode {
    var properties: [String: [SGFCValueType]] = [:]
    var children: [SGFNode] = []

}

extension SGFNode: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(properties), \(children.count) children"
    }
}

func parseSGF(_ sgf: String) throws -> [SGFNode] {
    let parser = SGFParser()
    // parser.isTracingEnabled = true

    typealias Lexer = CitronLexer<(SGFToken, SGFParser.CitronTokenCode)>

    let lexer = Lexer(rules: [
        .regexPattern("\\s*\\(", { _ in (.punctuation, .OPEN_PARENTHESIS) }),
        .regexPattern("\\)\\s*", { _ in (.punctuation, .CLOSE_PARENTHESIS) }),
        .regexPattern("\\s*\\[", { _ in (.punctuation, .OPEN_BRACKET) }),
        .regexPattern("\\]\\s*", { _ in (.punctuation, .CLOSE_BRACKET) }),
        .regexPattern("\\s*;", { _ in (.punctuation, .SEMICOLUMN) }),
        .string(":", (.punctuation, .COLUMN)),
        .regexPattern("[A-Z]+", { str in (.identifier(str), .PROP_INDENT) }),
        .regexPattern("([^:\\\\\\]]|\\\\.)*", { str in (.value(str), .VALUE) }),
    ])

    try lexer.tokenize(sgf) { t in
        try parser.consume(token: t.0, code: t.1)
    }
    return try parser.endParsing()
}
