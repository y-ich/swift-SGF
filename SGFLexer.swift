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

extension Node: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(properties), \(children.count) children"
    }
}

// Create parser

let parser = SGFParser()
// parser.isTracingEnabled = true

// Create lexer

typealias Lexer = CitronLexer<(Token, SGFParser.CitronTokenCode)>

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
