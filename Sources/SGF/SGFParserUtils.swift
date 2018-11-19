import Foundation

enum SGFParserError: Error {
    case invalidToken
    case invalidValueType
}

enum SGFToken {
    case punctuation
    case identifier(String)
    case value(String)
    case compose(String, String)

    func toIdentifierString() -> String? {
        if case .identifier(let id) = self {
            return id
        }
        return nil
    }

    func toSGFCValueType() throws -> SGFCValueType {
        switch self {
        case .value(let value):
            return .value(value)
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
    case value(String)
    /// represents a compose with two values
    case compose(String, String)
}

extension SGFCValueType: Equatable {
    public static func ==(lhs: SGFCValueType, rhs: SGFCValueType) -> Bool {
        if case let .value(l) = lhs, case let .value(r) = rhs {
            return l == r
        } else if case let .compose(l1, l2) = lhs, case let .compose(r1, r2) = rhs {
            return l1 == r1 && l2 == r2
        } else {
            return false
        }
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
    public var properties: [String: [SGFCValueType]] = [:]
    /// children of this node
    public var children: [SGFNode] = []

    public init() { }

    public func getValues(of ident: String) throws -> [String]? {
        return try properties[ident]?.map {
            if case let .value(value) = $0 {
                return value
            } else {
                throw SGFParserError.invalidValueType
            }
        }
    }

    public func setValues(of ident: String, values: [String]) {
        properties[ident] = values.map { .value($0) }
    }

    public func getComposes(of ident: String) throws -> [(String, String)]? {
        return try properties[ident]?.map {
            if case let .compose(v1, v2) = $0 {
                return (v1, v2)
            } else {
                throw SGFParserError.invalidValueType
            }
        }
    }

    public func setComposes(of ident: String, values: [(String, String)]) {
        properties[ident] = values.map { .compose($0.0, $0.1) }
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
    let valueRegex = "\\s*\\[((?:\\\\.|[^\\\\:\\]])*)\\]\\s*"
    let composeRegex = "\\s*\\[((?:\\\\.|[^\\\\:\\]])*):((?:\\\\.|[^\\\\:\\]])*)\\]\\s*"
    let lexer = Lexer(rules: [
        .regexPattern("\\s*\\(", { _ in (.punctuation, .OPEN_PARENTHESIS) }),
        .regexPattern("\\)\\s*", { _ in (.punctuation, .CLOSE_PARENTHESIS) }),
        .regexPattern(valueRegex, { str in
            let regex = try! NSRegularExpression(pattern: valueRegex)
            let match = regex.firstMatch(in: str, range: NSMakeRange(0, str.count))!
            let groups = match.groups(testedString: str)
            return (.value(groups[1]), .SINGLE)
        }),
        .regexPattern(composeRegex, { str in
            let regex = try! NSRegularExpression(pattern: composeRegex)
            let match = regex.firstMatch(in: str, range: NSMakeRange(0, str.count))!
            let groups = match.groups(testedString: str)
            return (.compose(groups[1], groups[2]), .COMPOSE)
        }),
        .regexPattern("\\s*;\\s*", { _ in (.punctuation, .SEMICOLUMN) }),
        .regexPattern("[A-Z]+", { str in (.identifier(str), .PROP_INDENT) }),
    ])

    try lexer.tokenize(sgf) { t in
        try parser.consume(token: t.0, code: t.1)
    }
    return try parser.endParsing()
}
