import Foundation

enum SGFParserError: Error {
    case invalidToken
    case invalidValueType
}

enum SGFToken {
    case punctuation
    case identifier(String)
    case value(String)
    
    func toIdentifierString() -> String? {
        if case .identifier(let id) = self {
            return id
        }
        return nil
    }
    
    func toValueString() -> String? {
        if case .value(let value) = self {
            return value
        }
        return nil
    }
}

enum SGFDouble: Int {
    case normal = 1
    case emphasized = 2
}
typealias SGFText = String
typealias SGFSimpleText = String
typealias SGFColor = String
typealias SGFNone = String

/// A node class
public class SGFNode {
    /// SGF propertes as Dictionary
    var properties: [String: [String]] = [:]
    /// children of this node
    public var children: [SGFNode] = []
    
    public init() { }
    
    public subscript(id: String) -> [String]? {
        get {
            return properties[id]
        }
        set {
            properties[id] = newValue
        }
    }
    
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
    let valueRegex = "\\s*\\[((?:\\\\.|[^\\\\\\]])*)\\]\\s*"
    let lexer = Lexer(rules: [
        .regexPattern("\\s*\\(", { _ in (.punctuation, .OPEN_PARENTHESIS) }),
        .regexPattern("\\)\\s*", { _ in (.punctuation, .CLOSE_PARENTHESIS) }),
        .regexPattern(valueRegex, { str in
            let regex = try! NSRegularExpression(pattern: valueRegex)
            let match = regex.firstMatch(in: str, range: NSRange(str.startIndex..., in: str))!
            let groups = match.groups(testedString: str)
            return (.value(groups[1]), .VALUE)
        }),
        .regexPattern("\\s*;\\s*", { _ in (.punctuation, .SEMICOLUMN) }),
        .regexPattern("[A-Za-z]+", { str in (.identifier(str), .PROP_INDENT) }),
        ])
    
    try lexer.tokenize(sgf) { t in
        try parser.consume(token: t.0, code: t.1)
    }
    return try parser.endParsing()
}
