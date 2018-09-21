enum Token {
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

enum CValueType {
    case single(String)
    case compose(String, String)
}

class Node {
    var properties: [String: [CValueType]] = [:]
    var children: [Node] = []
}

// Create parser

let parser = SGFParser()
// parser.isTracingEnabled = true

// Create lexer

typealias Lexer = CitronLexer<(Token, SGFParser.CitronTokenCode)>

let lexer = Lexer(rules: [
    .string("(", (.punctuation, .OPEN_PARENTHESIS)),
    .string(")", (.punctuation, .CLOSE_PARENTHESIS)),
    .string("[", (.punctuation, .OPEN_BRACKET)),
    .string("]", (.punctuation, .CLOSE_BRACKET)),
    .string(":", (.punctuation, .COLUMN)),
    .string(";", (.punctuation, .SEMICOLUMN)),
    .regexPattern("[A-Z]+", { str in (.identifier(str), .PROP_INDENT) }),
    .regexPattern("([^:\\\\\\]]|\\.)*", { str in (.value(str), .VALUE) })
])
