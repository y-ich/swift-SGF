import Foundation

enum SGFParserError: Error {
    case invalidToken
}

enum SGFToken {
    case punctuation
    case identifier(String)
    case single(String)
    case compose(String, String)

    func toIdentifierString() -> String? {
        if case .identifier(let id) = self {
            return id
        }
        return nil
    }

    func toSGFCValueType() throws -> SGFCValueType {
        switch self {
        case .single(let value):
            return .single(value)
        case .compose(let v1, let v2):
            return .compose(v1, v2)
        default:
            throw SGFParserError.invalidToken
        }
    }
}

/// CValueType
public enum SGFCValueType {
    /// represents a single value
    case single(String)
    /// represents a compose with two values
    case compose(String, String)
}

/// A node class
public class SGFNode {
    /// SGF propertes as Dictionary
    public var properties: [String: [SGFCValueType]] = [:]
    /// children of this node
    public var children: [SGFNode] = []

    public init() { }

    // returns a leaf node through primary variation
    public func primaryLeafNode() -> SGFNode {
        var node = self
        while node.children.count > 0 {
            node = node.children[0]
        }
        return node
    }
}

extension SGFNode: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\(properties), \(children.count) children"
    }
}

/**
 parses a string in SGF
 - Parameter sgf: SGF string
 - Throws: when fails to parse
 - Returns: a collection, or array with one or more SGFNodes
*/
public func parseSGF(_ sgf: String) throws -> [SGFNode] {
    let parser = SGFParser()
    // parser.isTracingEnabled = true

    typealias Lexer = CitronLexer<(SGFToken, SGFParser.CitronTokenCode)>
    let singleRegex = "\\s*\\[((?:\\\\.|[^\\\\:\\]])*)\\]\\s*"
    let composeRegex = "\\s*\\[((?:\\\\.|[^\\\\:\\]])*):((?:\\\\.|[^\\\\:\\]])*)\\]\\s*"
    let lexer = Lexer(rules: [
        .regexPattern("\\s*\\(", { _ in (.punctuation, .OPEN_PARENTHESIS) }),
        .regexPattern("\\)\\s*", { _ in (.punctuation, .CLOSE_PARENTHESIS) }),
        .regexPattern(singleRegex, { str in
            let regex = try! NSRegularExpression(pattern: singleRegex)
            let match = regex.firstMatch(in: str, range: NSMakeRange(0, str.count))!
            let groups = match.groups(testedString: str)
            return (.single(groups[1]), .SINGLE)
        }),
        .regexPattern(composeRegex, { str in
            let regex = try! NSRegularExpression(pattern: composeRegex)
            let match = regex.firstMatch(in: str, range: NSMakeRange(0, str.count))!
            let groups = match.groups(testedString: str)
            return (.compose(groups[1], groups[2]), .COMPOSE)
        }),
        .regexPattern("\\s*;", { _ in (.punctuation, .SEMICOLUMN) }),
        .regexPattern("[A-Z]+", { str in (.identifier(str), .PROP_INDENT) }),
    ])

    try lexer.tokenize(sgf) { t in
        try parser.consume(token: t.0, code: t.1)
    }
    return try parser.endParsing()
}
